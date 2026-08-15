# Creates a Desktop shortcut that launches SpeakWritter as a native-looking
# app window. The shortcut targets the .bat launcher, which starts the local
# server (see serve.py) and then opens the app in a Chromium-based browser
# in --app mode (no address bar, no tabs).

$root = Split-Path -Parent $PSScriptRoot
$launcherPath = Join-Path $root "Lancer SpeakWritter.bat"
$iconPath = Join-Path $root "logo.ico"

$desktop = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktop "SpeakWritter.lnk"

$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $launcherPath
$shortcut.WorkingDirectory = $root
$shortcut.IconLocation = "$iconPath,0"
$shortcut.Description = "SpeakWritter - local voice dictation notepad"
$shortcut.WindowStyle = 7  # minimized, so the launcher's console window doesn't flash on top
$shortcut.Save()

Write-Host "Shortcut created: $shortcutPath"
