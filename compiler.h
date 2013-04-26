#ifndef COMPILER_H_
#define COMPILER_H_

#include <stdio.h>

// List of available data types
typedef enum symtab_EntryType { INTEGER, REAL, BOOL, PROC, NOP, ARR, FUNC, PROG, PRG_PARA }
  symtabEntryType;

// Symbol table entry
typedef struct a_symtabEntry {
  char * name;
  symtabEntryType type;
  symtabEntryType internalType;
  int offset;
  int line;
  struct a_symtabEntry * vater;
  int parameter;
  struct a_symtabEntry * next;
} symtabEntry;

// Functions to manage symbol table
void  addSymboltableEntry(symtabEntry * Symboltable, char * name, symtabEntryType type, symtabEntryType internalType, int offset, int line, symtabEntry * vater, int parameter);
void  getSymbolTypePrintout(symtabEntryType type, char * writeIn);
void  writeSymboltable (symtabEntry * Symboltable, FILE * outputFile);

#endif /*COMPILER_H_*/
