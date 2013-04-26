@echo off

REM  set MAKE_COMMAND=mingw32-make.exe

set ROOT_DIR=%CD%

set BISON_DIR=%ROOT_DIR%\Tools\bison
set FLEX_DIR=%ROOT_DIR%\Tools\flex
set GCC_DIR=%ROOT_DIR%\Tools\MinGW

set PATH=%PATH%;%BISON_DIR%\bin;%FLEX_DIR%\bin;%GCC_DIR%\bin

flex  compiler.l 
bison -d compiler.y

gcc -g -c compiler.tab.c -o compiler_y.o
gcc -g -Wall -std=c99 -c lex.yy.c
gcc -g -c compiler.tab.c -o compiler_y.o

gcc -g -Wall -std=c99 -c compiler.c
gcc -g -o compiler.exe compiler.o compiler_y.o lex.yy.o -lm -lfl

echo ---------------------------------------------------------------
