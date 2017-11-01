%{
/*
 * Sample Lex/Flex file.
 * from a wonderful tutorial from
 * IBM's Knowledge Center
 * https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.genprogc/ie_prog_4lex_yacc.htm
 *
 */

#include <stdio.h>
#include "zoomjoystrong.tab.h"
int c;
%}

%option noyywrap

%%
\n|\t   ;
[ \t]+    ;

end       {
                return END;
                printf("END '%s'\n", yytext);
          }

;         {
                printf("END_STATEMENT '%s'\n", yytext);
                return(END_STATEMENT);
          }

point     {
                 printf("POINT '%s'\n", yytext);
                 return(POINT);
          }

line      {
                printf("LINE '%s'\n", yytext);
                return(LINE);
          }

circle    {
                return(CIRCLE);
          }

rectangle {
                return(RECTANGLE);
          }

set_color {
                return(SET_COLOR);
          }

[0-9]+    {
               yylval.iVal = atoi(yytext);
	            printf("INT '%s'\n", yytext);
                return(INT);
          }

[0-9]*\.[0-9]+ {
               yylval.fVal = atof(yytext);
	            printf("FLOAT '%s'\n", yytext);
	            return FLOAT;
                }


%%



