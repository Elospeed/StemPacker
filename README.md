# Elospeed StemPacker 0.1

**by Elospeed**

🇩🇪 **Deutsche Anleitung:** [LIESMICH.md](LIESMICH.md) · 🌐 **Project page:** [elospeed.github.io/StemPacker](https://elospeed.github.io/StemPacker/)

Turns **finished single tracks into Traktor stem files** (`*.stem.mp4`), **without AI** and **in batches**. Each song needs a master and up to four stems, for example from your DAW, from 5.1 DVDs or from another separation tool. Every song becomes one file `<song>.stem.mp4` that loads straight into Traktor Pro 4.

StemPacker is part of the [Elospeed StemMaker](https://github.com/Elospeed/StemMaker) family. StemMaker *separates* your music into stems with AI; StemPacker *packs* stems you already have.

> **Status:** first test version (0.1). Please test with copies of your files.

## Features

- **Folder + name pattern per track:** the star `*` stands for the song name. Example 5.1 DVD: master `* (DOWNMIX #1)` in folder 1, stems `* (A)` … `* (D)` in folder 2. Example DAW export: master `*`, stems `*_drums`, `*_bass`, `*_other`, `*_vocals` in one folder.
- **Presets:** 5.1 DVD, DAW export, numbers, custom. Subfolders optional.
- **Your own stem names and colours**, shown directly in Traktor.
- **Tags and cover from the master** (title, artist, album, BPM, key, label, ISRC …). No title? The song name is used. Cover from the folder if the master has none.
- **Formats:** AAC 320 kbit/s (like Traktor), ALAC lossless 16 bit / 44.1 kHz, ALAC 24 bit at the original sample rate (test).
- **Mix the master from the stems**, **fill missing stems with silence**, overwrite or skip finished songs.
- Your source files are only read, never changed. Log file `logs\StemPacker.log`.
- English, German and Spanish. Works at 100 % to 200 % Windows scaling.

## Download

Get `StemPacker-<version>.zip` from the [releases page](https://github.com/Elospeed/StemPacker/releases), unzip it and start `StemPacker.exe`. Nothing is installed. The ZIP contains:

- `StemPacker-User-Guide.pdf`: full guide with pictures (English)
- `Example\`: three short test songs to try it
- `StemPlayer.exe`: listen to finished stem files without Traktor (mute/solo per stem)
- `tools\ffmpeg.exe`: FFmpeg (LGPL), does the actual audio work

Windows SmartScreen may warn because the exe is not signed: "More info" → "Run anyway".

## Building

Lazarus 3.8 (Free Pascal 3.2.2), no extra packages:

```
lazbuild -B --os=win64 --cpu=x86_64 --ws=win32 src/StemPacker.lpi
```

The exe lands in `bin\`. Language files: `python lang-tools/i18n.py src src/lang` (translations in `lang-tools/en.json` and `es.json`). Download ZIP: `tools/release-zip.sh bin/StemPacker.exe ausgabe`. Every push and pull request is built automatically by GitHub Actions (`.github/workflows/build.yml`).

Developer documents (in German): [CHANGELOG](CHANGELOG.md), [ROADMAP](ROADMAP.md), [TODO](TODO.md), [development rules](docs/ENTWICKLUNGSREGELN.md), [development log](docs/ENTWICKLUNGSLOG.md), [test builds](docs/TESTVERSIONEN.md), [ideas](docs/IDEEN.md).

## Support

StemPacker is a one-person hobby project. If it saves you some time, you can [buy me a coffee on Ko-fi](https://ko-fi.com/elospeed) ☕. Entirely optional, the tool stays free either way.

## License

MIT, see [LICENSE](LICENSE). The download ZIP contains FFmpeg (LGPL, runs as a separate program; licence and source info in `tools\`). FFmpeg is a trademark of Fabrice Bellard. Traktor is a trademark of Native Instruments; StemPacker is not affiliated with Native Instruments.
