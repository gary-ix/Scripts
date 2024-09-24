tell application "System Events"
  set isRunning to (name of processes) contains "Parallels Desktop"
end tell

if isRunning then
  tell application "Parallels Desktop"
    activate
    try
      set win to first window whose name is "Windows 11"
      set index of win to 1
    on error
      display dialog "Window 'Windows 11' not found."
    end try
  end tell
else
  launch application "Parallels Desktop"
  delay 1
  tell application "Parallels Desktop"
    activate
    try
      set win to first window whose name is "Windows 11"
      set index of win to 1
    on error
      display dialog "Window 'Windows 11' not found."
    end try
  end tell
end if