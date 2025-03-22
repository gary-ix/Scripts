tell application "System Events"
    set frontProcess to first process whose frontmost is true
    set frontAppName to name of frontProcess
    
    -- Get combined screen dimensions
    tell application "Finder"
        set allScreenBounds to bounds of window of desktop
    end tell
    
    tell process frontAppName
        set frontWindow to first window
        
        -- Set position to top-left corner of first display
        set position of frontWindow to {0, 0}
        
        -- Get the total width of all screens and use full height
        set combinedWidth to item 3 of allScreenBounds
        set screenHeight to (item 4 of allScreenBounds) * 2 - 500
        display dialog screenHeight
        
        -- Set size to span across displays
        set size of frontWindow to {combinedWidth, screenHeight}
    end tell
end tell