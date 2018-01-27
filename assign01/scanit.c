#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

typedef enum parseMode { P_NONE, P_FLOAT, P_INT, 
						 P_IDENTIFIER, P_ESCAPED, P_STRING } ParseMode;

bool isOperator(char c) {
	
	char operators[16] = {'&', '=', '!', ':', ',',
						'.', '>', '<', '[', ']', 
						'(', ')', '+', '_', '/', 
						'*'	};

	for (int i = 0; i < 16; i++) {
		if (operators[i] == c) return true;
	}
	return false;
}

bool isIdentifier(char c) { 
	return isalpha(c) || isdigit(c) || (c == '_');
}


const char * format = "%d: %s \'%c\' found";
const char * errorFormat = "%d: unknown character %x";


int main(){
	char c;
	char tokenTypeArr[20];
	char tokenArr[100];
	char *lineBuf = 0;
	size_t lineSize = 0;
	int lineIndex = 1;
	int tokenIndex = 0;
	ParseMode currMode = P_NONE;

	while (getline(&lineBuf, &lineSize, stdin) > 0){
		
		int i = 0;
		while (i = 0; i < lineSize; i++) {
		
			c = lineBuf[i];
			
			if (currMode == P_NONE) {
				if (isIdentifier(c)) {
					memset(tokenArr, 0, sizeof(tokenArr));
					tokenIndex = 0;
					tokenArr[tokenIndex++] = c;
				} else {
					tokenArr[tokenIndex] = '\n';
					fprintf(stderr, &format, lineIndex, "yo",tokenArr);
				}
			}
			else {
				tokenArr[tokenIndex++] = c;
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
		
		free(lineBuf);
		lineIndex++;		
	}
	
	return 0;
}

void tokenTypeStr(char* arr){
// memset(arr, )
}

