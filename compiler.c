#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "compiler.h"

extern int lineNumber;

//pointer as a entry to the Symboltable, which is a linked list
symtabEntry * theSymboltable = 0;


int main (void)
{
  yyparse();
  
  
  //sample for a valid symboltable
  // addSymboltableEntry(theSymboltable,"If_Demo"  , PROG,     NOP, NOP, 18, 0, 0 );
  // addSymboltableEntry(theSymboltable,"wert"     , INTEGER,  NOP, NOP,  0, 0, 0 );
  // addSymboltableEntry(theSymboltable,"d"        , INTEGER,    NOP, NOP,  4, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H0"       , BOOL,     NOP, NOP,  8, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H1"       , BOOL,     NOP, NOP,  9, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H2"       , BOOL,     NOP, NOP, 10, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H3"       , BOOL,     NOP, NOP, 11, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H4"       , BOOL,     NOP, NOP, 12, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H5"       , BOOL,     NOP, NOP, 13, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H6"       , BOOL,     NOP, NOP, 14, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H7"       , BOOL,     NOP, NOP, 15, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H8"       , BOOL,     NOP, NOP, 16, 0, 0 );
  // addSymboltableEntry(theSymboltable,"H9"       , BOOL,     NOP, NOP, 17, 0, 0 );
  
  // Write the symbol table to file
  FILE * outputFile;
  if ((outputFile = fopen("./Symboltable.out", "w")) != 0)
  {
    writeSymboltable(theSymboltable, outputFile);
  }
  fclose(outputFile);
  
  return 0;
}

void yyerror(char * str)
{
  fprintf(stderr, "Error in line %d: %s\n", lineNumber, str);
}

// This function adds a new entry to the symbol table
symtabEntry * addSymboltableEntry (
              char * name,
              symtabEntryType type,
              symtabEntryType internalType,
              int offset,
              int line,
              symtabEntry * vater,
              int parameter){
  //adds a symbolEntry to the end of the Symboltable. If the global variable theSymboltable is not 
  //initialized, this will be done with the first call of this function
  symtabEntry * newSymtabEntry = (symtabEntry*) malloc (sizeof (symtabEntry));
  
  //allocates the memory for the new symtabEntry
  newSymtabEntry->name = (char *) malloc (strlen(name) +1);
  strcpy(newSymtabEntry->name,name);
  newSymtabEntry->type = type;
  newSymtabEntry->internalType = internalType;
  newSymtabEntry->offset = offset;
  newSymtabEntry->line = line;
  newSymtabEntry->vater = vater;
  newSymtabEntry->parameter = parameter;
  newSymtabEntry->next = 0;
  
  
  if (!theSymboltable)
  {
    //there is no entry in the Symboltable
    theSymboltable = newSymtabEntry;
  }
  else
  {
    //there is at least one entry in the Symboltable
    symtabEntry * symtabHelp = theSymboltable;
    while (symtabHelp->next)
    {
      //walks to the last entry of Symboltable
      symtabHelp = symtabHelp->next;
    }
    symtabHelp->next = newSymtabEntry;
  }
  return newSymtabEntry;
}

symtabEntry * findEntry( char * name){

symtabEntry * symtabHelp = theSymboltable;

if(!symtabHelp){
return 0;}

	   if(strcmp(symtabHelp->name,name)==0){
			return symtabHelp;}
			
	
	 while (symtabHelp->next)
		{
		
		  //walks through the Symboltable
		  symtabHelp = symtabHelp->next;
		
		  if(strcmp(symtabHelp->name,name)==0){
			return symtabHelp;}
		}
	

	if(strcmp(symtabHelp->name,name)==0){

	return symtabHelp;}

	return 0;
	
}

//puts the printout for a given SymbolEntrytype to the given string
void getSymbolTypePrintout(symtabEntryType  type, char * writeIn)
{
  switch(type){
    case PROG:     strcpy(writeIn,"Prg     ")  ;break;
    case NOP :     strcpy(writeIn,"None    ")  ;break;
    case REAL:     strcpy(writeIn,"Real    ")  ;break;
    case BOOL:     strcpy(writeIn,"Bool    ")  ;break;
    case INTEGER : strcpy(writeIn,"Int     ")  ;break;
    case ARR :     strcpy(writeIn,"Array   ")  ;break;
    case FUNC:     strcpy(writeIn,"Func    ")  ;break;
    case PROC:     strcpy(writeIn,"Proc    ")  ;break;
    case PRG_PARA: strcpy(writeIn,"P.Prmtr ")  ;break;
    default:       strcpy(writeIn,"        ")  ;break;
  }
}

// writes the Symboltable in the outFile formated in a table view 
void writeSymboltable (symtabEntry * Symboltable, FILE * outputFile){

  fprintf (outputFile, "SYMBOLS\n");
  fprintf (outputFile, "-------\n");
  fprintf (outputFile, "\n");
  fprintf (outputFile, "Name                Type    Int_Typ Offset/Size    Line    Index1    Index2    Parent          Parameter\n");
  fprintf (outputFile, "-------------------------------------------------------------------------------------------------------\n");
  
  //variables
  symtabEntry * currentEntry;   //pointer for the current Symboltable entry for walking through the list
  int j;              //help variable, to build a string with the same length
  char helpString[21];      //string for formatted output
  
  
  currentEntry = Symboltable;
  do{
  //walks through the Symboltable
    strncpy(helpString,currentEntry->name,20);
    for(j=19;j>=strlen(currentEntry->name);j--){
    //loop for formating the output to file 
      helpString[j]=' ';
    }
    helpString[20]=0;
    fprintf(outputFile, "%s",helpString);
    
    getSymbolTypePrintout(currentEntry->type,helpString);
    fprintf(outputFile, "%s",helpString);
    
    getSymbolTypePrintout(currentEntry->internalType,helpString);
    fprintf(outputFile, "%s",helpString);
    
    fprintf(outputFile, "%11d ",currentEntry->offset);
    fprintf(outputFile, "%7d ",currentEntry->line);
    fprintf(outputFile, "%9d ", 0);
    fprintf(outputFile, "%9d \t", 0);
    if(currentEntry->vater){
      fprintf(outputFile, "%s \t",currentEntry->vater->name);
    }else{
      fprintf(outputFile, "None \t");
    }
    fprintf(outputFile, "\t %d \n",currentEntry->parameter);
    
    fflush(outputFile);
    
    currentEntry=currentEntry->next;
  }while(currentEntry);
  
  fprintf(outputFile, "\n");
  fflush(outputFile);
  
  // writeCode(outputFile);
}
