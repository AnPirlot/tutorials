peano_plus(nul,X,X).
peano_plus(s(X),Y,s(Z)):-
	peano_plus(X,Y,Z).

peano_min(X,X,nul).
peano_min(s(X),Y,s(Z)):-
	peano_min(X,Y,Z).

greater_than(s(_),nul).
greater_than(s(X),s(Y)):-
	greater_than(X,Y).

maximum(X,nul,X).
maximum(nul,Y,Y).
maximum(s(X),s(Y),s(Z)):-
	maximum(X,Y,Z).