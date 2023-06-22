@echo off


# GPU Power Management
cd "C:\Program Files (x86)\MSI Afterburner"
start MSIAfterburner.exe -Profile1


#CPU Power Management
#Power Scheme GUIDD: 9935e61f-1661-40c5-ae2f-8495027d5d5d
#Subgroup GUID: 54533251-82be-4824-96c1-47b60b740d00
#Power Setting GUID: bc5038f7-23e0-4960-96da-33abaf5935ec  (Maximum processor state)
#Power Setting GUID: 893dee8e-2bef-41e0-89c6-b55d0929964c  (Minimum processor state)

#set min state
powercfg -setacvalueindex 9935e61f-1661-40c5-ae2f-8495027d5d5d 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100

#set max state
powercfg -setacvalueindex 9935e61f-1661-40c5-ae2f-8495027d5d5d 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100

#set changes
powercfg /setactive 9935e61f-1661-40c5-ae2f-8495027d5d5d


exit