@echo off
REM Set the desired power management mode (0 - Adaptive, 1 - Prefer Maximum Performance, 2 - Auto)
set powerMode=1

REM Run nvidia-smi to set the power management mode
"C:\Windows\System32\nvidia-smi.exe" -pm %powerMode%


REM Display the result
if %errorlevel%==0 (
    echo Power management mode set successfully.
) else (
    echo Error setting power management mode.
)

REM Pause to see the result
pause
