% CS4337 Project 2 - Maze Solver
% By Arsalan Shaik
% Description: Solves mazes represented as 2D lists

% Main predicate - to be implemented
% find_exit(+Maze, -Actions)
find_exit(Maze, Actions) :-
    write('Not yet implemented'), fail.

% Utility predicates for list access
% nth0_element(+List, +Index, -Element)
% Gets the element at Index from List (0-indexed)
nth0_element([H|_], 0, H) :- !.
nth0_element([_|T], N, Element) :-
    N > 0,
    N1 is N - 1,
    nth0_element(T, N1, Element).