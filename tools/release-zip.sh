#!/usr/bin/env bash
# Baut das Download-ZIP für den StemPacker (StemPacker.exe).
# Läuft auf dem Windows-Rechner von GitHub in Git-Bash (siehe .github/workflows/build.yml),
# geht aber auch unter Linux.
#
#   tools/release-zip.sh <StemPacker.exe> <Ausgabeordner>
#
# Inhalt (Ordner StemPacker\):
#   StemPacker.exe, StemPlayer.exe (zum Anhören der fertigen Dateien, aus dem
#   StemMaker-Release, Prüfsumme wird kontrolliert), LIESMICH.txt (DE), README.txt (EN), LICENSE.txt,
#   StemPacker-User-Guide.pdf (englische Anleitung mit Bildern, Quelle in docs/anleitung/),
#   Example\ (3 kurze Testton-Songs im 5.1-DVD-Namensschema, hier erzeugt),
#   lang\*.po (Englisch, Spanisch; Deutsch steckt in der Exe),
#   tools\ffmpeg.exe + Lizenz und Quellcode-Hinweis (LGPL-Build aus unserem
#   Release ffmpeg-9.0.2, Prüfsumme wird kontrolliert).
# Keine KI-Modelle: der StemPacker trennt nichts, er verpackt nur.
# Die Version kommt aus APP_VER in packerform.pas.
#
# Ergebnis: <Ausgabeordner>/StemPacker-<Version>.zip
set -euo pipefail

EXE=$(realpath "$1"); mkdir -p "$2"; AUS=$(realpath "$2")
REPO=$(cd "$(dirname "$0")/.." && pwd)
SRC="$REPO/src"
VERSION=$(sed -n "s/^ *APP_VER *= *'\(.*\)';.*/\1/p" "$SRC/packerform.pas" | head -n 1 | tr -d '\r')
[ -n "$VERSION" ] || { echo "APP_VER in packerform.pas nicht gefunden"; exit 1; }

FFMPEG_URL="https://github.com/Elospeed/StemMaker/releases/download/ffmpeg-9.0.2/ffmpeg-9.0.2-win64-lgpl.zip"
FFMPEG_SHA="d350ded1fd523fdae90064c11b954497d2ba8f9ef3b10a2447f6717acc210af0"
# StemPlayer kommt aus dem StemMaker-Release (eigenes Repo Elospeed/StemMaker).
# Neue Version: URL, Prüfsumme und Pfad im ZIP hier anpassen.
PLAYER_URL="https://github.com/Elospeed/StemMaker/releases/download/v2.1.1/StemMaker-2.1.1.zip"
PLAYER_SHA="c1cc3a359aa2c9489b941d3eb8beebd501548dad899fba51abab2077eccf8f73"
PLAYER_IN_ZIP="StemMaker/AddOns/StemPlayer.exe"

ARBEIT=$(mktemp -d)
trap 'rm -rf "$ARBEIT"' EXIT
ZIEL="$ARBEIT/StemPacker"
mkdir -p "$ZIEL/tools" "$ZIEL/lang"

PY=$(command -v python || command -v python3)

# ffmpeg holen und Prüfsumme kontrollieren
curl -sSfL -o "$ARBEIT/ffmpeg.zip" "$FFMPEG_URL"
echo "$FFMPEG_SHA  $ARBEIT/ffmpeg.zip" | sha256sum -c -
"$PY" - "$ARBEIT/ffmpeg.zip" "$ARBEIT/ff" <<'PY'
import sys, zipfile
zipfile.ZipFile(sys.argv[1]).extractall(sys.argv[2])
PY
FF="$ARBEIT/ff/ffmpeg-9.0.2-win64-lgpl"
cp "$FF/ffmpeg.exe" "$ZIEL/tools/ffmpeg.exe"

