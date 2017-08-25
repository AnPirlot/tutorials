vader(anton,bart).
vader(anton,daan).
vader(anton,elisa).
vader(fabian,anton).

moeder(celine,bart).
moeder(celine,daan).
moeder(celine,gerda).
moeder(gerda,hendrik).

sibling(X,Y):-
	X \== Y,
	moeder(M,X),
	moeder(M,Y),
	vader(V,X),
	vader(V,Y).

voorvader(X,Y):-
	vader(X,Y).
voorvader(X,Y):-
	voorvader(X,Z),
	vader(Z,Y).