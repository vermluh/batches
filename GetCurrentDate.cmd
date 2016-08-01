@echo off
setlocal
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined mydate set mydate=%%x
set today=%mydate:~0,4%-%mydate:~4,2%-%mydate:~6,2%
echo %today%

for /f "tokens=1,2 delims==" %%i in ('wmic os get localdatetime /value 2^>NUL') do if "%%i"=="LocalDateTime" set ldtstring=%%j
if defined ldtstring set today2=%ldtstring:~0,4%-%ldtstring:~4,2%-%ldtstring:~6,2%
if defined today2 echo %today2%

for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
REM single digit numbers miss leading zero -> add leading zero
set formattedMonth=0%Month%
set formattedDay=0%Day%
REM only use the last two digits for formatting
set today3=%Year%-%formattedMonth:~-2%-%formattedDay:~-2%
echo %today3%

REM delimiter and position in string depends on locale
for /f "tokens=1-3 delims=. " %%a in ('date /t') do set today4=%%c-%%b-%%a
echo %today4%

endlocal
echo on
