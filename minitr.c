#include <stdlib.h>
#include <stdio.h>

int main(int argc, char** argv)
{
    char tmpbuf[1];
	char *arg, *strstart;
	char fromc, toc;

	if(argc < 3) {
		fprintf(stderr, "Usage: %s <from-char> <to-char> [string]\n", argv[0]);
		exit(1);
	}

	if(argc > 3)
		strstart = arg = argv[3];
    else
		strstart = arg = tmpbuf;

	fromc = *argv[1];
	toc = *argv[2];

	while(*arg) {
		if(*arg == fromc) *arg=toc;
		arg++;
	}

	puts(strstart);
}
