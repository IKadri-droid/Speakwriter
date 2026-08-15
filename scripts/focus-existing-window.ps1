# Looks for an already-open SpeakWritter window and brings it to the
# foreground. Exit code 0 = found & focused, 1 = not found.
#
# Having several SpeakWritter windows open at once makes them fight over
# the microphone (only one can hold it), which can leave dictation stuck
# or silently broken in every window. The launcher uses this script to
# reuse an existing window instead of opening a new one.

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class SpeakWritterWin32 {
  [DllImport("user32.dll")]
  public static extern bool SetForegroundWindow(IntPtr hWnd);
  [DllImport("user32.dll")]
  public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
  [DllImport("user32.dll")]
  public static extern bool IsIconic(IntPtr hWnd);
}
"@

$existing = Get-Process |
  Where-Object { $_.MainWindowTitle -eq 'SpeakWritter' -and $_.MainWindowHandle -ne 0 } |
  Select-Object -First 1

if ($existing) {
  if ([SpeakWritterWin32]::IsIconic($existing.MainWindowHandle)) {
    [SpeakWritterWin32]::ShowWindow($existing.MainWindowHandle, 9) | Out-Null  # SW_RESTORE
  }
  [SpeakWritterWin32]::SetForegroundWindow($existing.MainWindowHandle) | Out-Null
  exit 0
}

exit 1
