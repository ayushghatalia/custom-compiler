# Makefile for compiling a program using Flex, Bison, and GCC

# Variables
FLEX = flex
BISON = bison
CC = gcc
ARGS ?= testinput.tetris

# Target for generating the lexer
lex.yy.c: extetrickscanner.l
	@$(FLEX) extetrickscanner.l

# Target for generating the parser
a2version2.tab.c a2version2.tab.h: a2version2.y
	$(BISON) -d -r all a2version2.y

# Target for compiling the program
x2021A7PS2571G: extetrickstype.c lex.yy.c a2version2.tab.c
	$(CC) extetrickstype.c lex.yy.c a2version2.tab.c -o x2021A7PS2571G

# Target for running the program with input from testinput
run: x2021A7PS2571G
	./x2021A7PS2571G < $(ARGS) 2>error.txt > translated.py
	@python3 translated.py

# Clean target
clean:
	rm -f lex.yy.c a2version2.tab.c a2version2.tab.h x2021A7PS2571G

# Phony targets
.PHONY: run clean