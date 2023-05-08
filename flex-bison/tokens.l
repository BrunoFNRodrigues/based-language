%{
#include <string>
#include "node.h"
#include "parser.hpp"
#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t) (yylval.token = t)
extern "C" int yywrap() { }
%}

%%

[ \t\n]                 ;
[a-zA-Z_][a-zA-Z0-9_]*  SAVE_TOKEN; return TIDENTIFIER;
[0-9]+                  SAVE_TOKEN; return TINTEGER;
"="                     return TOKEN(TEQUAL);
"NoCap"                 return TOKEN(TCEQ);
"Cap"                   return TOKEN(TCNE);
"Smol"                  return TOKEN(TCLT);
"SmolNoCap"             return TOKEN(TCLE);
"ItsOver9000!"          return TOKEN(TCGT);
"ItsOver9000!NoCap"     return TOKEN(TCGE);
"("                     return TOKEN(TLPAREN);
")"                     return TOKEN(TRPAREN);
"."                     return TOKEN(TDOT);
":"                     return TOKEN(TDDOT);
","                     return TOKEN(TCOMMA);
"+"                     return TOKEN(TPLUS);
"-"                     return TOKEN(TMINUS);
"*"                     return TOKEN(TMUL);
"/"                     return TOKEN(TDIV);
"\n"                    return TOKEN(TLB);
"!"                     return TOKEN(TEX);

"Shout"                 return TOKEN(TPRINT);
"ForReal"               return TOKEN(TWHILE);
"BASED"                 return TOKEN(TIF);
"MID"                   return TOKEN(TELSE_IF);
"CRINGE"                return TOKEN(TELSE);

"Sigma"                 return TOKEN(TDEF_FUNCTION);
"RiseAndGrind"          return TOKEN(TRETURN);

.                       printf("Unknown token!n"); yyterminate();

%%