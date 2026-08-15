# SpeakWritter

SpeakWritter is a voice-dictation notepad that runs **entirely locally** in your browser. Click the mic, talk: the text is written in real time, with voice punctuation and multiple themes.

No account, no data sent anywhere other than your browser's built-in speech recognition engine. A small local server (see [Technical details](#technical-details)) just serves the app file from your own machine — nothing leaves your computer.

## Browser compatibility

SpeakWritter works on **any Chromium-based browser**: Google Chrome, Microsoft Edge, Brave, Vivaldi, Opera... The launcher tries these browsers automatically, in that order.

**Firefox and Safari are not supported** — this isn't a limitation of the app: these browsers don't implement the continuous-recognition part (`SpeechRecognition`) of the Web Speech API. No change on the app side can work around that until these browsers add the feature.

## Features

- **Real-time dictation** — text appears as you speak (interim results shown in italics below the notepad).
- **Voice punctuation** — say "comma", "period", "new line", "new paragraph", "question mark", "colon"... and SpeakWritter inserts the right symbol, with correct casing and spacing.
- **Auto-start listening** — listening starts on its own when the app opens (toggle in settings).
- **9 full themes** — every theme restyles the whole interface (not just the background): Light, Dark, Dark Wood, Light Wood, Sakura, Matte, Swiss, Sepia, Blue.
- **Native window** — launched in `--app` mode (Chrome, Edge, Brave, Vivaldi or Opera), no address bar or tabs, like a real desktop app.
- **Auto-save** — text is kept between sessions (browser local storage).
- **Export** — copy to clipboard or save as `.txt` in one click.
- **Built-in tech dictionary** — automatically fixes the casing of common tech terms dictated in French/English mix (e.g. "github" → "GitHub", "javascript" → "JavaScript"). Toggle in settings.
- **Personal dictionary** — teach SpeakWritter your own corrections on top (e.g. "pouche" → "push"). Stored only in your local browser, never in this repository.

## Installation

Requirements: Windows, Python (already installed on most machines; only used to run the small local server), and a Chromium-based browser (Chrome, Edge, Brave, Vivaldi, Opera).

1. Clone or download this repository.
2. Double-click `Lancer SpeakWritter.bat`.

The launcher starts a small local server (`http://127.0.0.1:8743`) then opens the app in a native window. See [Microphone permission](#microphone-permission) for why this server exists.

For a desktop shortcut with the app icon:

```powershell
./scripts/create-shortcut.ps1
```

## Usage

| Action | How |
|---|---|
| Start / stop listening | Click the mic button (or press **Space**) |
| Change theme | ⚙️ (settings) menu → Theme |
| Toggle voice punctuation | ⚙️ menu → Voice punctuation |
| Copy the text | Clipboard icon |
| Save as `.txt` | Floppy disk icon |
| Clear | Trash icon |

### Voice punctuation commands

`virgule` (comma) · `point` (period) · `point d'interrogation` (question mark) · `point d'exclamation` (exclamation mark) · `deux points` (colon) · `point virgule` (semicolon) · `points de suspension` (ellipsis) · `à la ligne` (new line) · `nouveau paragraphe` (new paragraph) · `ouvrez/fermez parenthèse` (open/close parenthesis) · `guillemets ouvrants/fermants` (open/close quotes) · `tiret` (dash)

*(Commands are spoken in French, matching the app's French dictation language.)*

## Built-in tech dictionary

A list of common tech terms (Git, GitHub, JavaScript, Docker, API, HTML...) shipped with the app and applied automatically to fix their casing when speech recognition transcribes them all lowercase. Toggle via ⚙️ → "Auto tech corrections". This list is part of the app's code and is shared in this repository (unlike the personal dictionary below).

## Personal dictionary

In the ⚙️ menu → Personal dictionary, add "heard word → corrected word" pairs. On every dictation, SpeakWritter automatically replaces these words before writing them (after the built-in tech dictionary, so your personal corrections always have the final say). Useful for your own recurring French/English mix-ups (e.g. `pouche` → `push`, `reposte` → `repository`).

These corrections are **100% local**: stored in your browser's `localStorage`, they never leave your machine and are never part of any file in this repository.

## Microphone permission

The first time, your browser asks for microphone access — that's normal. It won't ask again after that: the app runs on `http://127.0.0.1:8743` (a real local server, not a directly opened file), and Chromium-based browsers reliably remember permissions granted on that kind of origin — unlike pages opened as `file://`, where the permission could fail to persist across sessions.

## Project structure

```
speakwrite/
├── speakwrite.html          # The app (HTML/CSS/JS, a single file)
├── Lancer SpeakWritter.bat  # Windows launcher (starts the local server + opens the app in native mode)
├── logo.ico                 # App icon
├── scripts/
│   ├── serve.py              # Small local HTTP server (127.0.0.1)
│   ├── generate-logo.ps1     # Regenerates logo.ico
│   └── create-shortcut.ps1   # Creates the desktop shortcut
└── README.md
```

## Technical details

- Speech recognition: [Web Speech API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Speech_API) (browser engine).
- Minimal local server in Python (standard library's `http.server`, zero dependencies) to serve the app on `http://127.0.0.1:8743` instead of `file://`.
- No build step, no JS dependencies: a self-contained HTML file.
- Icon generated via `System.Drawing` (.NET) in PowerShell.

## License

This project is licensed under [MIT](LICENSE).
