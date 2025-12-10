# Development Log

## 2025-12-07 3:36pm

### Initial Thoughts
I am starting the Prolog maze solver project now. The goal is to create a find_exit/2 predicate that:
- Takes a maze (list of lists with cells: f, w, s, e)
- Returns a list of actions (left, right, up, down) to get from start to exit
- Must validate the maze and actions

My plan is to break this into multiple manageable pieces:
1. Start with basic helper predicates for list manipulation
2. Build maze validation
3. Implement position tracking
4. Create movement logic
5. Finally implement the pathfinding algorithm

I'll use depth-first search with backtracking, which fits naturally with Prolog's execution model.

### Plan for This Session
- Set up the project structure
- Create the main file with basic structure
- Implement utility predicates for accessing list elements (nth element functions)




## 2025-12-07 4:12

### Plan for This Session
Implement predicates to:
- Get a cell at specific row/column coordinates
- Calculate the maze dimensions
- This will be foundation for validation and pathfinding


## 2025-12-07 4:45

### Plan for This Session
Build the maze validation to ensure:
- All rows have the same length (rectangular maze)
- All cells contain valid values (f, w, s, or e)



## 2025-12-08 1:28AM

### Plan for This Session
Add validation for:
- Exactly one start position (s)
- At least one exit position (e)
- Find and return the start position coordinates



## 2025-12-07 3:32AM

### Plan for This Session
Implement  four movement actions:
- left: decrease column
- right: increase column
- up: decrease row
- down: increase row
Each one should compute new position from current position


## 2025-12-08 12:01PM

### Plan for This Session
Create predicate to validate that a given list of actions:
- Successfully navigates from start to a cell
- Doesn't go out of bounds or hit walls
This will be useful for the main predicate and testing


## 2025-12-08 1:41pm

### Plan for This Session
Begin implementing the pathfinding algorithm using depth-first search with backtracking.
Start with basic DFS structure that tracks visited positions.





## 2025-12-08 2:18pm

### Plan for This Session
Connect all pieces together in the main find_exit/2 predicate.
This should validate the maze, find the start, and run DFS.






## 2025-12-09 10:32pm

### Plan for This Session
Test the implementation with the provided example mazes.
Fix any bugs discovered during testing.

### Testing Notes
Testing with simple_map([[s,f,e]]) - output: [right, right]
Testing with basic_map - checking various paths
```


```
Test Results:

1. simple_map([[s,f,e]]):
   Query: simple_map(M), find_exit(M, A).
   [right, right]

2. basic_map (from example.pl):

3. Generated maze test:
   gen_map(4, 10, 10, M), find_exit(M, A).





## 2025-12-10 8:24am - End of Session

### Session Reflection
I have successfully completed all phases of the maze solver implementation!

### What I Accomplished:
- Implemented all helper predicates (nth0_element, get_cell, maze_dimensions)
- Created complete maze validation (structure, cells, start/exit checking)
- Built movement predicates for all four directions
- Implemented depth-first search algorithm with backtracking
- Completed find_exit/2 predicate that both generates and verifies solutions

### Testing Results:
All the test cases pass correctly:

1. basic_map with path generation:
   - Query: `basic_map(M), find_exit(M, A)`
   - Result: `A = [down, left, down]`

2. Path verification (valid path):
   - Query: `basic_map(M), find_exit(M, [down,left,down])`
   - Result: `true`

3. Path verification (invalid path):
   - Query: `basic_map(M), find_exit(M, [down,left])`
   - Result: `false`

### Additional Testing:
```prolog
?- simple_map(M), find_exit(M, A).
% Result: A = [right, right]

?- basic_map2(M), find_exit(M, A).
```

### Challenges Encountered:
- Initially had to ensure proper recursion with visited tracking
- DFS implementation required careful handling of backtracking
- Made sure the predicate works in both generation and verification modes

### What Works Well:
- The depth-first search naturally leverages Prolog's backtracking
- Visited set prevents infinite loops
- Clean separation between validation and pathfinding logic

### Next Steps:
- Test with some randomly generated mazes
- Verify it works on a cs1/cs2 machine
- Create the README and prepare for submission