@echo off
if [%1]==[] goto USAGE
set targetpath=%1
if not exist %targetpath%\logs md %targetpath%\logs
for /f "tokens=1,2" %%a in (AddressesAndNames.txt) do (
  robocopy "\\%%a\error_log" %targetpath%\%%a\error_log /XF "\\%%a\error_log\DONT.DELETE_OR_MOVE" /E /log+:%targetpath%\logs\backup.%%a_%%b.log
  if not exist %targetpath%\%%b mklink /D %targetpath%\%%b %targetpath%\%%a"
)
goto :eof
:USAGE
@echo Usage: %0 ^<TARGETPATH^>
exit /B 1