#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

typedef enum parseMode { P_NONE, P_FLOAT, P_INT, 
						 P_IDENTIFIER, P_ESCAPED, P_STRING,
						 P_OPERATOR } ParseMode;

const char * parseModeStr(ParseMode p) {
	static char *parseModes[] = {"NONE", "float", "integer", "identifier", 
								 "_", "string", "operator"};

	return parseModes[p];
}

bool isOperator(char c) {
	
	char operators[17] = {'&', '=', '!', ':', ',',
						'.', '>', '<', '[', ']', 
						'(', ')', '+', '_', '/', 
						'*', ';'};
	
	int i = 0;
	for (i = 0; i < sizeof(operators); i++) {
		if (operators[i] == c) return true;
	}
	return false;
}

bool isIdentifier(char c) { 
	return isalpha(c) || isdigit(c) || (c == '_');
}

void resetToken(char * tokenArr, size_t arrSize, int* tokenIndex){
	memset(tokenArr, 0, sizeof(arrSize));
	*tokenIndex = 0;
}

bool findChar(char * tokenArr, size_t tokenSize, char c){
	int i = 0;
	for (i = 0; i < tokenSize; i++) {
		if (tokenArr[i] == c) return true;
	}
	return false;
}


const char * format = "%d: %s \'%s\' found\n";
const char * errorFormat = "%d: unknown character %c\n";

int main(void){
	char c;
	char tokenTypeArr[20];
	char tokenArr[100];
	char *lineBuf = 0;
	size_t lineSize = 0;
	int lineIndex = 1;
	int tokenIndex = 0;
	ParseMode currMode = P_NONE;

	memset(tokenArr, 0, sizeof(tokenArr));

	while (getline(&lineBuf, &lineSize, stdin) > 0) {
		
		int i = 0;
		for (i = 0; i < lineSize - 1; i++) {
		
			c = lineBuf[i];
			
			if (c == '\n') continue;	
			
			if (!isOperator(c) && !isIdentifier(c) && 
			    c != '"' && c != ' ' && c != '\0' && c != '\\' &&
				c != ';' &&
				currMode != P_STRING) {
				if (tokenIndex != 0) {
					fprintf(stderr, format, lineIndex, 
						parseModeStr(currMode),tokenArr);
					currMode = P_NONE;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
				}
				fprintf(stderr, errorFormat, lineIndex, c);
			}
			
			if (currMode == P_NONE) {
				if (isdigit(c)) {
					tokenArr[tokenIndex++] = c;
					currMode = P_INT;
				} else if (isIdentifier(c)) {
					tokenArr[tokenIndex++] = c;
					currMode = P_IDENTIFIER;
				} else if (isOperator(c)) {
					tokenArr[tokenIndex++] = c;
					currMode = P_OPERATOR;
				} else if (c == '"') {
					currMode = P_STRING;
				}
			}
			else if (currMode == P_IDENTIFIER){
				if (isIdentifier(c)) {
					tokenArr[tokenIndex++] = c;
				} else {
					fprintf(stderr, format, lineIndex, 
							parseModeStr(currMode),tokenArr);
					currMode = P_NONE;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
					i--;
				}
			} 
			else if (currMode == P_OPERATOR) {
				if (findChar(tokenArr, tokenIndex, '.') &&
						isdigit(c)) {
					tokenArr[tokenIndex++] = c;
					currMode = P_FLOAT;
				} else {
					fprintf(stderr, format, lineIndex, 
							parseModeStr(currMode),tokenArr);
					currMode = P_NONE;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
					i--;
				}
			}
			else if (currMode == P_STRING) {
				if (c == '\\') {
					tokenArr[tokenIndex++] = lineBuf[++i];
				}
				else if (c == '"') {
					fprintf(stderr, format, lineIndex, 
							parseModeStr(currMode),tokenArr);
					currMode = P_NONE;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
				} else {
					tokenArr[tokenIndex++] = c;
				}
			}
			else if (currMode == P_INT) {
				if (isdigit(c)) {
					tokenArr[tokenIndex++] = c;
				}
				else if (c == '.') {
					tokenArr[tokenIndex++] = c;
					currMode = P_FLOAT;
				} else {
					fprintf(stderr, format, lineIndex, 
							parseModeStr(currMode),tokenArr);
					currMode = P_NONE;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
					i--;
				} 
			}
			else if (currMode == P_FLOAT){
				bool secondDot = c == '.' && 
								findChar(tokenArr, tokenIndex, '.');
				if (isdigit(c)) {
					tokenArr[tokenIndex++] = c;
				} else if(secondDot){
					fprintf(stderr, format, lineIndex, 
						parseModeStr(currMode),tokenArr);
					currMode = P_OPERATOR;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
					tokenArr[tokenIndex++] = c;			
				} else {
					fprintf(stderr, format, lineIndex, 
							parseModeStr(currMode),tokenArr);
					currMode = P_NONE;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
				}
			}
			else {
				// 	
			}
		}
		
		memset(lineBuf, 0, lineSize);	
		free(lineBuf);
		lineBuf = NULL;
		lineIndex++;		
	}
	
	return 0;
}


