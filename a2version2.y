%debug
/* %define parse.error verbose
*/
%{
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
	
#include "extetrickstype.h"
	
void yyerror(const char *s)
{
fprintf(stderr,"%s\n",s);
return;
}
	
int yywrap()
{
	return 1;
}

int yylex();
	
char* indent(char* body) {
	char* ans = malloc(1024);
	memset(ans, 0, 1024);
	char* line = strtok(body, "\n");
	while(line != NULL) {
		sprintf(ans, "%s    %s\n", ans, line);
		line = strtok(NULL, "\n");
	}
	free(body);
	return ans;
}
const char *verbatim="from engine.engine import *\n";
const char*object_name="tetris_engine";
	
%}
	
%token SECTION1 SECTION2 SECTION3 NEWLINE NUM ID IF THEN ELSE END WHILE CALL WITH OR AND NOT NEG PLAY RETURN
	
%%
START :  SECTION1 NEWLINE PRIMITIVE SECTION2 NEWLINE FUNCTIONS SECTION3 NEWLINE ENGINE  { 
			$$ = malloc(sizeof(xtetricksSType));
			$$->value.StringValue = malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s\n#PRIMITIVE:\n%s\n#FUNCTIONS:\n%s\n#ENGINE:\n%s\n", verbatim, $3->value.StringValue, $6->value.StringValue, $9->value.StringValue);

			printf("%s\n", $$->value.StringValue); 
		};
	
PRIMITIVE : ID '=' EXPR NEWLINE PRIMITIVE { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s = %s\n%s", $1->value.StringValue, $3->value.StringValue, $5->value.StringValue);
			}
			| { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				strcpy($$->value.StringValue, "");
			}
					;
	
ENGINE : '[' PLAY ']' { 
    			$$ = malloc(sizeof(xtetricksSType));
    			$$->value.StringValue = malloc(1024*sizeof(char));
    			sprintf($$->value.StringValue, "if __name__ == '__main__':\n\ttetris_engine = TetrisEngine()\n");
    		}
    		| '[' PLAY WITH PARAM PARAMLIST ']' { 
    			$$ = malloc(sizeof(xtetricksSType));
    			$$->value.StringValue = malloc(1024*sizeof(char));
    			sprintf($$->value.StringValue, "if __name__ == '__main__':\n\ttetris_engine = TetrisEngine(height,width,update_duration,move_down_duration,background_col,foreground_col,difficulty,lower_bound,upper_bound,prob)\n");
			}
	
FUNCTIONS : FUNCTION NEWLINE FUNCTIONS { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s\n%s", $1->value.StringValue, $3->value.StringValue);
			}
			| {
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				strcpy($$->value.StringValue, "");
			};
FUNCTION : '{' ID BODY '}'{ 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				char* body = indent($3->value.StringValue);
				sprintf($$->value.StringValue, "def %s():\n%s", $2->value.StringValue, body);
			};
	
BODY : STATEMENT BODY { 
			$$ = malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, "%s\n%s", $1->value.StringValue, $2->value.StringValue);
		}
		| STATEMENT { 
			$$ = malloc(sizeof(xtetricksSType));
			$$->value.StringValue = malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s", $1->value.StringValue);
		};
	
STATEMENT : IFSTATEMENT { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s", $1->value.StringValue);
			}
			| WHILELOOP { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "%s", $1->value.StringValue);
			}
			| ID '=' EXPR {
				$$ = malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = malloc(1024*sizeof(char)); 
				sprintf($$->value.StringValue, "%s = %s", $1->value.StringValue, $3->value.StringValue); 
			}
			| RETURN EXPR { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "return %s", $2->value.StringValue);
			}
			;
	
IFSTATEMENT : IF '(' EXPR ')' THEN BODY END {
				$$ = malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = malloc(1024*sizeof(char)); 
				char* stm = indent($6->value.StringValue);
				sprintf($$->value.StringValue, "if %s :\n%s", $3->value.StringValue, stm); 
			}
			| IF '(' EXPR ')' THEN STATEMENT ELSE STATEMENT END {
				$$ = malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = malloc(1024*sizeof(char)); 
				char* stm1 = indent($6->value.StringValue);
				char* stm2 = indent($8->value.StringValue);
				sprintf($$->value.StringValue, "if %s :\n%selse:\n%s", $3->value.StringValue, stm1, stm2); 
			}
			;
	
WHILELOOP : WHILE '(' EXPR ')' BODY END { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				char* stm = indent($5->value.StringValue);
				sprintf($$->value.StringValue, "while %s :\n%s", $3->value.StringValue, stm);
			}
					;
	
