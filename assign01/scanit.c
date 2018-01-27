#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

typedef enum parseMode { P_NONE, P_FLOAT, P_INT, 
						 P_IDENTIFIER, P_ESCAPED, P_STRING,
						 P_OPERATOR } ParseMode;

const char * parseModeStr(ParseMode p) {
	static char *parseModes[] = {"NONE", "Float", "Int", "Identifier", 
								 "_", "String", "Operator"};

	return parseModes[p];
}

bool isOperator(char c) {
	
	char operators[16] = {'&', '=', '!', ':', ',',
						'.', '>', '<', '[', ']', 
						'(', ')', '+', '_', '/', 
						'*'	};
	
	int i = 0;
	for (i = 0; i < 16; i++) {
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
			
			// fprintf(stderr, "%c", c);
			if (!isOperator(c) && !isIdentifier(c) && 
			    c != '"' && c != ' ' && c != '\0' && 
				currMode != P_STRING) {
				fprintf(stderr, errorFormat, lineIndex, c);
			}
			
			if (currMode == P_NONE) {
				if (isIdentifier(c)) {
					tokenArr[tokenIndex++] = c;
					currMode = P_IDENTIFIER;
				} else if (isOperator(c)) {
					tokenArr[tokenIndex++] = c;
					currMode = P_OPERATOR;
				} else if (c == "\"") {
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
				}
			}
			else {
				if (c == ' ' || c == '\n') {
					tokenArr[tokenIndex] = '\0';
					fprintf(stderr, format, lineIndex, 
							parseModeStr(currMode),tokenArr);
					currMode = P_NONE;
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
				}
				else {
					tokenArr[tokenIndex++] = c;
				}
			}
			// else if (currMode == ) {
			//	if (c == ' ') {}
			//}
			//else if 
			//
			//}	
			//else if (c == '\') {
			//
			//}

		}
		
		// free(lineBuf);
		lineIndex++;		
	}
	
	return 0;
}

void tokenTypeStr(char* arr){
// memset(arr, )
}

