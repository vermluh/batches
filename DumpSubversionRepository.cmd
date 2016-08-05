@echo off
setlocal

set url=
set repo_name=
set username=
set password=
set path_to_7z="c:\Program Files\7-Zip\7z.exe"

REM create target path if it does not exist
set target_path="c:\subversion dumps\"
if not exist %target_path% md %target_path%

REM determine current datetime string
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined currentdate set currentdate=%%x
set currentdatestring=%currentdate:~0,4%-%currentdate:~4,2%-%currentdate:~6,2%T%currentdate:~8,2%_%currentdate:~10,2%_%currentdate:~12,2%

set dump_file_name=%repo_name%.%currentdatestring%.dump

svnrdump dump %url%%repo_name% --username %username% --password %password% --no-auth-cache --non-interactive 2>>%target_path%\%dump_file_name%.log | %path_to_7z% a %target_path%\%dump_file_name%.7z -si%dump_file_name% >>%target_path%\%dump_file_name%.7z.log

endlocal
echo on