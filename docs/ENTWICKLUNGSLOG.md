# Entwicklungslog – Elospeed StemPacker

🇬🇧 *This file is kept in German. English readers: see the [README](../README.md).*

Technische Hintergründe, Fehler und Lehren. Was für Benutzer neu ist, steht im [CHANGELOG](../CHANGELOG.md).

## Herkunft und gemeinsame Units

- Version 0.1 entstand im StemMaker-Repository (`src/AddOns/StemPacker`, PR #110), ausgelöst durch einen Nutzer auf Reddit (r/surround) mit 178 Songs von 5.1-DVDs: je ein Downmix und vier Kanalpaare A–D als WAV.
- Kopien aus StemMaker: `ustemmp4.pas` (Stem-Block in die MP4 schreiben, Spuren zählen), `ustatusdraw.pas` (Ko-fi-Knopf), `uskalierung.pas` (Windows-Skalierung). `ulang.pas` und `lang-tools/i18n.py` kommen aus dem StemTagger (Sprache aus Windows, wenn es eine `.po` dafür gibt). Fixes dort hier nachziehen und umgekehrt.
- Der StemPlayer im ZIP stammt aus dem StemMaker-Release (`tools/release-zip.sh`, Prüfsumme). Er liest dieselben `lang\<code>.po`; darum hängt das Skript seine Texte aus dem StemMaker-Release an die Sprachdateien des StemPackers an.

## Aufbau

- `packmatch.pas`: Songs finden. Pro Rolle (Master, Stem 1–4) Ordner und Muster, `*` = Songname. Eine Datei, die auf ein Stem-Muster im selben Ordner passt, zählt nie als Master (sonst wäre `Song_drums.wav` ein eigener Song).
- `packjob.pas`: ffmpeg-Aufruf. Eingang 0 = Tag-Quelle (Master, sonst erster Stem). Fehlender Stem = Kopie der Tag-Quelle mit `volume=0` (gleich lang). Master mischen = `amix ... normalize=0`. Immer `-ac 2` (Mono-Kanäle wie LFE oder Center auf beide Seiten). Nur Spur 1 ist `default`, damit normale Player nur den Master spielen.
- `packerform.pas`: Fenster im Code aufgebaut, Zeilen mit `Align`, `StelleAufBildschirmDPI(Self)` + `Scale96ToForm`. Grösse in 96-dpi-Einheiten in der INI.

## Stolperfallen

- ffmpeg liest Tags und Cover auch aus dem ID3-Block einer WAV-Datei (geprüft).
- Unter Wine Pfade mit Umlauten nur mit `LANG=C.UTF-8` testen, sonst verstümmelt Wine sie (kein Programmfehler).
- ICO-Dateien mit PNG-Einträgen (z. B. von Pillow) bringen die LCL zum Absturz („Bitmap with unknown compression“); das Symbol ist mit ImageMagick als BMP-Einträge plus PNG nur bei 256 px gebaut.
- Unit-Name und globale Formularvariable dürfen nicht gleich heissen (`packerform` / `MainPacker`).
