% ASP solution to the Minotaur puzzle. Rules see README. Instances taken from: https://www.janko.at/Spiele/Minotaurus/index.htm
% Think: 
% MINO movement depends on its position and position of theseus. First priority is a horizontal movemnt, next vertical, otherwise none. That means:
% For each position of Theseus and the Minotaur, the move the minotaur will make is horizontal, if there is no wall and the X corrdinates of T and M are different. Otherwise
% it will be a vertical movement, if X coordinates are the same or if X are not the same but there is a wall in the direction of T from Ms perspective. If no movement is possible,
% M remains in place -> construct a table of minotaur movements depending on Ms and Ts position. Would have (X*Y) * (X*Y-1) entries: 9 * 9 - 1 = 72 for level 1, 64 * 63 = 4032 for 
% level 10.


% Generate
% Guess solution candidates here!
wall(X,Y,X',Y') :- wall(X',Y',X,Y).
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0). dir(0,0).
at(TX,TY,0) :- start(TX,TY).
at_m(MX,MY,0) :- mino(MX,MY).

% Minotaur horizontal movements (highest priority), whenever Mino is on a different X than T, he will move horizontally as long as there is immediate wall in that direction
mino_h(TX,TY,MX,MY,MX+((TX-MX)/|TX-MX|),MY) :- field(TX,TY), field(MX,MY), TX != MX, not wall(MX,MY,MX+((TX-MX)/|TX-MX|),MY).%, not wall(MX+((TX-MX)/|TX-MX|),MY,MX,MY).
%mino_h(TX,TY,MX,MY,MX+1,MY) :- field(TX,TY), field(MX,MY), TX > MX, not wall(MX,MY,MX+1,MY), not wall(MX+1,MY,MX,MY).
%mino_h(TX,TY,MX,MY,MX-1,MY) :- field(TX,TY), field(MX,MY), TX < MX, not wall(MX,MY,MX-1,MY), not wall(MX-1,MY,MX,MY).

% Next he will move vertically, if T is on the same X or on a different X and Y, but there are no walls in the immediate horizontal neighborhood
mino_v(TX,TY,MX,MY,MX,MY+((TY-MY)/|TY-MY|)) :- field(TX,TY), field(MX,MY), TX == MX, TY != MY, not wall(MX,MY,MX,MY+((TY-MY)/|TY-MY|)).%, not wall(MX,MY+((TY-MY)/|TY-MY|),MX,MY).
mino_v(TX,TY,MX,MY,MX,MY+((TY-MY)/|TY-MY|)) :- field(TX,TY), field(MX,MY), TX != MX, TY != MY, not wall(MX,MY,MX,MY+((TY-MY)/|TY-MY|)), not mino_h(TX,TY,MX,MY,MX+1,MY), not mino_h(TX,TY,MX,MY,MX-1,MY). %not wall(MX,MY+((TY-MY)/|TY-MY|),MX,MY).

%mino_v(TX,TY,MX,MY,MX,MY+1) :- field(TX,TY), field(MX,MY), TY > MY, not wall(MX,MY,MX,MY+1), not wall(MX,MY+1,MX,MY), not mino_h(TX,TY,MX,MY,MX+1,MY), not mino_h(TX,TY,MX,MY,MX-1,MY).
%mino_v(TX,TY,MX,MY,MX,MY-1) :- field(TX,TY), field(MX,MY), TY < MY, not wall(MX,MY,MX,MY-1), not wall(MX,MY-1,MX,MY), not mino_h(TX,TY,MX,MY,MX+1,MY), not mino_h(TX,TY,MX,MY,MX-1,MY).

% Lastly, he will not move if he is on a different X and Y than T, but there are no movements in horizontal or vertical direction

mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX != MX,TY != MY, not mino_h(TX,TY,MX,MY,MX+((TX-MX)/|TX-MX|),MY), not mino_h(TX,TY,MX+((TX-MX)/|TX-MX|),MY,MX,MY), not mino_v(TX,TY,MX,MY,MX,MY+((TY-MY)/|TY-MY|)), not mino_v(TX,TY+((TY-MY)/|TY-MY|),MX,MY,MX,MY).
mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX != MX,TY == MY, not mino_h(TX,TY,MX,MY,MX+((TX-MX)/|TX-MX|),MY), not mino_h(TX,TY,MX+((TX-MX)/|TX-MX|),MY,MX,MY).
mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX == MX,TY != MY, not mino_v(TX,TY,MX,MY,MX,MY+((TY-MY)/|TY-MY|)), not mino_v(TX,TY+((TY-MY)/|TY-MY|),MX,MY,MX,MY).


