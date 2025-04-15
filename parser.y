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
%token IF ELSE WHILE FOR SWITCH CASE DEFAULT BREAK
%token EQ NE LT GT LE GE

%type <num> expr condition
%type block

%%

program:
    statement_list
    ;

statement_list:
    statement_list statement
    | statement
    ;

statement:
    IDENTIFIER ASSIGN expr SEMICOLON         { setValue($1, $3); }
    | PRINT expr SEMICOLON                   { printf("Result: %d\n", $2); }
    | IF '(' condition ')' block             { if ($3) { /* execute block */ } }
    | IF '(' condition ')' block ELSE block  { if ($3) { /* then block */ } else { /* else block */ } }
    | WHILE '(' condition ')' block
        {
            while ($3) {
                yyparse(); // Simulate executing block
            }
        }
    | FOR '(' IDENTIFIER ASSIGN expr ';' condition ';' IDENTIFIER ASSIGN expr ')' block
        {
            setValue($3, $5);  // Initialize the first identifier
            while ($7) {        // Condition check
                yyparse();     // Simulate executing block
                setValue($9, $11); // Update the second identifier
            }
        }
    | SWITCH '(' expr ')' '{' case_list default_case '}'
        {
            int val = $3;
            int matched = 0;
            for (int i = 0; i < symbolCount; i++) {
                if (symbolTable[i].value == val) {
                    matched = 1;
                    break;
                }
            }
            if (!matched) {
                /* execute default case */
            }
        }
    ;

block:
    '{' statement_list '}'
    ;

case_list:
    case_list case_stmt
    | case_stmt
    ;

case_stmt:
    CASE NUMBER ':' statement_list BREAK SEMICOLON
    ;

default_case:
    DEFAULT ':' statement_list
    |
    ;

condition:
    expr EQ expr { $$ = $1 == $3; }
    | expr NE expr { $$ = $1 != $3; }
    | expr LT expr { $$ = $1 < $3; }
    | expr GT expr { $$ = $1 > $3; }
    | expr LE expr { $$ = $1 <= $3; }
    | expr GE expr { $$ = $1 >= $3; }
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
    printf("Enter your code:\n");
    yyparse();
    return 0;
}


// %{
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>

// int yylex();
// void yyerror(const char *s);

// typedef struct {
//     char name[100];
//     int value;
// } Variable;

// Variable symbolTable[100];
// int symbolCount = 0;

// int getValue(char* name) {
//     for (int i = 0; i < symbolCount; i++) {
//         if (strcmp(symbolTable[i].name, name) == 0)
//             return symbolTable[i].value;
//     }
//     printf("Undefined variable: %s\n", name);
//     exit(1);
// }

// void setValue(char* name, int val) {
//     for (int i = 0; i < symbolCount; i++) {
//         if (strcmp(symbolTable[i].name, name) == 0) {
//             symbolTable[i].value = val;
//             return;
//         }
//     }
//     strcpy(symbolTable[symbolCount].name, name);
//     symbolTable[symbolCount++].value = val;
// }
// %}

// %union {
//     int num;
//     char* id;
// }

// %token <num> NUMBER
// %token <id> IDENTIFIER
// %token PRINT ASSIGN
// %token PLUS MINUS MULTIPLY DIVIDE SEMICOLON

// %type <num> expr

// %%
// program:
//     program statement
//     | statement
//     ;

// statement:
//     IDENTIFIER ASSIGN expr SEMICOLON   { setValue($1, $3); }
//     | PRINT expr SEMICOLON             { printf("Result: %d\n", $2); }
//     ;

// expr:
//     expr PLUS expr       { $$ = $1 + $3; }
//     | expr MINUS expr    { $$ = $1 - $3; }
//     | expr MULTIPLY expr { $$ = $1 * $3; }
//     | expr DIVIDE expr   { $$ = $1 / $3; }
//     | NUMBER             { $$ = $1; }
//     | IDENTIFIER         { $$ = getValue($1); }
//     ;

// %%

// void yyerror(const char *s) {
//     fprintf(stderr, "Error: %s\n", s);
// }

// int main() {
//     yyparse();
//     return 0;
// }

