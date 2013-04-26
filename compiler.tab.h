
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBERSIGN = 258,
     DOT = 259,
     TODO = 260,
     NEW_LINE = 261,
     ID = 262,
     VOID = 263,
     INT = 264,
     FLOAT = 265,
     INCLUDE = 266,
     RETURN = 267,
     NUMBER = 268,
     FRACTIONAL_NUMBER = 269,
     IF = 270,
     ELSE = 271,
     WHILE = 272,
     DO = 273,
     COMMA = 274,
     ASSIGN = 275,
     SEMICOLON = 276,
     LOGIC_OR = 277,
     LOGIC_AND = 278,
     EQUAL = 279,
     NOTEQUAL = 280,
     REL_OPERATOR = 281,
     BITSHIFT = 282,
     ADD_GROUP = 283,
     MULT_GROUP = 284,
     NEGATE = 285,
     IN_DECREMENT = 286,
     BRACKET_OPEN = 287,
     BRACKET_CLOSE = 288,
     PARENTHESIS_OPEN = 289,
     PARENTHESIS_CLOSE = 290
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 47 "compiler.y"

int integer;
char * string;
symtabEntryType type;




/* Line 1676 of yacc.c  */
#line 96 "compiler.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


