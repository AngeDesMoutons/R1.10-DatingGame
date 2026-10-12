@echo off
REM ==================================================================
REM  Installe Git et Tweego dans .\tools (sans droits administrateur)
REM ==================================================================
cd /d "%~dp0"
set "ROOT=%~dp0"
set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.56.0.windows.2/PortableGit-2.56.0.2-64-bit.7z.exe"
set "TWEEGO_URL=https://github.com/tmedwards/tweego/releases/download/v2.1.1/tweego-2.1.1-windows-x64.zip"
set "DL=powershell -NoProfile -ExecutionPolicy Bypass -Command $ProgressPreference='SilentlyContinue'; [Net.ServicePointManager]::SecurityProtocol='Tls12'; Invoke-WebRequest -UseBasicParsing"

if not exist tools mkdir tools

echo.
echo [1/2] Git
if exist "tools\git\cmd\git.exe" (
  echo     Deja installe.
) else (
  echo     Telechargement...
  %DL% '%GIT_URL%' -OutFile 'tools\git.7z.exe'
  if errorlevel 1 goto erreur
  echo     Extraction, 1 a 3 minutes...
  start "" /wait "tools\git.7z.exe" -o"%ROOT%tools\git" -y
  del "tools\git.7z.exe"
  if not exist "tools\git\cmd\git.exe" goto erreur
  echo     OK
)

echo.
echo [2/2] Tweego
if exist "tools\tweego\tweego.exe" (
  echo     Deja installe.
) else (
  echo     Telechargement...
  %DL% '%TWEEGO_URL%' -OutFile 'tools\tweego.zip'
  if errorlevel 1 goto erreur
  powershell -NoProfile -Command "Expand-Archive -Force 'tools\tweego.zip' 'tools\tweego'"
  del "tools\tweego.zip"
  if not exist "tools\tweego\tweego.exe" goto erreur
  echo     OK
)

if not exist dist mkdir dist

chcp 65001 >nul
echo.
echo ============================================================
echo                 INSTALLATION TERMINEE !
echo ============================================================
echo.
echo  Compilation du projet :
echo.
echo  .\tools\tweego\tweego.exe -o dist/index.html src --watch
echo.
echo ------------------------------------------------------------
echo  CONFIGURATION DE GIT DANS VISUAL STUDIO CODE
echo ------------------------------------------------------------
echo.
echo  Si Git n'est pas reconnu dans VS Code, suis ces etapes :
echo.
echo  [1] Ouvre les parametres :
echo      Fichier ^> Preferences ^> Parametres
echo.
echo  [2] Recherche : git.path
echo.
echo  [3] Ouvre le fichier settings.json et ajoute ton chemin adapté pour toi, exemple :
echo.
echo      "git.path": "C:\\Users\\alberang\\Documents\\Simulator Dating\\tools\\git\\cmd\\git.exe"
echo.
echo  [4] Enregistre le fichier et redemarre VS Code.
echo.
pause
exit /b 0

:erreur
echo.
echo ERREUR pendant l'installation. Relance le script ou envoie une capture de cette fenetre.
pause
exit /b 1