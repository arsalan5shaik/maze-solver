# Maze Solver - CS4337 Project 2

##
By Arsalan Shaik

## Description
A Prolog program that solves mazes represented as 2D lists using depth-first search also with backtracking.

## Files
- `maze_solver.pl` - the main implementation with find_exit/2 predicate
- `example.pl` - Test mazes provided by instructor
- `test.pl` - Random maze generator provided by instructor
- `devlog.md` - Development log documenting implementation process
- `README.md` - This file

## How to Compile and Run

### On Command Line:
```bash
# Start SWI-Prolog with the files
swipl maze_solver.pl example.pl

### Test Commands:
```prolog
% Find a solution
?- basic_map(M), find_exit(M, Actions).

% Verify a solution
?- basic_map(M), find_exit(M, [down, left, down]).

% Display maze while solving
?- basic_map(M), display_map(M), find_exit(M, A).

% Test with random maze
?- [test], gen_map(4, 10, 10, M), find_exit(M, A).
```

## Implementation Details

### Main Predicate
`find_exit(+Maze, ?Actions)` - Finds or verifies a path from start to exit

### Algorithm
- Uses depth-first search with backtracking
- Maintains visited set to prevent cycles
- Validates maze structure before solving
- Works in both generation mode (Actions unbound) and verification mode (Actions bound)

### Key Predicates
- `valid_maze/1` - Validates maze structure and contents
- `find_start/3` - Locates the start position
- `dfs/6` - Depth-first search implementation
- `can_move/4` - Validates movement actions
- `follow_path/6` - Follows a sequence of actions

## Maze Format
- `f` - floor (empty space)
- `w` - wall (impassable)
- `s` - start (exactly one required)
- `e` - exit (at least one required)

## Actions
- `left` - move to previous column
- `right` - move to next column  
- `up` - move to previous row
- `down` - move to next row

## Testing
All provided test cases pass:
- Simple mazes solve correctly
- Path verification works for valid and invalid paths
- Handles invalid mazes appropriately
- Works with randomly generated mazes
