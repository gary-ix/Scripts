tell application "Arc" to activate

tell application "System Events"
    tell process "Arc"
        set windowList to windows
        repeat with w in windowList
            set windowName to name of w
            if windowName contains "." then
                -- display dialog "Found"
                perform action "AXRaise" of w
                exit repeat
            end if
        end repeat
    end tell          
end tell