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



% all_rows_same_length(+Maze)
% Ensures all rows have the same length
all_rows_same_length([]).
all_rows_same_length([_]).
all_rows_same_length([Row1, Row2|Rest]) :-
    length(Row1, Len),
    length(Row2, Len),
    all_rows_same_length([Row2|Rest]).

% valid_cell(+Cell)
% Checks if a cell contains a valid value
valid_cell(f).
valid_cell(w).
valid_cell(s).
valid_cell(e).

% all_cells_valid(+Maze)
% Ensures all cells in the maze are valid
all_cells_valid([]).
all_cells_valid([Row|Rest]) :-
    all_cells_valid_row(Row),
    all_cells_valid(Rest).

all_cells_valid_row([]).
all_cells_valid_row([Cell|Rest]) :-
    valid_cell(Cell),
    all_cells_valid_row(Rest).