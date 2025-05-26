require_relative 'tsp_solver'

# fungsi untuk calculate jalur dengan dynamic programming
module TspCalculate
    # n = jumlah kota
    # distance_matrix = jarak
    # output: rute dan total jarak terbaik
  def self.solve(n, distance_matrix)
    solver = TspSolver.new(n, distance_matrix)
    solver.solve
  end

    # jumlahkan jarak
  def self.calculate_path_cost(distance_matrix, path)
    return 0 if path.length < 2
    
    total_cost = 0
    (0...path.length-1).each do |i|
      from = path[i]
      to = path[i+1]
      total_cost += distance_matrix[from][to]
    end
    total_cost
  end

    # validasi rute (dimulai dan diakhiri 0)
  def self.validate_path(path, n)
    errors = []
    
    unless path.first == 0 && path.last == 0
      errors << "Path should start and end at city 0!"
    end
    
    # Check if all cities are visited exactly once (kecuali start/end)
    visited_cities = path[0...-1]
    unique_cities = visited_cities.uniq
    
    if unique_cities.length != n
      errors << "Not all cities are visited exactly once!"
    end
    
    # Cek apakah balik ke kota awal
    if path.length != n + 1
      errors << "Path length should be #{n + 1} (including return)"
    end
    
    errors
  end

  # Hasilin semua rute TSP yang mungkin
  def self.generate_all_possible_paths(n)
    cities = (1...n).to_a # excluding city 0
    all_paths = []
    
    # Generate seluruh permutasi (excluding city 0)
    cities.permutation.each do |perm|
      path = [0] + perm + [0] # Add start and end city 0
      all_paths << path
    end
    
    all_paths
  end

    # Solusi optimal --> brute force
  def self.find_optimal_solutions(distance_matrix)
    n = distance_matrix.length
    all_paths = generate_all_possible_paths(n)
    
    solutions = all_paths.map do |path|
      cost = calculate_path_cost(distance_matrix, path)
      { path: path, cost: cost }
    end
    
    min_cost = solutions.map { |s| s[:cost] }.min
    optimal_solutions = solutions.select { |s| s[:cost] == min_cost }
    
    {
      all_solutions: solutions,
      optimal_solutions: optimal_solutions,
      min_cost: min_cost
    }
  end
end