EXPR : ARITHLOGIC {
			$$ = malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, "%s", $1->value.StringValue); 
		}
			| '[' CALL ID ']' { 
			$$ = malloc(sizeof(xtetricksSType));
			$$->value.StringValue = malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s()", $3->value.StringValue);
		}
		| '[' CALL ID WITH PARAM PARAMLIST ']' { 
			$$ = malloc(sizeof(xtetricksSType));
			$$->value.StringValue = malloc(1024*sizeof(char));
			char object_cat[1024]={0};
			strcpy(object_cat, object_name);
			strcat(object_cat, ".");
			strcat(object_cat, $3->value.StringValue);
			sprintf($$->value.StringValue, "%s(%s%s)", object_cat, $5->value.StringValue, $6->value.StringValue);
		}
		;
	
ARITHLOGIC : TERM ARITH1 {
				$$ = malloc(sizeof(xtetricksSType)); 
				$$->value.StringValue = malloc(1024*sizeof(char)); 
				sprintf($$->value.StringValue, "%s%s", $1->value.StringValue, $2->value.StringValue); 
			}
			;
	
TERM : FACTOR TERM1 {
			$$ = malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, "%s%s", $1->value.StringValue, $2->value.StringValue); 
		};
	
ARITH1 : '+' TERM ARITH1 {
			$$ = malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " + %s%s", $2->value.StringValue, $3->value.StringValue); 
		}
		| '-' TERM ARITH1 {
			$$ = malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " - %s%s", $2->value.StringValue, $3->value.StringValue); 
			}
		| OR TERM ARITH1 {
			$$ = malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = malloc(1024*sizeof(char)); 
			sprintf($$->value.StringValue, " || %s%s", $2->value.StringValue, $3->value.StringValue); 
			}
		| {
			$$ = malloc(sizeof(xtetricksSType)); 
			$$->value.StringValue = malloc(1024*sizeof(char)); 
			strcpy($$->value.StringValue, "");
			};
	
FACTOR : ID {$$ = malloc(sizeof(xtetricksSType)); $$->value.StringValue = malloc(1024*sizeof(char)); strcpy($$->value.StringValue, $1->value.StringValue); 
				}
			| NUM {$$ = malloc(sizeof(xtetricksSType)); $$->value.StringValue = malloc(1024*sizeof(char)); strcpy($$->value.StringValue, $1->value.StringValue); 
					}
			| '(' EXPR ')' {$$ = malloc(sizeof(xtetricksSType)); $$->value.StringValue = malloc(1024*sizeof(char)); sprintf($$->value.StringValue, "(%s)", $2->value.StringValue); 
								}
			| '(' NEG EXPR ')' { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, "(-%s)", $3->value.StringValue);
				} 
			| '(' NOT EXPR ')' {$$ = malloc(sizeof(xtetricksSType)); $$->value.StringValue = malloc(1024*sizeof(char)); sprintf($$->value.StringValue, "(!%s)", $2->value.StringValue); 
			};
	
TERM1 : '*' FACTOR TERM1 {$$ = malloc(sizeof(xtetricksSType)); $$->value.StringValue = malloc(1024*sizeof(char)); sprintf($$->value.StringValue, " * %s%s", $2->value.StringValue, $3->value.StringValue); 
			}
			| AND FACTOR TERM1 {$$ = malloc(sizeof(xtetricksSType)); $$->value.StringValue = malloc(1024*sizeof(char)); sprintf($$->value.StringValue, " && %s%s", $2->value.StringValue, $3->value.StringValue); 
			}
			| {$$ = malloc(sizeof(xtetricksSType)); $$->value.StringValue = malloc(1024*sizeof(char)); strcpy($$->value.StringValue, ""); 
			};
	
PARAM : ID '=' EXPR { 
			$$ = malloc(sizeof(xtetricksSType));
			$$->value.StringValue = malloc(1024*sizeof(char));
			sprintf($$->value.StringValue, "%s = %s", $1->value.StringValue, $3->value.StringValue);
		}
		;
	
PARAMLIST : PARAM PARAMLIST { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				sprintf($$->value.StringValue, ", %s%s", $1->value.StringValue, $2->value.StringValue);
			}
			| { 
				$$ = malloc(sizeof(xtetricksSType));
				$$->value.StringValue = malloc(1024*sizeof(char));
				strcpy($$->value.StringValue, "");
			};
%%
	
int main(int argc, char *argv[])
{
yyparse();
return 0;
}