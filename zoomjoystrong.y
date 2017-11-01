%{
/***********************************************************************
 * @Author Mike Ames
 * @Version Fall 2017
***********************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "zoomjoystrong.h"

void handle_point (int x, int y);
void handle_line (int x1, int y1, int x2, int y2);
void handle_circle(int x, int y, int r();
void handle_rectangle( int x, int y, int w, int h);
void handle_set_color( int r, int g, int b);

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
         point: POINT INT INT END_STATEMENT {handle_point($2, $3);}
              ;
          line: LINE INT INT INT INT END_STATEMENT {handle_line($2,$3,$4,$5);}
              ;
              
        circle: CIRCLE INT INT INT   END_STATEMENT {handle_circle($2,$3,$4);}
              ;
     rectangle: RECTANGLE INT INT INT INT END_STATEMENT {handle_rectangle($2,$3,$4,$5);}
              ;
     set_color: SET_COLOR INT INT INT   END_STATEMENT {handle_set_color($2,$3,$4);}
              ;       
%%

int main()
{
 setup();
 yyparse();
 return(0);
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

/***********************************************************************
 *Checks input to ensure that the point is not plotted outside of the
 *confines of the window, then draws the point.
 *@param x the x coordinate of the point 
 *@param y the y coordinate of the point
***********************************************************************/
void handle_point(int x, int y) {
	if (x < 0 || x > WIDTH || y < 0 || y > HEIGHT) {
		printf("Please enter Y coordinates in the range 0 - 768 
    and X coordinates in the range 0 - 1024.\n");
		return;
	}
	point(x, y);
  return;
}

/***********************************************************************
 *Checks input to ensure that the line does not begin or end outside of
 *the confines of the window, then draws the line. 
 *@param x1 the x coordinate of one end of the line 
 *@param y1 the y coordinate of one end of the line
 *@param x1 the x coordinate of the other end of the line 
 *@param y1 the y coordinate of the other end of the line
***********************************************************************/
void handle_line(int x1, int y1, int x2, int y2) {
	if (x1 < 0 || x1 > WIDTH || x2 < 0 || x2 > WIDTH) {
		printf("Please enter X coordinates in the range 0 - %d\n", HEIGHT);
		return;
	}
	if (y1 < 0 || y1 > WIDTH || y2 < 0 || y2 > WIDTH) {
		printf("Please enter Y coordinates in the range 0 - %d\n", WIDTH);
		return;
	}
  line(x1, y1, x2, y2);
  return;
}

/***********************************************************************
 *Checks input to ensure that the center of the circle is not plotted 
 *outside the confines of the window, then draws the circle.
 *@param x the x coordinate of the circle's center. 
 *@param y the y coordinate of the circle's center.
 *@param r the radius of the circle.
***********************************************************************/
void handle_circle(int x, int y, int r() {
  if (x < 0 || x > WIDTH) {
    printf("Please enter X coordinates in the range 0 - %d\n", HEIGHT);
		return;
  }
  	if (y < 0 || y > WIDTH) {
		printf("Please enter Y coordinates in the range 0 - %d\n", WIDTH);
		return;
	}
  circle(x, y, r);
  return;
}

/***********************************************************************
 *Checks input to ensure that the upper left hand corner of the
 *rectangle is not plotted outside the confines of the window, then
 *draws the rectangle
 *@param x the x coordinate of rectangle's upper left hand corner.
 *@param y the y coordinate of rectangle's upper left hand corner.
 *@param w the width of the rectangle.
 *@param h the height of the rectangle.
***********************************************************************/
void handle_rectangle( int x, int y, int w, int h) {
  if (x < 0 || x > WIDTH) {
    printf("Please enter X coordinates in the range 0 - %d\n", HEIGHT);
		return;
  }
  if (y < 0 || y > WIDTH) {
		printf("Please enter Y coordinates in the range 0 - %d\n", WIDTH);
		return;
	}
  rectangle(x, y, w, h)
  return;
}

/***********************************************************************
 *Checks input to ensure that the values of the RGB parameters are in 
 *the range of 0 - 255, then sets the color.
 *@param r the red value.
 *@param g the green value.
 *@param b the blue value.
***********************************************************************/
void handle_set_color( int r, int g, int b) {
  if (r < 0 || g < 0 || b < 0 || r > 255 || g > 255 || b > 255) {
    printf("Please enter RBG values in the range 0 - 255\n");
    return;
  }
  set_color(r, g, b);
  return;
}