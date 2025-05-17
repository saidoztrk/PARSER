%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
int line = 1;
%}

%union {
    int ival;
    float fval;
    char* sval;
}

%token <ival> INT
%token <fval> FLOAT
%token <sval> ID

%token IF ELSE WHILE WHILE_COND END FUNC FUNC_CALL RETURN
%token DRAW_CIRCLE KEY_PRESSED KEYWORD

%token ASSIGN ADD_ASSIGN SUB_ASSIGN
%token PLUS MINUS MUL DIV MOD EQ NEQ LT GT

%%

program:
    statements
    {
        printf("[Başarılı] Kod gramer kurallarına uygundur.\n");
    }
;

statements:
    statements statement
    | statement
;

statement:
      ID ASSIGN expr
    | ID ADD_ASSIGN expr
    | ID SUB_ASSIGN expr
    | IF expr statement ELSE statement
    | WHILE expr WHILE_COND statements END
    | FUNC ID ID ID ':' statement
    | FUNC_CALL ID expr expr
    | DRAW_CIRCLE expr expr expr
    | IF KEY_PRESSED KEYWORD statement
    | RETURN expr
    | ';'
;

expr:
      expr PLUS expr
    | expr MINUS expr
    | expr MUL expr
    | expr DIV expr
    | expr MOD expr
    | expr EQ expr
    | expr NEQ expr
    | expr LT expr
    | expr GT expr
    | INT
    | FLOAT
    | ID
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Hata: Satır %d: %s\n", line, s);
}
