%{
#include <math.h>
#include <stdlib.h>
#include <stdio.h>

#include "extetrickstype.h"

void yyerror(char*);

%}

%%
Section1 { return SECTION1; }
Section2 { return SECTION2; }
Section3 { return SECTION3; }
if	{ yylval = NewSymbol(yytext, IF); return IF; } 
then { yylval = NewSymbol(yytext, THEN);return THEN; }
else { yylval = NewSymbol(yytext, ELSE);return ELSE; }
end	{ yylval = NewSymbol(yytext, END); return END; }
while { return WHILE; }
call { return CALL; }
with { return WITH; }
or	{ return OR; }
and	{ return AND; }
not	{ return NOT; }
neg	{ return NEG; }
play { return PLAY; }
[A-Za-z][A-Za-z0-9_]* { yylval = NewSymbol(yytext, ID); return ID; }
[0-9][0-9]* { yylval = NewSymbol(yytext,NUM); return NUM; }
[0-9][0-9]*\.[0-9]+	{ yylval = NewSymbol(yytext,NUM); return NUM; }
#[\n\r]	{ return NEWLINE; }
[ \t\n\r]* {  /* Do nothing, drop them. */ }
. { return *yytext; }
%%

#ifdef STANDALONE_LEXER
int main(void)
	{
	while(yylex()!='q');
	}
#endif

