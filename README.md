# based-language
Linguagem com a finalidade de entrer, a linguagem based é um clone da linguagem python com alterções para incorpar memes como seus operadores.


# BLOCK E STATEMENT
BLOCK = { STATEMENT };
STATEMENT = ( λ | ASSIGNMENT | PRINT | CONDITONAL | LOOP | FUNCTION | RETURN), "\n" ;

# ASSIGMENT
ASSIGNMENT = IDENTIFIER, "=", EXPRESSION ["<o", ( {IDENTIFIER, (",", λ)} | λ ) ,"o>"] ;

# PRINTS
PRINT = "Shout", "!", EXPRESSION, "!" ;

# CONDITIONAL
CONDITONAL_IF = ("BASED", COMPARISON, ":", BLOCK [CONDITONAL_ELSE] |
                "BASED", COMPARISON, ":", BLOCK, CONDITONAL_ELSE_IF);
CONDITONAL_ELSE_IF = ('MID', COMPARISON ':' BLOCK, CONDITONAL_ELSE_IF |
                  'MID', COMPARISON ':' BLOCK [CONDITONAL_ELSE] );
CONDITONAL_ELSE = "CRINGE", ":", BLOCK;

# LOOPS
LOOP = "For real", COMPARISON, ":" BLOCK;

# FUCTION
FUNCTION =  "Sigma", IDENTIFIER, "<o", ( {IDENTIFIER, (",", λ)} | λ ), "o>", ":", BLOCK;
RETURN = "Rise and Grind", EXPRESSION;

# EXPRESSION, TERM E FACTOR
EXPRESSION = TERM, { ("+" | "-"), TERM } ;
TERM = FACTOR, { ("*" | "/"), FACTOR } ;
FACTOR = (("+" | "-"), FACTOR) | NUMBER | "(", EXPRESSION, ")" | IDENTIFIER ;

# COMPARISON
COMPARISON = (EQUAL | NOT_EQUAL | LESSER_EQUAL | LESSER | GRATER_EQUAL | GRATER);
EQUAL = EXPRESSION, 'No cap', EXPRESSION;
NOT_EQUAL = EXPRESSION, 'Cap', EXPRESSION;
LESSER_EQUAL = EXPRESSION, 'Smol No cap', EXPRESSION;
LESSER = EXPRESSION, 'Smol', EXPRESSION 
GRATER_EQUAL = EXPRESSION, 'Its Over 9000! No cap', EXPRESSION 
GRATER = EXPRESSION, 'Its Over 9000!', EXPRESSION 

# IDENTIFIER, NUMBER E LETTER
IDENTIFIER = LETTER, { LETTER | DIGIT | "_" } ;
NUMBER = DIGIT, { DIGIT } ;
LETTER = ( a | ... | z | A | ... | Z ) ;
DIGIT = ( 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 ) ;

