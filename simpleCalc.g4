grammar simpleCalc;

start   : (as+=expr)* e=expr EOF;




/* A grammar for arithmetic expressions */

expr : x=ID    	                                                        # Variable
     | c=FLOAT	                                                        # Constant
     | e1=expr op=PO e2=expr                                            # MulDiv
     | e1=expr op=OP e2=expr                                            # AddSub
     | e1=expr op=GEL e2=expr                                           # Relation
     | x=ID '=' e=expr  ';'                                             # Assign
     | '(' e=expr ')'	                                                # Parenthesis
     | op=OP f=FLOAT                                                    # SignedConstant
     | '!' e=expr                                                       # Ifnot
     | e1=expr '&&' e2=expr                                             # Ifand
     | e1=expr '||' e2=expr                                             # Ifor
     | '{' e=expr* '}'                                                  # Sequence
     | whileloop                                                        # Loop
     | ifelse                                                           # ifstat
     | 'input()'                                                        # Input
;

// Lexer:

whileloop : 'while'  '('e1=expr')'  e2=expr                                   # While;
ifelse    : 'if'  '('e1=expr')'   e2=expr ('else' e3=expr)*                   # If;

OP : ('-'|'+') ;        
PO : ('*' | '/');
GEL : ('>' |'=='| '<' );



ID    : ALPHA (ALPHA|NUM)* ;
FLOAT : NUM+ ('.' NUM+)? ;

ALPHA : [a-zA-Z_ÆØÅæøå] ;
NUM   : [0-9] ;

WHITESPACE : [ \n\t\r]+ -> skip;
COMMENT    : '//'~[\n]*  -> skip;
COMMENT2   : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip;
