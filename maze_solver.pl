% CS4337 Project 2 - Maze Solver
% By Arsalan Shaik
% Description: Solves mazes represented as 2D lists


% find_exit(+Maze, -Actions)
% Main predicate: finds a path from start to exit
find_exit(Maze, Actions) :-
    valid_maze(Maze),
    find_start(Maze, StartRow, StartCol),
    dfs(Maze, StartRow, StartCol, [], [], Actions).

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




% count_cell_type(+Maze, +CellType, -Count)
% Counts occurrences of a specific cell type
count_cell_type(Maze, CellType, Count) :-
    count_cell_type_rows(Maze, CellType, 0, Count).

count_cell_type_rows([], _, Count, Count).
count_cell_type_rows([Row|Rest], CellType, Acc, Count) :-
    count_cell_type_row(Row, CellType, 0, RowCount),
    Acc1 is Acc + RowCount,
    count_cell_type_rows(Rest, CellType, Acc1, Count).

count_cell_type_row([], _, Count, Count).
count_cell_type_row([Cell|Rest], CellType, Acc, Count) :-
    (Cell = CellType -> Acc1 is Acc + 1 ; Acc1 = Acc),
    count_cell_type_row(Rest, CellType, Acc1, Count).

% find_start(+Maze, -Row, -Col)
% Finds the coordinates of the start position
find_start(Maze, Row, Col) :-
    find_start_rows(Maze, 0, Row, Col).

find_start_rows([Row|_], RowIdx, RowIdx, Col) :-
    find_start_col(Row, 0, Col), !.
find_start_rows([_|Rest], RowIdx, Row, Col) :-
    RowIdx1 is RowIdx + 1,
    find_start_rows(Rest, RowIdx1, Row, Col).

find_start_col([s|_], ColIdx, ColIdx) :- !.
find_start_col([_|Rest], ColIdx, Col) :-
    ColIdx1 is ColIdx + 1,
    find_start_col(Rest, ColIdx1, Col).

% valid_maze(+Maze)
% Complete maze validation
valid_maze(Maze) :-
    Maze \= [],
    all_rows_same_length(Maze),
    all_cells_valid(Maze),
    count_cell_type(Maze, s, 1),
    count_cell_type(Maze, e, ExitCount),
    ExitCount > 0.



% move(+Action, +Row, +Col, -NewRow, -NewCol)
% Computes new position after performing an action
move(left, Row, Col, Row, NewCol) :-
    NewCol is Col - 1.

move(right, Row, Col, Row, NewCol) :-
    NewCol is Col + 1.

move(up, Row, Col, NewRow, Col) :-
    NewRow is Row - 1.

move(down, Row, Col, NewRow, Col) :-
    NewRow is Row + 1.

% can_move(+Maze, +Row, +Col, +Action)
% Checks if a move is valid (stays in bounds and not a wall)
can_move(Maze, Row, Col, Action) :-
    move(Action, Row, Col, NewRow, NewCol),
    valid_position(Maze, NewRow, NewCol),
    get_cell(Maze, NewRow, NewCol, Cell),
    Cell \= w.





% follow_path(+Maze, +Row, +Col, +Actions, -FinalRow, -FinalCol)
% Follows a path of actions from a starting position
follow_path(_, Row, Col, [], Row, Col).
follow_path(Maze, Row, Col, [Action|Rest], FinalRow, FinalCol) :-
    can_move(Maze, Row, Col, Action),
    move(Action, Row, Col, NewRow, NewCol),
    follow_path(Maze, NewRow, NewCol, Rest, FinalRow, FinalCol).

% is_exit(+Maze, +Row, +Col)
% Checks if a position is an exit
is_exit(Maze, Row, Col) :-
    get_cell(Maze, Row, Col, e).

% valid_solution(+Maze, +Actions)
% Checks if the actions lead from start to exit
valid_solution(Maze, Actions) :-
    valid_maze(Maze),
    find_start(Maze, StartRow, StartCol),
    follow_path(Maze, StartRow, StartCol, Actions, FinalRow, FinalCol),
    is_exit(Maze, FinalRow, FinalCol).




% dfs(+Maze, +CurrentRow, +CurrentCol, +Visited, +PathSoFar, -FinalPath)
% Depth-first search to find path to exit
dfs(Maze, Row, Col, _, Path, Path) :-
    is_exit(Maze, Row, Col), !.

dfs(Maze, Row, Col, Visited, PathSoFar, FinalPath) :-
    \+ member((Row, Col), Visited),
    member(Action, [up, down, left, right]),
    can_move(Maze, Row, Col, Action),
    move(Action, Row, Col, NewRow, NewCol),
    \+ member((NewRow, NewCol), Visited),
    append(PathSoFar, [Action], NewPath),
    dfs(Maze, NewRow, NewCol, [(Row, Col)|Visited], NewPath, FinalPath).




