/*
 * msg.h -- List of messages for P- compiler
 *
 * <Your name here>
 *
 * Date:
 * Modification History:
 *
 */

/* Some error definitions for the scanner */
#define mnTokenFound					   0
#define mnUnknownChar                      1
#define mnIllegalString                    2

/* Actual messages */
static char *message[] = {
    "%d: %s '%s' found\n",
    "%d: unknown character %#x '%c' \n",
    "%d: illegal string\n",
};

int countNewLine(char* text){
	int count = 0;
	char *s = text;
	while (*s != '\0'){
		if (*s == '\n') count++;
		s++;
	}
	return count;
}
