%{
    #include "node.h"
    NBlock *programBlock; /* the top level root node of our final AST */

    extern int yylex();
    void yyerror(const char *s) { printf("ERROR: %sn", s); }
%}

/* Represents the many different ways we can access our data */
%union {
    Node *node;
    NBlock *block;
    NExpression *expr;
    NStatement *stmt;
    NIdentifier *ident;
    NVariableDeclaration *var_decl;
    std::vector<NVariableDeclaration*> *varvec;
    std::vector<NExpression*> *exprvec;
    std::string *string;
    int token;
}

/* Define our terminal symbols (tokens). This should
   match our tokens.l lex file. We also define the node type
   they represent.
 */
%token <string> TIDENTIFIER TINTEGER
%token <token> TCEQ TCNE TCLT TCLE TCGT TCGE TEQUAL
%token <token> TLPAREN TRPAREN TCOMMA TDOT TDDOT TEX TRETURN
%token <token> TPLUS TMINUS TMUL TDIV TWHILE TIF TELSE TELSE_IF TPRINT TLB TDEF_FUNCTION

/* Define the type of node our nonterminal symbols represent.
   The types refer to the %union declaration above. Ex: when
   we call an ident (defined by union type ident) we are really
   calling an (NIdentifier*). It makes the compiler happy.
 */
%type <ident> ident
%type <expr> numeric expr 
%type <varvec> func_decl_args
%type <exprvec> call_args
%type <block> program stmts block
%type <stmt> stmt var_decl func_decl while_stmt if_stmt else_if print_stmt return_stmt
%type <token> comparison

/* Operator precedence for mathematical operators */
%left TPLUS TMINUS
%left TMUL TDIV

%start program

%%

program : stmts { programBlock = $1; }
        ;
        
stmts : stmt { $$ = new NBlock(); $$->statements.push_back($<stmt>1); }
      | stmts stmt { $1->statements.push_back($<stmt>2); }
      ;

stmt : var_decl | func_decl | while_stmt | if_stmt | print_stmt | return_stmt
     | expr { $$ = new NExpressionStatement(*$1); }
     ;

block : stmts TLB { $$ = $1; }
      | TLB { $$ = new NBlock(); }
      ;

while_stmt : TWHILE expr TDDOT block { $$ = new NWhileStatement(*$2, *$4); delete $2; delete $4;}
           ;

if_stmt : TIF expr TDDOT block { $$ = new NIfStatement(*$2, *$4, std::vector<NIfStatement::ElseIfClause>(), nullptr); delete $2; delete $4; }
        | TIF expr TDDOT block else_if { $$ = new NIfStatement(*$2, *$4, *$5, nullptr); delete $2; delete $4; delete $5; }
        | TIF expr TDDOT block TELSE block { $$ = new NIfStatement(*$2, *$4, std::vector<NIfStatement::ElseIfClause>(), $6); delete $2; delete $4; delete $6; }
        | TIF expr TDDOT block else_if TELSE block { $$ = new NIfStatement(*$2, *$4, *$5, $7); delete $2; delete $4; delete $5; delete $7; }
        ;

else_if : TELSE_IF expr TDDOT block { $$ = std::vector<NIfStatement::ElseIfClause>(); $$->emplace_back(*$2, *$4); delete $2; delete $4; }
        | else_if TELSE_IF expr TDDOT block { $1->emplace_back(*$3, *$5); delete $3; delete $5; }
        ;

print_stmt : TPRINT TEX expr TEX { $$ = new ExpressionPrintNode($3); }
           ;

return_stmt : TRETURN expr { $$ = new NReturnStatement($2); }
            ;

var_decl :  ident TEQUAL expr { $$ = new NVariableDeclaration(*$1, $3); }
         ;
        
func_decl : TDEF_FUNCTION ident TLPAREN func_decl_args TRPAREN block 
            { $$ = new NFunctionDeclaration(*$2, *$4, *$6); delete $4; }
          ;
    
func_decl_args : /*blank*/  { $$ = new VariableList(); }
          | var_decl { $$ = new VariableList(); $$->push_back($<var_decl>1); }
          | func_decl_args TCOMMA var_decl { $1->push_back($<var_decl>3); }
          ;

ident : TIDENTIFIER { $$ = new NIdentifier(*$1); delete $1; }
      ;

numeric : TINTEGER { $$ = new NInteger(atol($1->c_str())); delete $1; }
        ;
    
expr : ident TEQUAL expr { $$ = new NAssignment(*$<ident>1, *$3); }
     | ident TLPAREN call_args TRPAREN { $$ = new NMethodCall(*$1, *$3); delete $3; }
     | ident { $<ident>$ = $1; }
     | numeric
     | expr comparison expr { $$ = new NBinaryOperator(*$1, $2, *$3); }
     | TLPAREN expr TRPAREN { $$ = $2; }
     ;
    
call_args : /*blank*/  { $$ = new ExpressionList(); }
          | expr { $$ = new ExpressionList(); $$->push_back($1); }
          | call_args TCOMMA expr  { $1->push_back($3); }
          ;

comparison : TCEQ | TCNE | TCLT | TCLE | TCGT | TCGE 
           | TPLUS | TMINUS | TMUL | TDIV
           ;

%%