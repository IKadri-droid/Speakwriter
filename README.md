<div align="center">
   <img src=".github/assets/logo.png" alt="SpeakWritter logo" width="220">

   <h1>SpeakWritter</h1>

   <p>Voice-dictation notepad that runs <strong>entirely in your browser</strong>. Click the mic, talk: your words appear as text in real time.</p>

   <a href="#features">Features</a> &bull; <a href="#installation">Installation</a> &bull; <a href="#usage">Usage</a> &bull; <a href="#browser-compatibility">Browser compatibility</a>
</div>

---

## How it works

SpeakWritter is a single local web page. A small local server serves it on your own machine, and your browser's built-in speech engine turns your voice into text as you speak — punctuation and a few editing commands included. No account, no cloud, no data sent anywhere: everything happens on `127.0.0.1`, inside your browser.

## Features

- 🎙️ **Real-time dictation**, with spoken punctuation ("comma", "new line"...) and a few voice editing commands (delete last word, undo, select all).
- 🎨 **10 full themes** to restyle the whole app, including a black/white/red "Mosaïque" theme matching this project's logo.
- 🖥️ **Native app window** — no address bar, no tabs.
- 💾 **Auto-save and export** to `.txt` or clipboard.
- 📖 **Smart corrections** — a built-in tech-terms dictionary plus your own personal dictionary, kept 100% local.

## Browser compatibility

Works on **any Chromium-based browser**: Chrome, Edge, Brave, Vivaldi, Opera. The launcher opens one of these automatically.

**Firefox and Safari aren't supported** — they simply don't implement the continuous speech-recognition part of the Web Speech API yet. This isn't something SpeakWritter can work around.

## Installation

Requirements: Windows, Python (used only to run the small local server) and a Chromium-based browser.

1. Clone or download this repository.
2. Double-click `Lancer SpeakWritter.bat`.

## Usage

| Action | How |
|---|---|
| Start / stop listening | Click the mic (or press **Space**) |
| Change theme, toggle features | ⚙️ settings menu |
| Copy / save the text | Clipboard / floppy disk icon |

## License

This project is licensed under [MIT](LICENSE).
