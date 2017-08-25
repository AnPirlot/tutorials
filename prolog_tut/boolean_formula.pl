eval(true,true).
eval(false,false).

eval(not(false),true).
eval(not(true),false).
eval(not(Expr),Boolresult):-
	eval(Expr,ExprResult),
	eval(not(ExprResult),Boolresult).

eval(or(_,true),true).
eval(or(true,_),true).
eval(or(Expr1, Expr2),Boolresult):-
	eval(Expr1,Expr1Result),
	eval(Expr2,Expr2Result),
	eval(or(Expr1Result,Expr2Result),Boolresult).

eval(and(true,true),true).
eval(and(false,true),false).
eval(and(true,false),false).
eval(and(Expr1, Expr2),Boolresult):-
	eval(Expr1,Expr1Result),
	eval(Expr2,Expr2Result),
	eval(and(Expr1Result,Expr2Result),Boolresult).