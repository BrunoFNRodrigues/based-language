# Based Language
<img src="./img/Gigachad.jpg" width="250"/>

### Linguagem com a finalidade de entreter e fazer uma piada. A linguagem based é inspirada na linguagem python com alterções para incorpar memes e girias da geração z como seus operadores.



# EBNF
## BLOCK E STATEMENT
BLOCK = { STATEMENT };
STATEMENT = ( λ | ASSIGNMENT | PRINT | CONDITONAL | LOOP | FUNCTION | RETURN), "\n" ;

## ASSIGMENT
ASSIGNMENT = IDENTIFIER, "=", EXPRESSION ["(", ( {IDENTIFIER, (",", λ)} | λ ) ,")"] ;

## PRINTS
PRINT = "Shout", "(", EXPRESSION, ")" ;

## CONDITIONAL
CONDITONAL_IF = ("BASED", COMPARISON, "\n", BLOCK | λ, CONDITONAL_ELSE | "end");
CONDITONAL_ELSE = "CRINGE", "\n", BLOCK | λ, "end";

## LOOPS
LOOP = "ForReal", COMPARISON, "\n" BLOCK, "end";

## FUCTION
FUNCTION =  "Sigma", IDENTIFIER, "(", ( {IDENTIFIER, (",", λ)} | λ ), ")", "\n", BLOCK, "end";
RETURN = "RiseAndGrind", EXPRESSION;

## REL. EXPRESSION, EXPRESSION, TERM E FACTOR
REL. EXPRESSION = EXPRESSION, {COMPARISON, TERM} ;
EXPRESSION = TERM, { ("+" | "-" | "||"), TERM } ;
TERM = FACTOR, { ("*" | "/" | "&&"), FACTOR } ;
FACTOR = (("+" | "-" | "!"), FACTOR) | NUMBER | "(", EXPRESSION, ")" | IDENTIFIER | (IDENTIFIER, "(", (EXPRESSION | [{EXPRESSION, ","}] | λ) , ")" ) ;

## COMPARISON
COMPARISON = (EQUAL | NOT_EQUAL | LESSER_EQUAL | LESSER | GRATER_EQUAL | GRATER);
EQUAL = EXPRESSION, 'NoCap', EXPRESSION;
NOT_EQUAL = EXPRESSION, 'Cap', EXPRESSION;
LESSER_EQUAL = EXPRESSION, 'SmolNoCap', EXPRESSION;
LESSER = EXPRESSION, 'Smol', EXPRESSION ;
GRATER_EQUAL = EXPRESSION, 'ItsOver9000NoCap', EXPRESSION ;
GRATER = EXPRESSION, 'ItsOver9000', EXPRESSION ;

## IDENTIFIER, NUMBER E LETTER
IDENTIFIER = LETTER, { LETTER | DIGIT | "_" } ;
NUMBER = DIGIT, { DIGIT } ;
LETTER = ( a | ... | z | A | ... | Z ) ;
DIGIT = ( 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 ) ;


---
## Referencias:
https://gnuu.org/2009/09/18/writing-your-own-toy-compiler/
