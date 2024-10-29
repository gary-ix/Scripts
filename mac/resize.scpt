tell application "System Events"
    set frontProcess to first process whose frontmost is true
    set frontAppName to name of frontProcess
    
    tell process frontAppName
        set frontWindow to first window
        
        -- Get screen dimensions
        tell application "Finder"
            set screenBounds to bounds of window of desktop
        end tell
        
        -- Set position to top-left corner
        set position of frontWindow to {0, 0}
        
        -- Set size to full screen dimensions
        set size of frontWindow to {item 3 of screenBounds, item 4 of screenBounds}
    end tell
end tell