# Elospeed StemPacker 0.3

**von Elospeed**

🇬🇧 **English:** [README.md](README.md) · 🌐 **Projektseite:** [elospeed.github.io/StemPacker/de](https://elospeed.github.io/StemPacker/de/)

Macht aus **fertigen Einzelspuren Traktor-Stem-Dateien** (`*.stem.mp4`), **ohne KI** und **im Stapel**. Pro Song braucht es einen Master und bis zu vier Stems, zum Beispiel aus der DAW, von 5.1-DVDs oder aus einem anderen Trennprogramm. Aus jedem Song wird eine Datei `<Song>.stem.mp4`, die Traktor Pro 4 direkt lädt.

Der StemPacker gehört zur Familie von [Elospeed StemMaker](https://github.com/Elospeed/StemMaker). StemMaker *trennt* Musik mit KI in Stems, der StemPacker *verpackt* Stems, die es schon gibt.

> **Stand:** Version 0.3, Version 0.1 mit 178 Songs in Traktor Pro 4 getestet. Bitte mit Kopien der eigenen Dateien arbeiten.

## Funktionen

- **Einfach-Modus:** einen Ordner aufs Fenster ziehen. Der StemPacker erkennt die Benennung selbst (`Song_drums`, `Song - Bass`, `Song (Vocals)`, `Song (A)` … `(D)`, `Song_1` … `_4` und mehr) und findet Master und Stems, auch in getrennten Unterordnern. Ohne Master-Datei wird der Master aus den Stems gemischt.
- **Oder selbst einstellen – Ordner und Namensmuster je Spur:** der Stern `*` steht für den Songnamen. Beispiel 5.1-DVD: Master `* (DOWNMIX #1)` in Ordner 1, Stems `* (A)` … `* (D)` in Ordner 2. Beispiel DAW-Export: Master `*`, Stems `*_drums`, `*_bass`, `*_other`, `*_vocals` im selben Ordner.
- **Vorlagen:** 5.1-DVD, DAW-Export, Nummern, Eigene. Unterordner auf Wunsch.
- **Eigene Stem-Namen und Farben**, die Traktor direkt anzeigt.
- **Tags und Cover vom Master** (Titel, Interpret, Album, BPM, Tonart, Label, ISRC …). Ohne Titel gilt der Songname. Cover aus dem Ordner, wenn der Master keins hat.
- **Formate:** AAC 320 kbit/s (wie Traktor), ALAC verlustfrei 16 Bit / 44,1 kHz, ALAC 24 Bit mit Original-Abtastrate (Test).
- **Master aus den Stems mischen**, **fehlende Stems still füllen**, fertige Songs überschreiben oder überspringen.
- Die Quelldateien werden nur gelesen, nie verändert. Log `logs\StemPacker.log`.
- Neun Sprachen: Deutsch, Englisch, Spanisch, Französisch, Portugiesisch (Brasilien), Italienisch, Japanisch, Niederländisch und Polnisch. Passt bei 100 % bis 200 % Windows-Skalierung.
- **Hilfreiche Prüfungen:** fehlt ein Stem, zeigt die Liste den gesuchten Dateinamen und, wenn es eine gibt, eine ähnlich heissende Datei. Ist eine Spur kürzer oder länger als der Master, gibt es eine Warnung.

## Download

`StemPacker-<Version>.zip` von der [Release-Seite](https://github.com/Elospeed/StemPacker/releases) laden, entpacken und `StemPacker.exe` starten. Es wird nichts installiert. Im ZIP:

- `StemPacker-User-Guide.pdf`: ausführliche Anleitung mit Bildern (Englisch)
- `Example\`: drei kurze Testsongs zum Ausprobieren
- `StemPlayer.exe`: fertige Stem-Dateien ohne Traktor anhören (jeder Stem stumm/solo)
- `tools\ffmpeg.exe`: FFmpeg (LGPL), macht die eigentliche Audioarbeit

Windows SmartScreen kann warnen, weil die Exe nicht signiert ist: „Weitere Informationen“ → „Trotzdem ausführen“.

## Häufige Fragen

**Meine Stem-Datei lädt nicht in ein Traktor-Track-Deck.** So arbeitet Traktor: Stem-Dateien laden nur in Stem-Decks, auch die aus dem Stem Creator von Native Instruments. Das Deck auf Stem-Deck umstellen.

**Ein Song zeigt „fehlt“.** Die Liste nennt den gesuchten Dateinamen, z. B. `Stem 2 „Hallo (B)“`, und eine ähnlich heissende Datei, wenn sie eine findet. Datei umbenennen oder Muster anpassen.

**„Achtung: Stem 2 ist 1,3 s kürzer als der Master“.** Der Song wurde trotzdem gepackt. In Traktor anhören, ob alle Stems zusammenpassen.

## Selbst bauen

Lazarus 3.8 (Free Pascal 3.2.2), keine Zusatzpakete:

```
lazbuild -B --os=win64 --cpu=x86_64 --ws=win32 src/StemPacker.lpi
```

Die Exe landet in `bin\`. Sprachdateien: `python lang-tools/i18n.py src src/lang` (Übersetzungen in `lang-tools/en.json` und `es.json`). Download-ZIP: `tools/release-zip.sh bin/StemPacker.exe ausgabe`. Jeder Push und Pull Request wird von GitHub Actions gebaut (`.github/workflows/build.yml`).

Entwickler-Dokumente: [CHANGELOG](CHANGELOG.md), [ROADMAP](ROADMAP.md), [TODO](TODO.md), [Entwicklungsregeln](docs/ENTWICKLUNGSREGELN.md), [Entwicklungslog](docs/ENTWICKLUNGSLOG.md), [Testversionen](docs/TESTVERSIONEN.md), [Ideen](docs/IDEEN.md).

## Unterstützen

Der StemPacker ist ein Ein-Personen-Hobbyprojekt. Wenn er dir Zeit spart, kannst du mir auf [Ko-fi einen Kaffee spendieren](https://ko-fi.com/elospeed) ☕. Ganz freiwillig, das Programm bleibt so oder so gratis.

## Danke

An **Cuiusquemodi** für die Idee, den Test mit 178 Songs und viele Rückmeldungen.

## Lizenz

MIT, siehe [LICENSE](LICENSE). Das Download-ZIP enthält FFmpeg (LGPL, läuft als eigenes Programm; Lizenz und Quellcode-Hinweis in `tools\`). FFmpeg ist eine Marke von Fabrice Bellard. Traktor ist eine Marke von Native Instruments; der StemPacker hat nichts mit Native Instruments zu tun.
