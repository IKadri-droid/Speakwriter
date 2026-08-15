@echo off
setlocal enabledelayedexpansion
set "ROOT=%~dp0"
set "PORT=8743"
set "URL=http://127.0.0.1:%PORT%/speakwrite.html"

rem If SpeakWritter is already open, focus that window instead of opening a
rem second one (multiple windows fight over the microphone and break dictation)
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%scripts\focus-existing-window.ps1" >nul 2>&1
if not errorlevel 1 (
  goto :eof
)

rem Start the local server only if it isn't already running (previous launch)
powershell -NoProfile -Command "try{(New-Object Net.Sockets.TcpClient).Connect('127.0.0.1',%PORT%);exit 0}catch{exit 1}" >nul 2>&1
if errorlevel 1 (
  where pythonw >nul 2>&1
  if errorlevel 1 (
    start "" /min python "%ROOT%scripts\serve.py" %PORT% "%ROOT%."
  ) else (
    start "" /min pythonw "%ROOT%scripts\serve.py" %PORT% "%ROOT%."
  )
  timeout /t 1 /nobreak >nul
)

rem Try Chromium-based browsers in order of likelihood
set "BROWSER1=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "BROWSER2=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "BROWSER3=%LocalAppData%\Google\Chrome\Application\chrome.exe"
set "BROWSER4=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
set "BROWSER5=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
set "BROWSER6=%ProgramFiles%\BraveSoftware\Brave-Browser\Application\brave.exe"
set "BROWSER7=%LocalAppData%\BraveSoftware\Brave-Browser\Application\brave.exe"
set "BROWSER8=%LocalAppData%\Vivaldi\Application\vivaldi.exe"
set "BROWSER9=%LocalAppData%\Programs\Opera\opera.exe"

for /l %%i in (1,1,9) do (
  if exist "!BROWSER%%i!" (
    start "" "!BROWSER%%i!" --app="%URL%"
    goto :eof
  )
)

rem No Chromium-based browser found: open with the system default browser.
rem Note: the microphone dictation feature needs a Chromium-based browser
rem (Chrome, Edge, Brave, Vivaldi, Opera...); Firefox and Safari do not
rem implement the Web Speech API this app relies on.
start "" "%URL%"
