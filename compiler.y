%error-verbose

%{
//Prologue
#include "compiler.h" 
#include <stdio.h>

symtabEntry * globaleVariable;

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

%type<integer> NUMBER FRACTIONAL_NUMBER number parameter_list
%type<string> id ID  expression assignment
%type<type> var_type declaration return_value


%%    // grammar rules

everything
	:programm {printf("EVERYTHING COMPILED\n");}
	
programm
    : function 
    | function_declaration programm function
    ;

function_declaration
	: return_value  id part2 {
	symtabEntryType type;
	if($1==NOP){type=PROC;}
		else{type=FUNC;}
	addSymboltableEntry ($2,  type,  $1,
              0, 0, 0, 0);
	globaleVariable = findEntry($2);}
	;
	
part2
	:PARENTHESIS_OPEN  parameter_list  PARENTHESIS_CLOSE SEMICOLON{
		globaleVariable =0;
	}
	;

	
function
    : return_value  id PARENTHESIS_OPEN  parameter_list  PARENTHESIS_CLOSE  function_body { 
				
				if(strcmp($2,"main")==0){
				addSymboltableEntry ($2,  PROG,  $1,
              0, 0, 0, $4);
			  }
			  else {
			  symtabEntry * existing;
			  
				existing = findEntry( $2);

			  if(!existing){
					yyerror("No prior declaration!");
					return 1;
				}
				else{
					if(existing->parameter!=$4){
					yyerror("Wrong number of parameters!");
					return 1;
					}
				}
			  }
			  globaleVariable =0;}
    | return_value  id  PARENTHESIS_OPEN  VOID  PARENTHESIS_CLOSE  function_body{
			
			if(strcmp($2,"main")==0){
				addSymboltableEntry ($2,  PROG,  $1,
              0, 0, 0, 0);
			  }
			  else {
			  symtabEntry * existing;
			  
				existing = findEntry( $2);

			  if(!existing){
					yyerror("No prior declaration!");
					return 1;
				}
				else{
					if(existing->parameter){
					yyerror("Wrong number of parameters!");
					return 1;
					}
				}
			  }}
    ;
	
function_body
    : BRACKET_OPEN statement_list  BRACKET_CLOSE
    | BRACKET_OPEN declaration_list statement_list BRACKET_CLOSE
    ;

declaration_list
    : declaration SEMICOLON
    | declaration_list declaration SEMICOLON
    ;

declaration
    : var_type  id {
	 symtabEntry * existing;
			
				existing = findEntry( $2);

			  if(existing){
					yyerror("Already declared!");
					return 1;
				}
				else
				{
				addSymboltableEntry ($2,  $1, NOP,0, 0, 0, 0);
			  }
			  
	}
    ;

parameter_list
    : var_type  id {
	
			symtabEntry * existing;

				existing = findEntry( $2);
		
			  if(existing){
				break;
				}
				else
				{
				addSymboltableEntry ($2,  $1, NOP,0, 0, globaleVariable, 1);
			  };
			  $$=1}
    | parameter_list COMMA  var_type  id {
	
				symtabEntry * existing;
			
				existing = findEntry( $4);

			  if(existing){
					break;
				}
				else
				{
				addSymboltableEntry ($4,  $3, NOP,0, 0, globaleVariable, $1+1);
			  };
			  $$=$1+1}
	| {printf("3");;
	$$=0}
    ;
return_value
	: var_type
	| VOID {$$=NOP;}
	;
	
var_type
    : FLOAT {$$=REAL;}
	| INT	{$$=INTEGER;}
    ;

statement_list
    : statement
    | statement_list statement
    ;

statement
    : matched_statement 
    | unmatched_statement
    ;

matched_statement
    : IF  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE matched_statement ELSE matched_statement
    | assignment SEMICOLON
    | RETURN SEMICOLON
    | RETURN  assignment SEMICOLON
    | WHILE  PARENTHESIS_OPEN assignment PARENTHESIS_CLOSE matched_statement
    | DO statement WHILE  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE SEMICOLON
    | BRACKET_OPEN  statement_list  BRACKET_CLOSE
    | BRACKET_OPEN  BRACKET_CLOSE
    ;

unmatched_statement
    : IF  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE statement
    | WHILE  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE unmatched_statement
    | IF  PARENTHESIS_OPEN  assignment  PARENTHESIS_CLOSE matched_statement ELSE unmatched_statement
    ;


assignment
    : expression
    | id  ASSIGN  expression
    ;

expression
    : IN_DECREMENT expression{$$="h1";}
	| expression  LOGIC_AND  expression
	| expression  LOGIC_OR  expression
	| expression  NOTEQUAL  expression
	| expression  EQUAL  expression
	| expression  REL_OPERATOR  expression
	| expression  BITSHIFT  expression
	| expression  ADD_GROUP  expression
	| expression  MULT_GROUP  expression
	| NEGATE  expression{$$=$2}
	| PARENTHESIS_OPEN  expression  PARENTHESIS_CLOSE{$$="h1";}
	| number{$$="h1";}
	| id{$$=$1}
	| id PARENTHESIS_OPEN exp_list PARENTHESIS_CLOSE 
    ;

exp_list
    : expression
    | exp_list COMMA  expression
    ;
	
number
	: NUMBER{$$=INTEGER;}
	| FRACTIONAL_NUMBER{$$=REAL;}

id
    : ID {strcpy($$,$1)};
	


%%

//Epilogue