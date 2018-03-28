@echo off

if ["%~1"]==[] goto USAGE

setlocal
set sourcepath=%~1
set targetpath=%~1\archiv
if not exist "%targetpath%\logs" md "%targetpath%\logs"

REM determine current datetime string
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined currentdate set currentdate=%%x
set currentdatestring=%currentdate:~0,4%-%currentdate:~4,2%-%currentdate:~6,2%T%currentdate:~8,2%_%currentdate:~10,2%_%currentdate:~12,2%

REM copy files
robocopy "%sourcepath%" "%targetpath%" *.txt *.wtc /M /R:5 /W:5 /log:"%targetpath%\logs\backup_%currentdatestring%.log"

pushd "%targetpath%"
REM append timestamp to '*.txt' files
for /f "delims=" %%f in ('dir /b /a-d *.txt ^| findstr /rv ".*\.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]T[0-9][0-9]_[0-9][0-9]_[0-9][0-9]\.txt$"') do ren "%%~f" "%%~nf.%currentdatestring%%%~xf%"
REM append timestamp to '*.wtc' files
for /f "delims=" %%f in ('dir /b /a-d *.wtc ^| findstr /rv ".*\.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]T[0-9][0-9]_[0-9][0-9]_[0-9][0-9]\.wtc$"') do ren "%%~f" "%%~nf.%currentdatestring%%%~xf%"
popd

REM reset values
set currentdate=
set currentdatestring=
set sourcepath=
set targetpath=

endlocal
goto :eof

:USAGE
echo Usage: %0 ^<SOURCEPATH^>
exit \B 1