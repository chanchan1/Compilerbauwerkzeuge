%error-verbose

%{
//Prologue
#include "compiler.h" 
#include <stdio.h>

%}
//Bison declarations

// Define all tokens used in the source code
%token NUMBERSIGN DOT TODO 
%token NEW_LINE

%token ID VOID INT FLOAT INCLUDE RETURN
%token NUMBER FRACTIONAL_NUMBER
%token IF ELSE WHILE DO
%token COMMA
%token ASSIGN SEMICOLON
%token LOGIC_OR
%token LOGIC_AND
%token EQUAL NOTEQUAL
%token REL_OPERATOR
%token BITSHIFT
%token ADD_GROUP
%token MULT_GROUP
%token NEGATE IN_DECREMENT
%token BRACKET_OPEN BRACKET_CLOSE PARENTHESIS_OPEN PARENTHESIS_CLOSE 


%left ID VOID INT FLOAT INCLUDE RETURN 
%left NUMBER FRACTIONAL_NUMBER
%left IF ELSE WHILE DO
%left COMMA
%right ASSIGN
%left LOGIC_OR
%left LOGIC_AND
%left EQUAL NOTEQUAL
%left REL_OPERATOR
%left BITSHIFT
%left ADD_GROUP
%left MULT_GROUP
%right NEGATE IN_DECREMENT
%left BRACKET_OPEN BRACKET_CLOSE PARENTHESIS_OPEN PARENTHESIS_CLOSE

%union
{
int integer;
char * string;
symtabEntryType type;

}

%type<integer>  NUMBER number FRACTIONAL_NUMBER
%type<string> id ID 
%type<type> var_type


%%    // grammar rules

programm
    : function {printf("EVERYTHING COMPILED");}
    | function_declaration programm function {printf("EVERYTHING COMPILED");}
    ;

function_declaration
	: return_value  id  PARENTHESIS_OPEN  parameter_list  PARENTHESIS_CLOSE SEMICOLON{printf("declaration \n \n");}
	;
	
function
    : return_value  id  PARENTHESIS_OPEN  parameter_list  PARENTHESIS_CLOSE  function_body{printf("function 1 \n");}
    | return_value  id  PARENTHESIS_OPEN  VOID  PARENTHESIS_CLOSE  function_body{printf("function 2 \n");}
    ;

function_body
    : BRACKET_OPEN statement_list  BRACKET_CLOSE{printf("func_body 1 \n");}
    | BRACKET_OPEN declaration_list statement_list BRACKET_CLOSE{printf("func_body 2 \n");}
    ;

declaration_list
    : declaration SEMICOLON {printf("declist 1 \n");}
    | declaration_list declaration SEMICOLON{printf("declist 2 \n");}
    ;

declaration
    : var_type  id {printf("dec \n");}
    ;

parameter_list
    : var_type  id {printf("param 1 \n");}
    | parameter_list COMMA  var_type  id{printf("param 2 \n");}
	|
    ;
return_value
	: var_type {printf("retval 1 \n");}
	| VOID{printf("retval 2 \n");}
	;
	
var_type
    : FLOAT{printf("float \n");}
	| INT{printf("int \n");}
    ;

statement_list
    : statement{printf("statement 1 \n");}
    | statement_list statement{printf("statement 2 \n");}
    ;

statement
    : matched_statement {printf("matched state \n");}
    | unmatched_statement{printf("unmached state \n");}
    ;

matched_statement
    : IF  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE matched_statement ELSE matched_statement{printf("matched state 1 \n");}
    | assignment SEMICOLON{printf("matched state 2 \n");}
    | RETURN SEMICOLON{printf("matched state 3 \n");}
    | RETURN  assignment SEMICOLON{printf("matched state 4 \n");}
    | WHILE  PARENTHESIS_OPEN assignment PARENTHESIS_CLOSE matched_statement{printf("matched state 5 \n");}
    | DO statement WHILE  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE SEMICOLON{printf("matched state 6 \n");}
    | BRACKET_OPEN  statement_list  BRACKET_CLOSE{printf("matched state 7 \n");}
    | BRACKET_OPEN  BRACKET_CLOSE{printf("matched state 8 \n");}
    ;

unmatched_statement
    : IF  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE statement{printf("unmatched state 1 \n");}
    | WHILE  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE unmatched_statement{printf("unmatched state 2 \n");}
    | IF  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE matched_statement ELSE unmatched_statement{printf("unmatched state 3 \n");}
    ;


assignment
    : expression{printf("assignment 1 \n");}
    | id  ASSIGN  expression{printf("assignment 2 \n");}
    ;

expression
    : IN_DECREMENT expression{printf("expression 1 \n");}
	| expression  LOGIC_AND  expression{printf("expression 2 \n");}
	| expression  LOGIC_OR  expression{printf("expression 3 \n");}
	| expression  NOTEQUAL  expression{printf("expression 4 \n");}
	| expression  EQUAL  expression{printf("expression 5 \n");}
	| expression  REL_OPERATOR  expression{printf("expression 6 \n");}
	| expression  BITSHIFT  expression{printf("expression 7 \n");}
	| expression  ADD_GROUP  expression{printf("expression 8 \n");}
	| expression  MULT_GROUP  expression{printf("expression 9 \n");}
	| NEGATE  expression{printf("expression 10 \n");}
	| PARENTHESIS_OPEN  expression  PARENTHESIS_CLOSE{printf("expression 11 \n");}
	| number{printf("expression 12 \n");}
	| id{printf("expression 13 \n");}
	| id PARENTHESIS_OPEN exp_list PARENTHESIS_CLOSE{printf("expression 14 \n");}
    ;

exp_list
    : expression{printf("exp_list 1 \n");}
    | exp_list COMMA  expression{printf("exp_list 2s \n");}
    ;
	
number
	: NUMBER{$$=$1; printf("number %d \n",$1);}
	| FRACTIONAL_NUMBER{$$=$1; printf("number2 %d \n",$1);}

id
    : ID {printf("id: %s\n",$1);};
	


%%

//Epilogue