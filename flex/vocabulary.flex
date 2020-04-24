package main;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
// import javafx.util.Pair;
%%
%class Lexer
%standalone
%line
%column

Bools = true|false
Floats = ({digit})*{fraction}({exponent})? | {digit}+\. | {digit}+\.?exponent
digit = [0-9]
fraction = \.[0-9]+
exponent = (E|e)(\+|\-)?(digit)+
Integers = \d+ /* Integers = [0-9]+ */
Strings = \"([A-Za-z]|\\b|\\f|\\n|\\r|\\t|\\'|\\''|[\\])*\"
Keywords = boolean|break|continue|else|for|float|if|int|return|void|while
Identifiers = {letter}({letter}|{digit})*
letter = [A-Za-z_]

ArithmeticOperators = \+|\-|\*|\/
RelationalOperators = \<|\<=|\>|\>=
EqualityOperators = "=="|"!="
LogicalOperators = \|\||\&\&|\!
AssignmentOperator = "="

Comments = {onelineComment}|{multilineComment}
onelineComment = "//"[\x00-\x7F]*(\x10|\x13|\x10\x13)
multilineComment = "/*"[\x00-\x7F]*"*/"
Separators = \{|\}|\(|\)|\[|\]|\;|\, 

/*Delimiters = {|}|(|)|[|]|;|,*/ 
%{
	List<String> numbers = new ArrayList<>();
	Map<String, Token> tokens = new HashMap<>(); // List<Pair<String,Token>> Token = new ArrayList<>();
	List<String> keywords = new ArrayList<>();
%}

%{
    public void showRes() {
        System.out.print("Token: \n");
        for(Map.Entry<String, Token> entry : tokens.entrySet()) {
            System.out.println("Lexeme: " + entry.getKey() + ", token: " + entry.getValue());
        }
    }
%}

%%
/*
{Integers} {tokens.add(
                    new Pair<String, Token>(yytext(), Token.INT_LITERAL)
                );}
*/
{Integers} {tokens.put(yytext(), Token.INT_LITERAL);}
{Bools} {tokens.put(yytext(), Token.BOOL_LITERAL);}
{Floats} {tokens.put(yytext(), Token.FLOAT_LITERAL);}
{Strings} {tokens.put(yytext(), Token.STRING_LITERAL);}
{Keywords} {tokens.put(yytext(), Token.KEYWORD);}
{Identifiers} {tokens.put(yytext(), Token.IDENTIFIER);}
{ArithmeticOperators} {tokens.put(yytext(), Token.ARITHMETIC_OPERATOR);}
{RelationalOperators} {tokens.put(yytext(), Token.RELATIONAL_OPERATOR);}
{EqualityOperators} {tokens.put(yytext(), Token.EQUALITY_OPERATOR);}
{LogicalOperators} {tokens.put(yytext(), Token.LOGICAL_OPERATOR);}
{AssignmentOperator} {tokens.put(yytext(), Token.ASSIGNMENT_OPERATOR);}
{Comments} {tokens.put(yytext(), Token.COMMENT);}
{Separators} {tokens.put(yytext(), Token.SEPARATOR);}

\n { /* Do nothing*/ }
. { /* Do nothing*/ }