# Testversionen

🇬🇧 *This file is kept in German. English readers: see the [README](../README.md).*

Testversionen sind fertig gebaute Programme zum **Ausprobieren**, bevor sie in ein offizielles Release kommen.
Sie werden automatisch von **GitHub Actions** gebaut, aber **nicht öffentlich auf GitHub veröffentlicht** (keine Vor-Releases).
Der Workflow steht in [`.github/workflows/build.yml`](../.github/workflows/build.yml).

## Wie es abläuft

1. Jeder Pull Request und jeder Push auf `main` baut `StemPacker.exe` (64 Bit) und das ZIP für die Release-Seite. Vorher prüft der Workflow, dass die Version überall gleich ist (`tools/versionen-pruefen.sh`) und die Sprachdateien vollständig und aktuell sind (`lang-tools/i18n.py`). Schlägt etwas fehl, ist der PR rot.
2. Exe, ZIP und `SHA256SUMS.txt` hängen als **Artefakt** am Build-Lauf unter *Actions* (nur mit GitHub-Login, 14 Tage).
3. Wer testet, bekommt das ZIP mit kurzer Anleitung im privaten Projektordner. Vorher: Build grün abwarten, Artefakt herunterladen, SHA-256 prüfen und das Programm kurz starten (bei 100 % und 150 % Windows-Skalierung, siehe [Entwicklungsregeln](ENTWICKLUNGSREGELN.md)).

## So testen

- ZIP entpacken und `StemPacker.exe` starten, der Ordner `lang\` bleibt daneben.
- Zuerst den Ordner `Example\` packen (Vorlage „5.1 DVD“), dann **Kopien** einiger echter Songs.
- Die fertigen Dateien mit `StemPlayer.exe` anhören und in Traktor Pro 4 laden: vier Stems mit den eingestellten Namen und Farben, Titel, Interpret und Cover.

Die Exe ist nicht signiert. Windows SmartScreen warnt deshalb: „Weitere Informationen“ → „Trotzdem ausführen“.

## Ausnahme: Vor-Release für externe Tester

Für den ersten Tester (Version 0.1) gab es auf Speedys Wunsch ein Vor-Release `stempacker-test-1` im StemMaker-Repository, wie beim Turbo-Test. Der Tag beginnt bewusst nicht mit `test-`, sonst löscht ihn der Aufräum-Job.

## Offizielles Release

- Speedy startet das Release selbst: Actions → „Release erstellen“ → Run workflow → Version (z. B. `0.2`). Der Workflow `.github/workflows/release.yml` prüft die Version, baut das ZIP `StemPacker-<Version>.zip` neu, legt das Release `v<Version>` mit dem CHANGELOG-Abschnitt und der SHA-256 als Text an und hängt das ZIP an. Kein Ko-fi- oder Spendenhinweis im Release-Text.
- Testversionen gehören nicht ins Repository: jede eingecheckte Exe bliebe für immer im Git-Verlauf.
