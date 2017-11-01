%{
/***************************
 * @Author Mike Ames
 * @Version Fall 2017
 ****************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "zoomjoystrong.h"

void handle_point (int x, int y);

%}

%start program

%union { char sym; 
         int iVal;
         float fVal;
       }

%token <sym>END END_STATEMENT POINT LINE CIRCLE RECTANGLE SET_COLOR
%token <iVal> INT
%token <fVal> FLOAT

%%                   /* beginning of rules section */

       program: statement_list END END_STATEMENT                 
              ;
statement_list: statement
              | statement statement_list
              ;
     statement: point
              | line 
              | circle 
              | rectangle 
              | set_color
              | error 
              ;
           num: INT
              | FLOAT
              ;
         point: POINT num num END_STATEMENT     {handle_point($2, $3);}
              | POINT INT FLOAT END_STATEMENT   {handle_point($2,$3);}
              | POINT FLOAT INT END_STATEMENT   {handle_point($2,$3);}
              | POINT FLOAT FLOAT END_STATEMENT {handle_point($2,$3);}
              ;
          line: LINE INT INT INT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE INT INT INT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE INT INT FLOAT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE INT FLOAT INT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT INT INT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT FLOAT INT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE INT FLOAT FLOAT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE INT INT FLOAT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT INT FLOAT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT INT INT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE INT FLOAT INT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT FLOAT FLOAT INT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE INT FLOAT FLOAT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT INT FLOAT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT FLOAT INT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
     		  | LINE FLOAT FLOAT FLOAT FLOAT END_STATEMENT {line($2,$3,$4,$5);}
              ;
              
        circle: CIRCLE INT INT INT   END_STATEMENT {circle($2,$3,$4);}
              | CIRCLE INT INT FLOAT END_STATEMENT {circle($2,$3,$4);}
              | CIRCLE INT FLOAT INT END_STATEMENT {circle($2,$3,$4);}
              | CIRCLE FLOAT INT INT END_STATEMENT {circle($2,$3,$4);}
              | CIRCLE FLOAT FLOAT INT END_STATEMENT {circle($2,$3,$4);}
              | CIRCLE FLOAT INT FLOAT END_STATEMENT {circle($2,$3,$4);}
              | CIRCLE INT FLOAT FLOAT END_STATEMENT {circle($2,$3,$4);}
              | CIRCLE FLOAT FLOAT FLOAT END_STATEMENT {circle($2,$3,$4);}
              ;
     rectangle: RECTANGLE INT INT INT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE INT INT INT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE INT INT FLOAT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE INT FLOAT INT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT INT INT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT FLOAT INT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE INT FLOAT FLOAT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE INT INT FLOAT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT INT FLOAT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT INT INT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE INT FLOAT INT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT FLOAT FLOAT INT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE INT FLOAT FLOAT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT INT FLOAT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT FLOAT INT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
     		  | RECTANGLE FLOAT FLOAT FLOAT FLOAT END_STATEMENT {rectangle($2,$3,$4,$5);}
              ;
     set_color: SET_COLOR INT INT INT   END_STATEMENT {set_color($2,$3,$4);}
              | SET_COLOR INT INT FLOAT END_STATEMENT {set_color($2,$3,$4);}
              | SET_COLOR INT FLOAT INT END_STATEMENT {set_color($2,$3,$4);}
              | SET_COLOR FLOAT INT INT END_STATEMENT {set_color($2,$3,$4);}
              | SET_COLOR FLOAT FLOAT INT END_STATEMENT {set_color($2,$3,$4);}
              | SET_COLOR FLOAT INT FLOAT END_STATEMENT {set_color($2,$3,$4);}
              | SET_COLOR INT FLOAT FLOAT END_STATEMENT {set_color($2,$3,$4);}
              | SET_COLOR FLOAT FLOAT FLOAT END_STATEMENT {set_color($2,$3,$4);}
              ;
           
         
%%



int main()
{
 setup();
 yyparse();
}

int yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
  return(1);
}

int yywrap()
{
  return(1);
}

void handle_point (int x, int y) {
	if (x < 0 || x > WIDTH || y < 0 || y > HEIGHT) {
		printf("Please enter Y coordinates in the range 0 - 768 and X coordinates in the range 0 - 1024.");
		return;
	}
	point(x, y);
}

void handle_line (int x1, int y1, int x2, int y2) {
	if (x1 < 0 || x1 > WIDTH || x2 < 0 || x2 > WIDTH) {
		printf("Please enter X coordinates 0 - 1024");
		return;
	}
	if (y1 < 0 || y1 > WIDTH || y2 < 0 || y2 > WIDTH) {
		printf("Please enter Y coordinates 0 - 768");
		return;
	}

	
}