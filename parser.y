%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

typedef struct {
    char name[100];
    int value;
} Variable;

Variable symbolTable[100];
int symbolCount = 0;

int getValue(char* name) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0)
            return symbolTable[i].value;
    }
    printf("Undefined variable: %s\n", name);
    exit(1);
}

void setValue(char* name, int val) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            symbolTable[i].value = val;
            return;
        }
    }
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount++].value = val;
}
%}

%union {
    int num;
    char* id;
}

%token <num> NUMBER
%token <id> IDENTIFIER
%token PRINT ASSIGN
%token PLUS MINUS MULTIPLY DIVIDE SEMICOLON

%type <num> expr

%%
program:
    program statement
    | statement
    ;

statement:
    IDENTIFIER ASSIGN expr SEMICOLON   { setValue($1, $3); }
    | PRINT expr SEMICOLON             { printf("Result: %d\n", $2); }
    ;

expr:
    expr PLUS expr       { $$ = $1 + $3; }
    | expr MINUS expr    { $$ = $1 - $3; }
    | expr MULTIPLY expr { $$ = $1 * $3; }
    | expr DIVIDE expr   { $$ = $1 / $3; }
    | NUMBER             { $$ = $1; }
    | IDENTIFIER         { $$ = getValue($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}

