@echo off
setlocal
set "HTML=%~dp0speakwrite.html"
set "URL=file:///%HTML:\=/%"

set "CHROME1=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHROME2=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "CHROME3=%LocalAppData%\Google\Chrome\Application\chrome.exe"
set "EDGE1=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
set "EDGE2=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"

if exist "%CHROME1%" (
  start "" "%CHROME1%" --app="%URL%"
  goto :eof
)
if exist "%CHROME2%" (
  start "" "%CHROME2%" --app="%URL%"
  goto :eof
)
if exist "%CHROME3%" (
  start "" "%CHROME3%" --app="%URL%"
  goto :eof
)
if exist "%EDGE1%" (
  start "" "%EDGE1%" --app="%URL%"
  goto :eof
)
if exist "%EDGE2%" (
  start "" "%EDGE2%" --app="%URL%"
  goto :eof
)

start "" "%HTML%"
