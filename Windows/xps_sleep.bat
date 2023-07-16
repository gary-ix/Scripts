@echo off

REM Define the desired maximum processor frequency in MHz
set MAX_FREQUENCY=1

REM Set the maximum processor frequency on AC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCFREQMAX %MAX_FREQUENCY%

REM Set the maximum processor frequency on DC power
powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCFREQMAX %MAX_FREQUENCY%

REM Set the minimum processor state on AC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 99

REM Set the minimum processor state on DC power
powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 1

REM Reduce display brightness to 50% on AC and DC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_VIDEO VIDEONORMALLEVEL 5
powercfg /setdcvalueindex SCHEME_BALANCED SUB_VIDEO VIDEONORMALLEVEL 5

REM Apply the changes to the current power plan
powercfg /s SCHEME_BALANCED

exit