@ECHO off
SET _PollingInterval=30

:BatchStart
powershell -mta -executionpolicy unrestricted -File Launch_edit.ps1 %*

:Start
TIMEOUT /T %_PollingInterval%

SET PID=
FOR /F "tokens=2 delims= " %%i IN ('TASKLIST ^| FIND /i "CoreKeeperServer.exe"') DO SET PID=%%i
IF [%PID%]==[] (
    ECHO Application was not running. Restarting script.
    cls
    GOTO BatchStart
)
GOTO Start

GOTO:EOF