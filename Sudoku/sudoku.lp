% An ASP-soution for sudoku. Instances were taken from: https://sudoku.tagesspiegel.de/ with difficulties normal, hard or very hard. ex07 and ex08 are very hard with additional numbers left out resulting in multiple answer sets.
%
% HINTS:
% - For subgrid_size(s), subgrids can be identified by labels 0..s*s-1, 0 through 8 
% - A cell (x,y) can be mapped to the subgrid labeled ( ( (x-1) /s )*s + (y-1)/s) 
%

subgrid_size(3).
% Your implementation please...
% Define digits (1 through 9),
dig(1..9).

% A cell is given by two indices, coincidentally also 1 through 9, so we can reuse dig().
cell(X,Y):- dig(X),dig(Y).
sudoku(X,Y,N) :- initial(X,Y,N).
% Rules for setting digits in cells:
cell_grid(X,Y,  ( ( (X-1) /M )*M + (Y-1)/M) ) :- cell(X,Y), subgrid_size(M). 
% First: Each cell can only have one number: short form is conditional literal from graph coloring, see book page 22. 
1 {sudoku(X , Y, N) : dig(N)} 1  :- cell_grid(X,Y,S).

% Keep track of the grid a digit is in.
dig_grid(N,S) :- sudoku(X,Y,N), cell_grid(X,Y,S).

% Integrity constraints. 
:- not dig_grid(N,S), cell_grid(X,Y,S), sudoku(_,_,N). % Not possible to have more than one pair of same number and subgrid for subgrids and sudoku placements. X and Y have to b
% rows and columns: just like queen example from modeling pdf sl. 92 ff. or book page 43 ff.
% Two cells in the same row can not have the same number, i.e. if both cells have the same number, the last term has to be false, if all are true -> integrity constraint forbids solution
:- sudoku(X,Y,N), sudoku(X',Y,N), X!=X'.

% Two cells in the same column can not have the same number.
:- sudoku(X,Y,N), sudoku(X,Y',N), Y!=Y'.

#show sudoku/3.

