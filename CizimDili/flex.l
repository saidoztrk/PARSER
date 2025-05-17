%{
#include "cizimdili.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%x COMMENT

%%

"--".*                  ;  // Yorum satırı
[ \t\r\n]+              ;  // Boşlukları yoksay

"eger"                 return IF;
"aksi"                 return ELSE;
"dongu"                return WHILE;
"iken"                 return WHILE_COND;
"neki"                 return END;
"fonk"                 return FUNC;
"knof"                 return FUNC_CALL;
"dondur"               return RETURN;

"daire_ciz"            return DRAW_CIRCLE;
"tus_basildi"          return KEY_PRESSED;

"TUS_YUKARI"|"TUS_ASAGI"|"TUS_SOLA"|"TUS_SAGA" return KEYWORD;

"<-"                   return ASSIGN;
"+<-"                  return ADD_ASSIGN;
"-<-"                  return SUB_ASSIGN;

"+"                    return PLUS;
"-"                    return MINUS;
"*"                    return MUL;
"/"                    return DIV;
"%"                    return MOD;
"="                    return EQ;
"<>"                   return NEQ;
"<"                    return LT;
">"                    return GT;

[0-9]+\.[0-9]+         { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+                 { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return ID; }

.                      return yytext[0];

%%

int yywrap(void) { return 1; }
