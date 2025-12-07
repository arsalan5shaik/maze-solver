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





% get_cell(+Maze, +Row, +Col, -Cell)
% Gets the cell value at position (Row, Col)
get_cell(Maze, Row, Col, Cell) :-
    nth0_element(Maze, Row, RowList),
    nth0_element(RowList, Col, Cell).

% maze_dimensions(+Maze, -Rows, -Cols)
% Gets the dimensions of the maze
maze_dimensions(Maze, Rows, Cols) :-
    length(Maze, Rows),
    Rows > 0,
    Maze = [FirstRow|_],
    length(FirstRow, Cols),
    Cols > 0.

% valid_position(+Maze, +Row, +Col)
% Checks if a position is within maze bounds
valid_position(Maze, Row, Col) :-
    maze_dimensions(Maze, Rows, Cols),
    Row >= 0,
    Row < Rows,
    Col >= 0,
    Col < Cols.