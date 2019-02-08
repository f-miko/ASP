% ASP-solution for the logic puzzle Yosenabe. See README for rules. Instances taken from: https://www.janko.at/Raetsel/Yosenabe/index.htm

dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% HINTS:
% - You may use the gaps of adjacent cells' coordinates to denote directions.
% - Develop your encoding incrementally and check the additions. If in doubt
%   whether rules are correct, the "--text" option of gringo/clingo allows
%   for investigating the instantiation, while small instances are advisable.

% Your implementation please...

% instantiation: number(X,Y,N), cell(X,Y), area(X,Y,A), goal(A,V).
% target consists of two cells
% 
% GENERATING

1 { move(X,Y,N,X+I,Y+J) : dir(I,J)} 1:- number(X,Y,N). % From each number, try one move in each direction
0 { move(X,Y,N,X+I,Y+J)} 1 :- cell(X+I,Y+J), move(X-I,Y-J,N,X,Y), dir(I,J). %try a next move in the same direction
0 {target(X,Y,X',Y')} 1 :- number(X,Y,N), move(X,Y,N,X+I,Y+J),move(X'-I,Y'-J,N,X',Y'),dir(I,J), area(X',Y',_), not area(X'-I,Y'-J,_), not move(X',Y',N,_,_).
% choose at most one target if there is a number, move from the number and to the target position on a straight line, if the position is an are and there is no move leaving the target, 
targetN(A,N,X',Y') :- target(X,Y,X',Y'), number(X,Y,N), area(X',Y',A). % final coordinates of the number, its value and the area
numparea(A,S) :- S = #sum{C,X,Y : targetN(A,C,X,Y)},targetN(A,_,_,_), goal(A,_).  % sum all numbers in an area with area number (differentiate between same numbers with different coordinates%%%

:- move(_,_,_,X',Y'), not cell (X',Y'). %no move if next cell doesnt exist
:- move(_,_,_,X',Y'), number(X',Y',_).  %no move if moving to a number field.
:- not 0{move(_,_,_,X',Y')}1, cell(X',Y'). % no more than one move per field



:- target(X,Y,X',Y'), target(X2,Y,X2',Y'), X<X2,X'>X2'. % in case of same number on a line (twice in a row or column), no switching coordinates
:- target(X,Y,X',Y'), target(X,Y2,X',Y2'), Y<Y2,Y'>Y2'. 
:- target(X,Y,X',Y'), X!=X',Y!=Y'. % no target, if both coordinates change

:- not 0{target(_,_,X',Y')}1, cell(X',Y').% no more than one target per field
:- not 1{target(X,Y,_,_)}1, number(X,Y,_).% every number needs a target
:- not targetN(A,_,_,_), area(_,_,A).    %no empty areas.



:- goal(A,V), numparea(A,S), S!=V. % areas with goal have to have the goal value.

#show target/4.

