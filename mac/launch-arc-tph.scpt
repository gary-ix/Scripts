tell application "System Events"
    tell process "Arc"
        set windowList to windows
        repeat with w in windowList
            set windowName to name of w
              if windowName does not contain "." then
                -- display dialog windowName
                perform action "AXRaise" of w
            end if
        end repeat
    end tell          
end tell

tell application "Arc" to activate
tell application "Arc"
  tell front window 
    tell space "TPH" to focus
  end tell
end tell
