@echo off

set ROOT_DIR=%CD%

set BISON_DIR=%ROOT_DIR%\Tools\bison
set FLEX_DIR=%ROOT_DIR%\Tools\flex
set GCC_DIR=%ROOT_DIR%\Tools\MinGW

set PATH=%PATH%;"%BISON_DIR%\bin";"%FLEX_DIR%\bin";"%GCC_DIR%\bin"

bison compiler.y
