# Changelog – Elospeed StemPacker

🇬🇧 *This file is kept in German. English readers: see the [README](README.md).*

Was erledigt ist, pro Version, neueste oben.
Die technischen Hintergründe (Fehler und wie sie gelöst wurden) stehen im [Entwicklungslog](docs/ENTWICKLUNGSLOG.md).
Version 0.1 entstand als AddOn im Repository [Elospeed/StemMaker](https://github.com/Elospeed/StemMaker) (Pull Request #110) und wurde als Vor-Release `stempacker-test-1` dort veröffentlicht.

---

## 0.1 – erste Testversion (1. November 2026)

### Neu
- **Fertige Spuren zu Traktor-Stem-Dateien, ohne KI:** pro Song ein Master und bis zu vier Stems (z. B. aus der DAW, von 5.1-DVDs oder aus einem anderen Trennprogramm) werden zu einer Datei `<Song>.stem.mp4`.
- **Im Stapel:** „Songs suchen“ findet alle Songs in den gewählten Ordnern, „Alle packen“ packt sie nacheinander.
- **Ordner und Namensmuster je Spur:** der Stern `*` steht für den Songnamen, z. B. `* (DOWNMIX #1)` für den Master und `* (A)` bis `* (D)` für die Stems. Ein leerer Ordner heisst „wie die Zeile darüber“. Unterordner auf Wunsch.
- **Vorlagen:** 5.1-DVD, DAW-Export (`*_drums` …), Nummern, Eigene.
- **Eigene Stem-Namen und Farben**, die Traktor direkt anzeigt.
- **Tags und Cover vom Master** (Titel, Interpret, Album, BPM, Tonart, Label, ISRC …), ohne Titel wird der Songname genommen. Cover auf Wunsch aus dem Ordner (`<Song>.jpg`, `cover.jpg`, `folder.jpg` …).
- **Formate:** AAC 320 kbit/s wie Traktor, ALAC verlustfrei 16 Bit / 44,1 kHz und ALAC 24 Bit mit der Original-Abtastrate (Test, in Traktor noch nicht geprüft).
- **Master aus den Stems mischen** für Songs ohne fertigen Master, **fehlende Stems still füllen**, **vorhandene überschreiben** oder überspringen.
- Log `logs\StemPacker.log`, Einstellungen in `StemPacker.ini`.
- Deutsch, Englisch, Spanisch. Fenster für 100 bis 200 % Windows-Skalierung.

### Download-ZIP
- Mit `ffmpeg.exe` (LGPL), englischer Anleitung `StemPacker-User-Guide.pdf`, Beispielordner `Example\` und dem StemPlayer aus StemMaker zum Anhören der fertigen Dateien.
