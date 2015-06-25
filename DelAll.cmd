@echo off
setlocal
set /P RUSURE="Jetzt loeschen (J/N)?"
if /I "%RUSURE%" NEQ "J" GOTO END
set ALLGEMEIN="c:\temp\Allgemein\"
pushd %ALLGEMEIN%
for /d %%G in (*) do (
  echo "Deleting %%G..."
  rd /s /q %%G
  REM Pause, da ansonsten das Erstellen des neuen Verzeichnisses fehlschlagen kann
  timeout /t 2 /NOBREAK > NUL
  echo "Recreating %%G..."
  md %%G
)
popd
:END
endlocal
@echo on