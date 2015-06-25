@echo off
REM  --------------------------------------------------------------------------
REM | Skript zum leeren der Ordnerstruktur unterhalb des in der Variablen      |
REM | %ALLGEMEIN% angegebenen Verzeichnisses. Nach dem Löschen wird die erste  |
REM | Kindebene unterhalb des Verzeichnisses wieder hergestellt.               |
REM  --------------------------------------------------------------------------

setlocal enabledelayedexpansion
set ALLGEMEIN="c:\temp\Allgemein\"
pushd %ALLGEMEIN%

:READ
echo suche Ordner...
set LIST=
for /d %%d in (*) do ( 
  echo '%%d' gefunden
  set LIST=!LIST! %%d 
)
set /P R_U_SURE="Jetzt leeren (J/N)?"
if /I "%R_U_SURE%" NEQ "J" GOTO END

:DELETE
echo.
echo leeren...
for /d %%d in (%LIST%) do (
  echo entferne '%%d'
  rd /s /q %%d
)

:REBUILD
echo.
echo Struktur neu aufbauen...
for /d %%d in (%LIST%) do (
  echo erstelle '%%d'
  md %%d
)

:END
popd
endlocal
@echo on