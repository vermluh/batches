@echo off
setlocal ENABLEDELAYEDEXPANSION
set BRANCH=
REM extract branch name
for /f %%i in ('git symbolic-ref HEAD 2^> nul') do set BRANCH=%%i
REM and store in BRANCH variable
set BRANCH=!BRANCH:~11!

REM read latest abbreviated commit hash
git log --pretty=format:\"%%h\" -1 > hash
REM and store in hash variable
set /p HASH=<hash
del hash
REM remove double quotes
set HASH=!HASH:~1,-1!

REM concat branch and commit hash strings
echo %BRANCH%-%HASH%
endlocal
echo on