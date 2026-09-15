# Generates logo.ico: a pixel-mosaic microphone on a black square,
# matching the project logo (.github/assets/logo.png) - used for the
# desktop shortcut and the app window icon.

Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$outputPath = Join-Path $root "logo.ico"

$size = 256
$bmp = New-Object System.Drawing.Bitmap $size,$size
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
$g.Clear([System.Drawing.Color]::Black)

$white = [System.Drawing.Color]::FromArgb(255,255,255,255)
$red = [System.Drawing.Color]::FromArgb(255,176,20,27)
$whiteBrush = New-Object System.Drawing.SolidBrush $white
$redBrush = New-Object System.Drawing.SolidBrush $red

# Microphone as a grid of squares (col, row), row 0 = top.
# Cols 0-9, rows 0-11. The top cap is red, the rest of the glyph is white.
$pitch = 17
$square = 15
$gridW = 10
$gridH = 12
$marginX = ($size - $gridW * $pitch) / 2
$marginY = ($size - $gridH * $pitch) / 2

function Add-Cell($cells, $col, $row) {
    $cells.Add(@($col, $row)) | Out-Null
}

$redCells = New-Object System.Collections.ArrayList
$whiteCells = New-Object System.Collections.ArrayList

# Capsule top cap (red)
foreach ($col in 3..6) { Add-Cell $redCells $col 0 }

# Capsule body (white)
foreach ($row in 1..4) {
    foreach ($col in 2..7) { Add-Cell $whiteCells $col $row }
}
foreach ($col in 3..6) { Add-Cell $whiteCells $col 5 }

# Stem
foreach ($row in 6..9) {
    foreach ($col in 4..5) { Add-Cell $whiteCells $col $row }
}

# Base
foreach ($col in 1..8) { Add-Cell $whiteCells $col 10 }
foreach ($col in 2..7) { Add-Cell $whiteCells $col 11 }

function Draw-Cells($cells, $brush) {
    foreach ($cell in $cells) {
        $x = $marginX + $cell[0] * $pitch
        $y = $marginY + $cell[1] * $pitch
        $g.FillRectangle($brush, $x, $y, $square, $square)
    }
}

Draw-Cells $whiteCells $whiteBrush
Draw-Cells $redCells $redBrush

$g.Dispose()

# Encode as PNG, then wrap it in a minimal single-image ICO container
# (Windows Vista+ supports PNG-compressed icon entries in .ico files)
$ms = New-Object System.IO.MemoryStream
$bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
$pngBytes = $ms.ToArray()
$bmp.Dispose()

$fs = [System.IO.File]::Open($outputPath, [System.IO.FileMode]::Create)
$bw = New-Object System.IO.BinaryWriter $fs
$bw.Write([UInt16]0)                 # ICONDIR.reserved
$bw.Write([UInt16]1)                 # ICONDIR.type = icon
$bw.Write([UInt16]1)                 # ICONDIR.count = 1 image
$bw.Write([byte]0)                   # width  (0 = 256px)
$bw.Write([byte]0)                   # height (0 = 256px)
$bw.Write([byte]0)                   # color count
$bw.Write([byte]0)                   # reserved
$bw.Write([UInt16]1)                 # color planes
$bw.Write([UInt16]32)                # bits per pixel
$bw.Write([UInt32]$pngBytes.Length)  # image data size
$bw.Write([UInt32]22)                # offset to image data (6 + 16 byte headers)
$bw.Write($pngBytes)
$bw.Flush()
$bw.Close()
$fs.Close()

Write-Host "Icon written to $outputPath"
