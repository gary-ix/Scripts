tell application "System Events"
  set isRunning to (name of processes) contains "Arc"
end tell

if isRunning then
  tell application "Arc" to activate
else
  launch app "Arc"
  delay "1"
end if

tell application "Arc"
  tell front window
    tell space "localhost" to focus
  end tell
end tell


