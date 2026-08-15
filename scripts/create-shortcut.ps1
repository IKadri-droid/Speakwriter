# Creates a Desktop shortcut that launches SpeakWritter as a native-looking
# app window (Chrome/Edge in --app mode: no address bar, no tabs).

$root = Split-Path -Parent $PSScriptRoot
$htmlPath = Join-Path $root "speakwrite.html"
$iconPath = Join-Path $root "logo.ico"
$url = "file:///" + $htmlPath.Replace('\','/')

$browserCandidates = @(
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
  "$env:LocalAppData\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
)
$browser = $browserCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1

if(-not $browser){
  Write-Error "Neither Chrome nor Edge was found. Install one of them first."
  exit 1
}

$desktop = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktop "SpeakWritter.lnk"

$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $browser
$shortcut.Arguments = "--app=`"$url`""
$shortcut.WorkingDirectory = $root
$shortcut.IconLocation = "$iconPath,0"
$shortcut.Description = "SpeakWritter - local voice dictation notepad"
$shortcut.WindowStyle = 1
$shortcut.Save()

Write-Host "Shortcut created: $shortcutPath"
