#!/usr/bin/osascript

# @raycast.title Launch Arc Personal
# @raycast.author Garrett M
# @raycast.authorURL https://github.com/theprogrammergary
# @raycast.description Open Arc Space Personal

# @raycast.icon 
# @raycast.mode silent
# @raycast.packageName Launch Arc Space Personal
# @raycast.schemaVersion 1


tell application "System Events"
    tell process "Arc"
        set windowList to windows
        repeat with w in windowList
            set windowName to name of w
              if windowName contains "." then
                -- display dialog windowName
                perform action "AXRaise" of w
              end if
        end repeat
    end tell          
end tell

tell application "Arc" to activate
tell application "Arc"
  tell front window 
    tell space "." to focus
  end tell
end tell
