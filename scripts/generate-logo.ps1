# Generates logo.ico: a green microphone icon on a dark rounded square,
# used for the desktop shortcut and the app window icon.

Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$outputPath = Join-Path $root "logo.ico"

$size = 256
$bmp = New-Object System.Drawing.Bitmap $size,$size
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.Clear([System.Drawing.Color]::Transparent)

# Rounded square background (matches the app's header/footer color)
$bgColor = [System.Drawing.Color]::FromArgb(255,30,31,36)
$radius = 56
$d = $radius * 2
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddArc(0,0,$d,$d,180,90)
$path.AddArc($size-$d,0,$d,$d,270,90)
$path.AddArc($size-$d,$size-$d,$d,$d,0,90)
$path.AddArc(0,$size-$d,$d,$d,90,90)
$path.CloseFigure()
$bgBrush = New-Object System.Drawing.SolidBrush $bgColor
$g.FillPath($bgBrush, $path)

# Microphone glyph (matches the app's idle mic-button green)
$micColor = [System.Drawing.Color]::FromArgb(255,62,207,142)
$micBrush = New-Object System.Drawing.SolidBrush $micColor
$headW = 60
$headH = 90
$headX = ($size - $headW) / 2
$headY = 46
$hr = $headW / 2
$hd = $hr * 2
$headPath = New-Object System.Drawing.Drawing2D.GraphicsPath
$headPath.AddArc($headX,$headY,$hd,$hd,180,180)
$headPath.AddArc($headX,$headY+$headH-$hd,$hd,$hd,0,180)
$headPath.CloseFigure()
$g.FillPath($micBrush, $headPath)

# Mic stand: U-shaped bracket + stem + base line
$pen = New-Object System.Drawing.Pen $micColor, 14
$pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$standRect = New-Object System.Drawing.Rectangle ([int]($headX-18)),([int]($headY+14)),([int]($headW+36)),96
$g.DrawArc($pen, $standRect, 20, 140)

$stemX = $size / 2
$g.DrawLine($pen, $stemX, ($headY+$headH+46), $stemX, ($headY+$headH+80))
$g.DrawLine($pen, ($stemX-28), ($headY+$headH+80), ($stemX+28), ($headY+$headH+80))

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
