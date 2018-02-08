/*
 * scanner.l - a lexical analyzer for P-
 *
 * <Your name>
 *
 * Date:
 * Modification History:
 *
 */

%{

/* Include files and global variables go here */

#include <stdio.h>
#include <string.h>
#include "msg.h"

int cLine = 1;
extern int cErrors;
extern char *infile;

%}

KEYWORDS		(?i:ARRAY)|(?i:BEGIN)|(?i:BOOL)|(?i:ELSE)|(?i:ELIF)|(?i:END)|(?i:FALSE)|(?i:FOR)|(?i:FLOAT)|(?i:FUNCTION)|(?i:IF)|(?i:IN)|(?i:INT)|(?i:OF)|(?i:PROCEDURE)|(?i:PROGRAM)|(?i:READ)|(?i:RECORD)|(?i:RETURN)|(?i:THEN)|(?i:TRUE)|(?i:WHILE)|(?i:WRITE)


IDENTIFIER			([a-zA-Z]|_)([a-zA-Z]|[0-9]|_)*
SIMPLE_OPERATOR		&|=|!|:|,|"."|>|<|"["|"]"|"("|")"|"+"|-|"/"|"*"|;
COMPOUND_OPERATOR	&&|"||"|>=|<=|==|!=|".."
RANGE_OPERATOR		{INTEGER}".."{INTEGER}
OPERATOR			{SIMPLE_OPERATOR}|{COMPOUND_OPERATOR}
INTEGER				[0-9]+
FLOAT				{INTEGER}*({INTEGER}"."|"."{INTEGER}){INTEGER}*
STRING				\"[^"\n]*\"
BAD_STRING			\"([^"]|\n)*\n[^"]*

%%
				/* Local variables go here */

"/*"([^/]|"*"[^*/]*"/"|\n)*"*/"		{
				cLine += countNewLine(yytext);
				}
[ \t\f]+		{}
"\n"            {
				cLine++;
				}
{BAD_STRING}	{ 
				fprintf(stderr, message[mnIllegalString], cLine);
				yyterminate();
				}
{STRING}		{
				fprintf(stderr, message[mnTokenFound], cLine, "String", yytext);
				}
{KEYWORDS}		{
                fprintf(stderr, message[mnTokenFound], cLine, "Keyword", yytext);
				}
{IDENTIFIER}	{
				fprintf(stderr, message[mnTokenFound], cLine, "Identifier", yytext);
				}
{RANGE_OPERATOR}	{
				int i = 0;
				char firstNum[yyleng];
				for (i = 0; i < yyleng; i++) {
					if (yytext[i] == '.') {
						strncpy(firstNum,  yytext, i);
						yyless(i);
						break;
					}
				}
				firstNum[i] = '\0';
				fprintf(stderr, message[mnTokenFound], cLine, "Integer", firstNum);
				}
{FLOAT}			{
				fprintf(stderr, message[mnTokenFound], cLine, "Float", yytext);
				}	
{OPERATOR}	    {
				fprintf(stderr, message[mnTokenFound], cLine, "Operator", yytext);
				}
{INTEGER}		{
				fprintf(stderr, message[mnTokenFound], cLine, "Integer", yytext);
				}
  .				{
                fprintf(stderr, message[mnUnknownChar], cLine, yytext[0], yytext[0]);
                cErrors++;
				}



%%

/* User routines go here */