%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX > MX,TY > MY, not mino_h(TX,TY,MX,MY,MX+1,MY), not mino_h(TX,TY,MX+1,MY,MX,MY), not mino_v(TX,TY,MX,MY,MX,MY+1), not mino_v(TX,TY+1,MX,MY,MX,MY).
%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX > MX,TY < MY, not mino_h(TX,TY,MX,MY,MX+1,MY), not mino_h(TX,TY,MX+1,MY,MX,MY), not mino_v(TX,TY,MX,MY,MX,MY-1), not mino_v(TX,TY-1,MX,MY,MX,MY).
%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX < MX,TY > MY, not mino_h(TX,TY,MX,MY,MX-1,MY), not mino_h(TX,TY,MX-1,MY,MX,MY), not mino_v(TX,TY,MX,MY,MX,MY+1), not mino_v(TX,TY+1,MX,MY,MX,MY).
%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX < MX,TY < MY, not mino_h(TX,TY,MX,MY,MX-1,MY), not mino_h(TX,TY,MX-1,MY,MX,MY), not mino_v(TX,TY,MX,MY,MX,MY-1), not mino_v(TX,TY-1,MX,MY,MX,MY).

% No movement if on the same Y but different X with walls next to M.
%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TY == MY, TX > MX, not mino_h(TX,TY,MX,MY,MX+1,MY).
%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TY == MY, TX < MX, not mino_h(TX,TY,MX,MY,MX-1,MY).
 
% No movement if on the same X but different Y with walls next to M.
%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX == MX, TY > MY, not mino_v(TX,TY,MX,MY,MX,MY+1) .
%mino_n(TX,TY,MX,MY,MX,MY) :- field(TX,TY), field(MX,MY), TX == MX, TY < MY, not mino_v(TX,TY,MX,MY,MX,MY-1) .

% Collect all possible moves.
%mino_move(TX,TY,MX,MY,MX',MY') :- 1{mino_h(TX,TY,MX,MY,MX',MY'); mino_v(TX,TY,MX,MY,MX',MY'); mino_n(TX,TY,MX,MY,MX',MY')}1, field(MX',MY'), field(MX,MY), field(TX,TY).
mino_move(TX,TY,MX,MY,MX',MY') :- mino_h(TX,TY,MX,MY,MX',MY').
mino_move(TX,TY,MX,MY,MX',MY') :- mino_v(TX,TY,MX,MY,MX',MY').
mino_move(TX,TY,MX,MY,MX',MY') :- mino_n(TX,TY,MX,MY,MX',MY').
% Theseus moves in any direction as long as there is no wall, he's not on the goal but on the field. he moves once per round
thes_move(TX,TY,TX+I,TY+J) :- field(TX,TY), dir(I,J), field(TX+I,TY+J), not wall(TX,TY,TX+I,TY+J), not wall(TX+I,TY+J,TX,TY), not goal(TX,TY).
1{ at(TX',TY',M) : thes_move(TX,TY,TX',TY')}1 :- at(TX,TY,M-1), M<=N, maxsteps(N), not goal(TX,TY).

% Given Ts position, mino will attempt two moves.
at_m(MX',MY',M) :- at_m(MX,MY,M-1), at(TX,TY,M), mino_move(TX,TY,MX,MY,MXX,MYY), mino_move(TX,TY,MXX,MYY,MX',MY').

% if only one cell away, he will attempt that move, if not possible he makes two moves in the same field. 
at_m(TX,TY,M) :- at_m(MX,TY,M-1), at(TX,TY,M), |TX - MX| == 1, not wall(MX,TY,TX,TY).
at_m(TX,TY,M) :- at_m(TX,MY,M-1), at(TX,TY,M), |TY - MY| == 1, not wall(TX,MY,TX,TY).

%at_m(TX,TY,M) :- at_m(MX,TY,M-1), at(TX,TY,M), TX - MX == 1, not wall(MX,TY,TX,TY), not wall(TX,TY,MX,TY).
%at_m(TX,TY,M) :- at_m(MX,TY,M-1), at(TX,TY,M), TX - MX == -1, not wall(MX,TY,TX,TY), not wall(TX,TY,MX,TY).
%at_m(TX,TY,M) :- at_m(TX,MY,M-1), at(TX,TY,M), TY - MY == 1, not wall(TX,MY,TX,TY), not wall(TX,TY,TX,MY).
%at_m(TX,TY,M) :- at_m(TX,MY,M-1), at(TX,TY,M), TY - MY == -1, not wall(TX,MY,TX,TY), not wall(TX,TY,TX,MY).


% Test
% Check solution candidates here!
:- not at(MX,MY,_), goal(MX,MY).
:- at(TX,TY,M), at_m(TX,TY,M-1).
:- at(MX,MY,M), at_m(MX,MY,M).

% Optimize solutions here!
#minimize { M : at(X,Y,M) }.

% Display
#show at/3.
%#show at_m/3.

