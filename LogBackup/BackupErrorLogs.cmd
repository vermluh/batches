@echo off

if [%1]==[] goto USAGE

setlocal

REM create target path if it does not exist
set targetpath=%1
if not exist %targetpath%\logs md %targetpath%\logs

REM determine current datetime string
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined currentdate set currentdate=%%x
set currentdatestring=%currentdate:~0,4%-%currentdate:~4,2%-%currentdate:~6,2%T%currentdate:~8,2%_%currentdate:~10,2%_%currentdate:~12,2%

for /f "tokens=1,2" %%a in (AnlagenMitNamen.txt) do (
  REM copy files
  robocopy "\\%%a\error_log" %targetpath%\%%a\error_log /XF "\\%%a\error_log\DONT.DELETE_OR_MOVE" /E /log:%targetpath%\logs\backup_%%b_%currentdatestring%.log
  
  REM link machine name to IP address
  if not exist %targetpath%\%%b mklink /D %targetpath%\%%b %targetpath%\%%a"
)

REM reset current datetime and datestring
set currentdate=
set currentdatestring=

endlocal
goto :eof

:USAGE
echo Usage: %0 ^<TARGETPATH^>
exit /B 1
