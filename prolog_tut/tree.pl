depth(empty,0).
depth((node(empty,_,empty)), 1).
depth(node(Left,_,Right),Depth):-
	depth(Left,Ldepth),
	depth(Right,Rdepth),
	Depth is 1+max(Ldepth,Rdepth).
	