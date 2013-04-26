%{
#include "compiler.h" 
#include "compiler.tab.h"


int lineNumber = 1;

%}
%%
%{
//key words
%}
include		return INCLUDE;
const
return		return RETURN;

%{
//control structures
%}
if			return IF;
else		return ELSE;
while		return WHILE;
do			return DO;

%{
//data type
%}
void		return VOID;
int			return INT;
float		return FLOAT;

%{
//numbers
%}
[0-9]+.[0-9]+		{
						yylval.integer = atof(yytext);
						return FRACTIONAL_NUMBER;
					}
[0-9]+				{
						yylval.integer = atoi(yytext);
						return NUMBER;
					}

%{
//identifier
%}
[A-Za-z0-9_]+ 	{
					//strcpy(yylval.string, yytext);
					yylval.string = strdup(yytext);
					return ID;
				}

%{
//puntuation marks
%}
,			return COMMA;
;			return SEMICOLON;
\.			return DOT;

%{
//comments (must come before \/)
%}
(\/\*(.*)\*\/)|\/\/(.*) 	


%{
//mathematical operation
%}
\+\+|\-\-	return IN_DECREMENT;
\+|\-		return ADD_GROUP;
\*|\/|\%	return MULT_GROUP;

%{
//numerical operators and comparison marks
%}
\<\<|\>\>		return BITSHIFT;
\<|\>|\<=|\>=	return REL_OPERATOR;
==		return EQUAL;
!=		return NOTEQUAL;;

%{
//special signs
%}
#		return NUMBERSIGN;
=		return ASSIGN;
\? 

%{
//logical operators and links
%}
&&		return LOGIC_AND;
\|\|	return LOGIC_OR;
\!		return NEGATE;

%{
//invisible signs
%}
[ ]+
\t
\n			{ ++lineNumber; }	

%{
//brackets
%}
\(			return PARENTHESIS_OPEN;
\)			return PARENTHESIS_CLOSE;
\{			return BRACKET_OPEN;
\}			return BRACKET_CLOSE;

%%
