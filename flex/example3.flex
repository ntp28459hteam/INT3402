package main;
%%
%class Search
%standalone
%line
%column
%%
(a|b)*abb {System.out.println("found");}
\n {/*Do something*/}
. {/*Do something*/}