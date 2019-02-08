% An ASP-soution for the mobile game RULLO. Available in Android App store. A matrix of positive integers is given. The row and column sums have to add up to a specific value that 
% is given as well. Integers can be selected or deselected to achieve the given sums. Test cases were hand coded from different problem instances within the app. 


0{select(X,Y,N)}1 :- num(X,Y,N). % Possibly select number
unselect(X,Y,N) :- not select(X,Y,N), num(X,Y,N). % all other numbers are unselected. not necessary. (but in game, first all are selected, so unselected is the set of numbers user can tip off 

sumrow(X,S) :- S = #sum{N,Y : select(X,Y,N)},select(X,_,_). % Calculate sum in each row
sumcol(Y,S) :- S = #sum{N,X : select(X,Y,N)},select(_,Y,_). % calculate sum in each col.

:- {select(_,_,_)}0.  % Disallow empty answer sets.
:- goalrow(R,V), sumrow(R,S), S!=V. % goalrow has to be the same as sum per row in selection
:- goalcol(C,V), sumcol(C,S), S!=V. % goalcol has to be the same as sum per col in selection

#show unselect/3.
%#show select/3.
%#show sumrow/2.
%#show sumcol/2.
