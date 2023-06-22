@echo off

REM Set the maximum processor frequency on AC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCFREQMAX 3500

REM Set the maximum processor frequency on DC power
powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCFREQMAX 2250

REM Reduce display brightness to 50% on AC and DC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_VIDEO VIDEONORMALLEVEL 100
powercfg /setdcvalueindex SCHEME_BALANCED SUB_VIDEO VIDEONORMALLEVEL 100

REM Apply the changes to the current power plan
powercfg /s SCHEME_BALANCED

exit