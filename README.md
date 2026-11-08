# Elospeed StemPacker 0.3

**by Elospeed**

🇩🇪 **Deutsche Anleitung:** [LIESMICH.md](LIESMICH.md) · 🌐 **Project page:** [elospeed.github.io/StemPacker](https://elospeed.github.io/StemPacker/)

Turns **finished single tracks into Traktor stem files** (`*.stem.mp4`), **without AI** and **in batches**. Each song needs a master and up to four stems, for example from your DAW, from 5.1 DVDs or from another separation tool. Every song becomes one file `<song>.stem.mp4` that loads straight into Traktor Pro 4.

StemPacker is part of the [Elospeed StemMaker](https://github.com/Elospeed/StemMaker) family. StemMaker *separates* your music into stems with AI; StemPacker *packs* stems you already have.

> **Status:** version 0.3, version 0.1 tested with 178 songs in Traktor Pro 4. Please work with copies of your files.

## Features

- **Simple mode:** drop one folder onto the window. StemPacker detects the naming by itself (`Song_drums`, `Song - Bass`, `Song (Vocals)`, `Song (A)` … `(D)`, `Song_1` … `_4` and more) and finds master and stems, even in separate subfolders. Without a master file, the master is mixed from the stems.
- **Or set it yourself — folder + name pattern per track:** the star `*` stands for the song name. Example 5.1 DVD: master `* (DOWNMIX #1)` in folder 1, stems `* (A)` … `* (D)` in folder 2. Example DAW export: master `*`, stems `*_drums`, `*_bass`, `*_other`, `*_vocals` in one folder.
- **Presets:** 5.1 DVD, DAW export, numbers, custom. Subfolders optional.
- **Your own stem names and colours**, shown directly in Traktor.
- **Tags and cover from the master** (title, artist, album, BPM, key, label, ISRC …). No title? The song name is used. Cover from the folder if the master has none.
- **Formats:** AAC 320 kbit/s (like Traktor), ALAC lossless 16 bit / 44.1 kHz, ALAC 24 bit at the original sample rate (test).
- **Mix the master from the stems**, **fill missing stems with silence**, overwrite or skip finished songs.
- **Helpful checks:** if a stem is missing, the list shows the file name it looked for and a similarly named file, if there is one. A track that is shorter or longer than the master gets a warning.
- Your source files are only read, never changed. Log file `logs\StemPacker.log`.
- Nine languages: English, German, Spanish, French, Portuguese (Brazil), Italian, Japanese, Dutch and Polish. Works at 100 % to 200 % Windows scaling.

## Download

Get `StemPacker-<version>.zip` from the [releases page](https://github.com/Elospeed/StemPacker/releases), unzip it and start `StemPacker.exe`. Nothing is installed. The ZIP contains:

- `StemPacker-User-Guide.pdf`: full guide with pictures (English)
- `Example\`: three short test songs to try it
- `StemPlayer.exe`: listen to finished stem files without Traktor (mute/solo per stem)
- `tools\ffmpeg.exe`: FFmpeg (LGPL), does the actual audio work

Windows SmartScreen may warn because the exe is not signed: "More info" → "Run anyway".

## FAQ

**My stem file does not load into a Traktor track deck.** That is how Traktor works: stem files only load into stem decks, also those made by Native Instruments' own Stem Creator. Switch the deck to a stem deck.

**A song shows "missing".** The list names the file it looked for, e.g. `Stem 2 "Hello (B)"`, and a similarly named file if it finds one. Rename the file or adjust the pattern.

**"Warning: Stem 2 is 1.3 s shorter than the master".** The song was packed anyway. Listen in Traktor whether all stems are in sync.

## Building

Lazarus 3.8 (Free Pascal 3.2.2), no extra packages:

```
lazbuild -B --os=win64 --cpu=x86_64 --ws=win32 src/StemPacker.lpi
```

The exe lands in `bin\`. Language files: `python lang-tools/i18n.py src src/lang` (translations in `lang-tools/en.json` and `es.json`). Download ZIP: `tools/release-zip.sh bin/StemPacker.exe ausgabe`. Every push and pull request is built automatically by GitHub Actions (`.github/workflows/build.yml`).

Developer documents (in German): [CHANGELOG](CHANGELOG.md), [ROADMAP](ROADMAP.md), [TODO](TODO.md), [development rules](docs/ENTWICKLUNGSREGELN.md), [development log](docs/ENTWICKLUNGSLOG.md), [test builds](docs/TESTVERSIONEN.md), [ideas](docs/IDEEN.md).

## Support

StemPacker is a one-person hobby project. If it saves you some time, you can [buy me a coffee on Ko-fi](https://ko-fi.com/elospeed) ☕. Entirely optional, the tool stays free either way.

## Thanks

To **Cuiusquemodi** for the idea, the test with 178 songs and lots of feedback.

## License

MIT, see [LICENSE](LICENSE). The download ZIP contains FFmpeg (LGPL, runs as a separate program; licence and source info in `tools\`). FFmpeg is a trademark of Fabrice Bellard. Traktor is a trademark of Native Instruments; StemPacker is not affiliated with Native Instruments.
