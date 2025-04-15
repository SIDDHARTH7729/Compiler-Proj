%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%
[ \t\n]                  ;
"print"                 { return PRINT; }
"if"                    { return IF; }
"else"                  { return ELSE; }
"while"                 { return WHILE; }
"for"                   { return FOR; }
"switch"                { return SWITCH; }
"case"                  { return CASE; }
"default"               { return DEFAULT; }
"break"                 { return BREAK; }
"=="                    { return EQ; }
"!="                    { return NE; }
"<="                    { return LE; }
">="                    { return GE; }
"<"                     { return LT; }
">"                     { return GT; }
"="                     { return ASSIGN; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MULTIPLY; }
"/"                     { return DIVIDE; }
";"                     { return SEMICOLON; }
":"                     { return ':'; }
"{"                     { return '{'; }
"}"                     { return '}'; }
"("                     { return '('; }
")"                     { return ')'; }
[0-9]+                  { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.id = strdup(yytext); return IDENTIFIER; }
.                       { return yytext[0]; }
%%

int yywrap() {
    return 1;
}

// %{
// #include "parser.tab.h"
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
// %}

// %%
// [ \t\n]                  ; // Ignore whitespace
// "print"                 { return PRINT; }
// [0-9]+                  { yylval.num = atoi(yytext); return NUMBER; }
// [a-zA-Z_][a-zA-Z0-9_]*  { yylval.id = strdup(yytext); return IDENTIFIER; }
// "="                     { return ASSIGN; }
// "+"                     { return PLUS; }
// "-"                     { return MINUS; }
// "*"                     { return MULTIPLY; }
// "/"                     { return DIVIDE; }
// ";"                     { return SEMICOLON; }
// .                       { return yytext[0]; }
// %%

// int yywrap() {
//     return 1;
// }


