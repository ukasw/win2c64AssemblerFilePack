@ECHO off
ECHO /////////////////////////////////////////////////
ECHO multi_compile_win2c64.bat
ECHO /////////////////////////////////////////////////
ECHO.
REM path to compile_win2c64.bat file in your os, e.g. "C:\c64\pc-tools\asm\win2c64\compile_win2c64.bat"
SET COMPILE_SCRIPT_PATH="[your path]\compile_win2c64.bat"
ECHO FILES LIST:
FOR %%i IN (*.s) DO ECHO "%%i"
ECHO.
IF NOT EXIST %COMPILE_SCRIPT_PATH% GOTO COMPILE_FILE_NOT_FOUND_ERROR
FOR %%i IN (*.s) DO CALL %COMPILE_SCRIPT_PATH% "%%i"
GOTO END

:COMPILE_FILE_NOT_FOUND_ERROR
ECHO ERROR: compile script not found! (check your COMPILE_SCRIPT_PATH)

:END
ECHO.
cmd /k

REM run command for notepadd++:
REM "[your path]\compile_win2c64.bat" "$(FULL_CURRENT_PATH)"