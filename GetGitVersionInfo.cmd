@echo off
setlocal ENABLEDELAYEDEXPANSION
set BRANCH=
for /f %%i in ('git symbolic-ref HEAD 2^> nul') do set BRANCH=%%i
set BRANCH=!BRANCH:~11!

git log --pretty=format:\"%%h\" -1 > hash
set /p HASH=<hash
del hash
set HASH=!HASH:~1,-1!

echo %BRANCH%-%HASH%
endlocal
echo on