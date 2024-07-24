:- use_module(library(clpfd)).

% SimplePicrossSolver +RowHints, +ColHints, -Solution
% RowHints: list of integers
% ColHints: list of integers
% Solution: list of 0s and 1
% this only accepts square grids! and the clues cannot be lists (no spaced out clues)


% this is early days into my logic programming, but i can explain this
% this is similar to the well known sudoku solver, basically, we are using apply_clues to check the sum of every row and column (constrained to be 1s and 0s) and
% prolog will repeatedly backtrack and try different combinations of 1s and 0s until it finds a solution that satisfies all the constraints
% i.e, say we try a combo in rowHints that looks good but then when we look at the column hints, it doesn't work, prolog will backtrack and try a different combo
% key to understanding this is that transpose/2 doesn't create a new list, it just creates a view of the list, so when we apply the constraints to the transposed solution it applies to the original solution as well

simplePicrossSolver(RowHints, ColHints, Solution) :-
    length(RowHints, N),
    length(ColHints, N),
    length(Solution, N),
    maplist(length_list(N), Solution), % we need to do this to instantiate Solution properly. we need N lists of length N in solution
    maplist(domain_constraint, Solution), % everything in Solution can only be 1s or 0s
    transpose(Solution, TransposedSolution), % get a different view of the sol to apply the constraints to the columns
    maplist(apply_clues, RowHints, Solution), % sum of each row must match the rowHints
    maplist(apply_clues, ColHints, TransposedSolution), % sum of each column must match the colHints
    maplist(label, Solution). % attempt to label the solution with the constraints, probably fail, in which case we backtrack and try a different combo

length_list(Length, List) :-
    length(List, Length).

domain_constraint(List) :-
    List ins 0..1.

apply_clues(Clue, List) :-
    % this one is funky. 
    % sum sums the element of the list, and #= checks if sum is what we want, equal to clue
    sum(List, #=, Clue).


% you read this far, so here's some picross games I reccomend:
% 1) Picross 3d round 2 - this is the best picross game of all time. play picross 3d as well
% 2) pictopix
% 3) uhhh. tbd when i update this code. 
