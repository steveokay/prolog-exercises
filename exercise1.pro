successor(zero,one).
successor(one,two).
successor(two,three).
successor(three,four).
successor(four,five).
successor(five,six).
successor(six,seven).
successor(seven,eight).
successor(eight,nine).

predecessor(X,Y):-successor(Y,X).

/* using recursion to introduce an add predicate */
add(X,zero,X).
add(X,Y,Z):-successor(A,Y),add(X,A,B),successor(B,Z).

/* how about subtracting? */
/* x+y=z -> z-y=x */
/* sub(X,Y,Z):-successor(A,Y),add(X,A,B),predecessor(B,Z).*/
sub(Z,Y,X):-add(X,Y,Z).

/* multiplication */
%% mul(X,one,X).
mul(_,zero,zero).
mul(X,Y,Z):-successor(A,Y),mul(X,A,B),add(X,B,Z).

/* relations: =, >, <, not = */
eq(X,Y):-sub(X,Y,zero).
gt(X,Y):-sub(X,one,A),sub(A,Y,B),eq(B,B).
lt(X,Y):-gt(Y,X).
neq(X,Y):-sub(X,Y,A),gt(A,zero).
neq(X,Y):-sub(Y,X,A),gt(A,zero).
/** return max of two number
  * check if x>y
  * check if y>x
  * check if x=y
  */
max(X,Y):-gt(X,Y),write(X).
max(X,Y):-gt(Y,X),write(Y).
max(X,Y):-eq(X,Y),write(X).

/* divison of integer */
div(X,X,one).
/** using successor at last because I only increment by one and
  * an addition with one would result in more actions than
  * using successor()
  */
div(X,Y,Z):-sub(X,Y,A),div(A,Y,B),successor(B,Z).

/* module */
mod(X,X,zero).
mod(_,one,zero).
mod(X,Y,Z):-gt(Y,X),sub(Y,X,Z).
mod(X,Y,zero):-lt(Y,X),div(X,Y,_).
mod(X,Y,Z):-
	lt(Y,X),
	predecessor(X,A),
	mod(A,Y,B),
	successor(B,Z),
	lt(Z,Y).
