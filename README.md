<h1 align="center">Tugas Tantangan IF2211 Strategi Algoritma</h1>
<h2 align="center">Semester II Tahun 2024/2025</h2>
<h2 align="center">Traveling Salesman Problem Solution 
use Dynamic Programming</h2>

## Table of Contents
- [Description](#description)
- [Program Structure](#program-structure)
- [Requirements & Installation](#requirements--installation)
- [Algorithm](#algorithm)
- [How to Use](#how-to-use)
- [Test Case](#test-case)
- [Author](#author)

## Description
This project provides a comprehensive solution to the Traveling Salesman Problem (TSP) using dynamic programming with bitmasking. The TSP is a classic optimization problem where a salesman must visit all cities exactly once and return to the starting city, minimizing the total travel distance.
The program features:

1. Dynamic Programming with Bitmasking for optimal solution finding
2. Comprehensive Input Validation with custom error handling
3. Solution Verification tools to validate TSP solutions
4. Interactive Command-Line Interface with predefined examples
5. Performance Testing capabilities
6. Step-by-Step Manual Calculation for educational purposes

## Program Structure
```
├── README.md
├── src/
│   ├── main.rb                    # Main program entry point
│   ├── lib/
│   │   ├── tsp_calculate.rb       # Core TSP calculation module
│   │   ├── tsp_solver.rb          # Dynamic programming TSP solver
│   │   ├── tsp_result.rb          # Result data structure
│   │   ├── tsp_error.rb           # Custom error handling
│   │   ├── tsp_input_handler.rb   # User input management
│   │   └── tsp_verifier.rb        # Solution verification tools
│   └── test/
│        └── test_tsp_solver.rb    # Comprehensive test suite
```
## Requirements & Installation
*Prerequisites*
1. Ruby 3.0+
2. No external dependencies required (uses only Ruby standard library)

Before running the program, follow these steps:
1. Clone this repository
    ```bash
    git clone https://github.com/mineraleee/TugasTantanganStima_13523107
    ```
2. Run the program
   ```bash
    cd src
    ruby main.rb
    ```

## Algorithm
The solver implements the Held-Karp algorithm, which uses dynamic programming with bitmasking to solve the TSP optimally. This approach significantly reduces the time complexity compared to brute force from O(n!) to O(n² × 2ⁿ).

The algorithm breaks down the TSP into subproblems by considering:

Current position: Which city we're currently at
Visited cities: Which cities have been visited so far (represented as a bitmask)

Bitmask Examples:
For 4 cities (0,1,2,3):
- mask = 1 (binary: 0001) → only city 0 visited
- mask = 5 (binary: 0101) → cities 0 and 2 visited
- mask = 15 (binary: 1111) → all cities visited

Each subproblem dp(pos, mask) represents the minimum cost to start at city pos having already visited the cities indicated by mask. The algorithm tries all possible next cities that haven’t been visited yet and picks the path with the lowest total cost.

Memoization (@memo) stores the results of subproblems so they don’t have to be recomputed, greatly improving efficiency.

Once all calculations are done, the optimal path is reconstructed by following the best next city choices stored in the memo.

## How to Use
Run the main program to access the interactive menu:
1. Solve TSP (manual input) - Enter your own distance matrix
2. Solve TSP (predefined examples) - Use built-in test cases
3. Verify a solution - Check if a proposed path is optimal
4. Manual calculation demo - Step-by-step calculation walkthrough
5. Run tests - Execute the comprehensive test suite
6. Performance test - Benchmark solver performance
7. Exit

## Test Case
*Test Case 1*
```
Distance Matrix:
     0   1   2
 0 [ 0  29  20]
 1 [29   0  15]
 2 [20  15   0]

Solving TSP...

Result:
Minimum cost: 64
Optimal path: 0 -> 1 -> 2 -> 0
```
*Test Case 2*
```
 Distance Matrix:
     0   1   2   3
 0 [ 0  10  15  20]
 1 [10   0  35  25]
 2 [15  35   0  30]
 3 [20  25  30   0]


Solving TSP...

Result:
Minimum cost: 80
Optimal path: 0 -> 1 -> 3 -> 2 -> 0
```
Assumption: The graph is complete, meaning there is a direct path between every pair of cities.

## Author
| **NIM**  | **Nama**               | **Github** |
| -------- | ------------------------------ | ---------- |
| 13523107 | Heleni Gratia M Tampubolon     | [mineraleee](https://github.com/mineraleee) | 
