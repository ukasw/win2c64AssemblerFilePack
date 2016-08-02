@ECHO off
REM set path to your win2c64 assembler directory, e.g. "C:\c64\pc-tools\asm\win2c64\win2c64.exe"
SET WIN2C64_PATH="[your path]\win2c64.exe"
REM set path to your vice emulator directory, e.g. "C:\c64\pc-tools\emul\WinVICE-2.4-x86\x64.exe"
SET VICE_PATH="[your path]\x64.exe"
REM if RUN = 0 then no start vice
SET RUN=1

ECHO /////////////////////////////////////////////////
ECHO compile_win2c64.bat %1
ECHO /////////////////////////////////////////////////
ECHO.

IF ["%~1"]==[""] GOTO FILENAME_REQUIRED_ERROR
IF NOT EXIST %1 GOTO SOURCEFILE_NOT_FOUND_ERROR
IF NOT EXIST %WIN2C64_PATH% GOTO ASSEMBLER_NOT_FOUND_ERROR
IF %RUN%==0 GOTO PATHS_OK
IF NOT EXIST %VICE_PATH% GOTO EMULATOR_NOT_FOUND_ERROR

:PATHS_OK
SET BATCHFILE_PATH="%~dp1"
SET SOURCEFILE="%~1"
SET EXECUTABLE="%~dpn1.prg"
SET RWFILE="%~dpn1.rw"

ECHO WIN2C64_PATH:   %WIN2C64_PATH%
IF %RUN%==0 GOTO NO_VICE_PATH
ECHO VICE_PATH:      %VICE_PATH%

:NO_VICE_PATH
ECHO BATCHFILE_PATH: %BATCHFILE_PATH%
ECHO SOURCEFILE:     %SOURCEFILE%
ECHO RWFILE:         %RWFILE%
ECHO EXECUTABLE:     %EXECUTABLE%
ECHO.

:CHECK_RW
IF NOT EXIST %RWFILE% GOTO CHECK_PRG
DEL %RWFILE%

:CHECK_PRG
IF NOT EXIST %EXECUTABLE% GOTO COMPILE
DEL %EXECUTABLE%

:COMPILE
ECHO /////////////////////////////////////////////////
%WIN2C64_PATH% -r %SOURCEFILE%
ECHO /////////////////////////////////////////////////

IF NOT EXIST %RWFILE% GOTO COMPILATION_ERROR
REN %RWFILE% "%~n1.prg"
ECHO SUCCESS!

IF %RUN%==0 GOTO END
START "" %VICE_PATH% %EXECUTABLE%
GOTO END

:ASSEMBLER_NOT_FOUND_ERROR
ECHO ERROR: win2c64 assembler not found! (check your win2c64_path)
GOTO END

:EMULATOR_NOT_FOUND_ERROR
ECHO ERROR: vice x64 emulator not found! (check your vice_path)
GOTO END

:SOURCEFILE_NOT_FOUND_ERROR
ECHO ERROR: source file not found!
GOTO END

:FILENAME_REQUIRED_ERROR
ECHO ERROR: filename required!
ECHO USAGE: compile-win2c64 [input filename]
ECHO.
ECHO EXAMPLES:
ECHO compile_win2c64 yourfile.s
ECHO compile_win2c64 "your file with spaces.s"
ECHO compile_win2c64 src\yourfile.s
ECHO compile_win2c64 c:\c64\src\yourfile.s
ECHO compile_win2c64 "c:\c64\source dir with spaces\yourfile.s"
ECHO.
ECHO warning: path length limit = 62 chars!
ECHO.
cmd /k

:COMPILATION_ERROR
ECHO ERROR: can't compile sourcefile!

:END
ECHO.
PAUSE

