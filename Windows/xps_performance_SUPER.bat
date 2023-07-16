@echo off

REM Set the maximum processor frequency on AC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCFREQMAX 3800

REM Set the maximum processor frequency on DC power
powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCFREQMAX 3000

REM Set the minimum processor state on AC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 100

REM Set the minimum processor state on DC power
powercfg /setdcvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 1

REM Reduce display brightness to 50% on AC and DC power
powercfg /setacvalueindex SCHEME_BALANCED SUB_VIDEO VIDEONORMALLEVEL 100
powercfg /setdcvalueindex SCHEME_BALANCED SUB_VIDEO VIDEONORMALLEVEL 100

REM Apply the changes to the current power plan
powercfg /s SCHEME_BALANCED

exit