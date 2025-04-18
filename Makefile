all: compiler

compiler: parser.tab.c lex.yy.c
	gcc -o compiler parser.tab.c lex.yy.c -I.

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

clean:
	rm -f compiler lex.yy.c parser.tab.c parser.tab.h

run: all
	./compiler < sample.txt