# Textdateien mit Windows-Zeilenenden (Notepad)
crlf() { sed 's/\r$//; s/$/\r/' "$1" > "$2"; }
crlf "$FF/LICENSE.txt"           "$ZIEL/tools/FFMPEG-LICENSE.txt"
crlf "$FF/QUELLCODE-SOURCE.txt"  "$ZIEL/tools/FFMPEG-SOURCE.txt"
crlf "$SRC/LIESMICH.txt"         "$ZIEL/LIESMICH.txt"
crlf "$SRC/README.txt"           "$ZIEL/README.txt"
crlf "$REPO/LICENSE"             "$ZIEL/LICENSE.txt"
cp "$SRC"/lang/*.po "$ZIEL/lang/"
cp "$EXE" "$ZIEL/StemPacker.exe"
cp "$REPO/docs/anleitung/StemPacker-User-Guide.pdf" "$ZIEL/"

# StemPlayer aus dem StemMaker-Release holen und Prüfsumme kontrollieren
curl -sSfL -o "$ARBEIT/stemmaker.zip" "$PLAYER_URL"
echo "$PLAYER_SHA  $ARBEIT/stemmaker.zip" | sha256sum -c -
"$PY" - "$ARBEIT/stemmaker.zip" "$PLAYER_IN_ZIP" "$ZIEL/StemPlayer.exe" <<'PY'
import sys, zipfile
with zipfile.ZipFile(sys.argv[1]) as z, open(sys.argv[3], "wb") as f:
    f.write(z.read(sys.argv[2]))
PY

# Der StemPlayer liest dieselben lang\<code>.po wie der StemPacker. Darum
# kommen seine Texte (aus dem StemMaker-Release) mit in die Sprachdateien;
# bei gleichem deutschem Text gilt die StemPacker-Übersetzung.
"$PY" - "$ARBEIT/stemmaker.zip" "$ZIEL/lang" <<'PY'
import os, re, sys, zipfile
zipname, langdir = sys.argv[1], sys.argv[2]
def eintraege(text):
    # Blöcke durch Leerzeilen getrennt; msgid kann über mehrere Zeilen gehen
    for block in re.split(r"\n\s*\n", text.replace("\r", "")):
        m = re.search(r'^msgid ((?:".*"\n?)+)', block, re.M)
        if m:
            yield m.group(1).strip(), block.strip()
with zipfile.ZipFile(zipname) as z:
    for po in sorted(os.listdir(langdir)):
        if not po.endswith(".po"):
            continue
        name = "StemMaker/lang/" + po
        if name not in z.namelist():
            continue
        eigen = open(os.path.join(langdir, po), encoding="utf-8").read()
        schon = {k for k, _ in eintraege(eigen)}
        dazu = [b for k, b in eintraege(z.read(name).decode("utf-8"))
                if k != '""' and k not in schon]
        with open(os.path.join(langdir, po), "a", encoding="utf-8") as f:
            f.write("\n# --- StemPlayer (aus dem StemMaker-Release) ---\n\n")
            f.write("\n\n".join(dazu) + "\n")
        print(f"{po}: {len(dazu)} Texte vom StemPlayer dazu")
PY

# Beispiel im Namensschema 5.1-DVD: Downmix\Song (DOWNMIX #1).wav und
# Channels\Song (A..D).wav, je 5 Sekunden Testton (A und D Stereo, B und C Mono)
TESTFF="${FFMPEG_TEST:-$ZIEL/tools/ffmpeg.exe}"
BSP="$ZIEL/Example"
mkdir -p "$BSP/Downmix" "$BSP/Channels"
winpfad() { if command -v cygpath >/dev/null; then cygpath -w "$1"; else echo "$1"; fi; }
i=0
for SONG in "Song One" "Song Two" "Song Three"; do
  i=$((i + 1))
  MSYS_NO_PATHCONV=1 "$TESTFF" -hide_banner -loglevel error -y -f lavfi \
    -i "sine=frequency=$((200 + i * 60)):sample_rate=48000:duration=5" -ac 2 \
    "$(winpfad "$BSP/Downmix/$SONG (DOWNMIX #1).wav")"
  k=0
  for C in A B C D; do
    k=$((k + 1))
    KAN=1; if [ "$C" = A ] || [ "$C" = D ]; then KAN=2; fi
    MSYS_NO_PATHCONV=1 "$TESTFF" -hide_banner -loglevel error -y -f lavfi \
      -i "sine=frequency=$((k * 150 + i * 20)):sample_rate=48000:duration=5" -ac $KAN \
      "$(winpfad "$BSP/Channels/$SONG ($C).wav")"
  done
done
crlf "$REPO/docs/anleitung/Example-README.txt" "$BSP/How-to-use-the-example.txt"

ZIPNAME="$AUS/StemPacker-$VERSION.zip"
rm -f "$ZIPNAME"
"$PY" - "$ARBEIT" "$ZIPNAME" <<'PY'
import os, sys, zipfile
basis, ziel = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(ziel, "w", zipfile.ZIP_DEFLATED, compresslevel=9) as z:
    for ordner, _, dateien in os.walk(os.path.join(basis, "StemPacker")):
        for d in sorted(dateien):
            pfad = os.path.join(ordner, d)
            z.write(pfad, os.path.relpath(pfad, basis))
PY
echo "Fertig: $ZIPNAME"
