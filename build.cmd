@ECHO OFF
CHCP 65001 > NUL
SET "DIR=%CD%"
SET "SCRIPT_DIR=%~dp0"
SETLOCAL EnableExtensions EnableDelayedExpansion
PUSHD "!SCRIPT_DIR!"
	
	SET "redocly.cmd=!APPDATA!\npm\redocly.cmd"
	SET "INPUT_FILENAME=openapi.yaml"
	SET "OUTPUT_FILENAME=redoc-static.html"
	
	IF /I NOT EXIST "!redocly.cmd!" (
		ECHO [ERROR] Не удаётся найти файл «!redocly.cmd!"».
		GOTO exit
	)
	IF /I EXIST "!OUTPUT_FILENAME!" (
		DEL /S /Q "!OUTPUT_FILENAME!" 1>NUL
	)
	
	:start
	CALL "!redocly.cmd!" build-docs "!INPUT_FILENAME!"
	firefox "!OUTPUT_FILENAME!"
	PAUSE
	CLS
	GOTO start
	
:exit
POPD
ENDLOCAL
SET "DIR="
SET "SCRIPT_DIR="
EXIT /B