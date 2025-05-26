require_relative 'tsp_calculate'

class TspVerifier
  def self.verify_solution(distance_matrix, solution_path, verbose: true)
    if verbose
      puts "TSP Solution Verification"
      puts "=" * 40
      
      n = distance_matrix.length
      puts "Number of cities: #{n}"
      
      # Distance Matriks
      puts "\nDistance Matrix:"
      print_matrix(distance_matrix)
      
      puts "\nProposed Solution Path: #{solution_path.join(' → ')}"
    end
    
    # Validasi
    n = distance_matrix.length
    path_errors = TspCalculate.validate_path(solution_path, n)
    
    if verbose && !path_errors.empty?
      puts "\nPath validation errors:"
      path_errors.each { |error| puts " #{error}" }
    end
    
    solution_cost = TspCalculate.calculate_path_cost(distance_matrix, solution_path)
    
    if verbose
      puts "\nDetailed Cost Calculation:"
      calculate_path_cost_verbose(distance_matrix, solution_path)
    end
    
    # Find optimal solutions
    analysis = TspCalculate.find_optimal_solutions(distance_matrix)
    
    if verbose
      puts "\nAll Possible Paths:"
      analysis[:all_solutions].each do |solution|
        puts "  Path #{solution[:path].join(' → ')}: Cost = #{solution[:cost]}"
      end
      
      puts "\nVerification Results:"
      puts "-" * 20
      puts "Proposed solution cost: #{solution_cost}"
      puts "Actual minimum cost: #{analysis[:min_cost]}"
      puts "Number of optimal paths: #{analysis[:optimal_solutions].length}"
      
      if solution_cost == analysis[:min_cost]
        puts "CORRECT! The proposed solution is optimal."
      else
        puts "INCORRECT! The proposed solution is not optimal."
        puts "Difference: #{solution_cost - analysis[:min_cost]} (higher than optimal)"
      end
    end
    
    {
      is_optimal: solution_cost == analysis[:min_cost],
      solution_cost: solution_cost,
      min_cost: analysis[:min_cost],
      path_errors: path_errors,
      all_solutions: analysis[:all_solutions]
    }
  end
  
  def self.manual_calculation_step_by_step(distance_matrix, path)
    puts "Manual Step-by-Step Calculation"
    puts "=" * 35
    
    puts "Distance Matrix:"
    print_matrix(distance_matrix)
    
    puts "\nStep-by-Step Calculation:"
    puts "Path: #{path.join(' → ')}"
    puts
    
    total = 0
    (0...path.length-1).each do |i|
      from = path[i]
      to = path[i+1]
      distance = distance_matrix[from][to]
      total += distance
      puts "Step #{i+1}: City #{from} → City #{to}"
      puts "  Distance = matrix[#{from}][#{to}] = #{distance}"
      puts "  Running total = #{total}"
      puts
    end
    
    puts "Final Total Cost: #{total}"
    total
  end
  
  private
  
  def self.print_matrix(matrix)
    n = matrix.length
    
    # Print header
    print "     "
    (0...n).each { |i| print "%4d" % i }
    puts
    
    # Print rows
    matrix.each_with_index do |row, i|
      print "#{i} [ "
      row.each { |val| print "%3d " % val }
      puts "]"
    end
  end
  
  def self.calculate_path_cost_verbose(matrix, path)
    total_cost = 0
    
    (0...path.length-1).each do |i|
      from = path[i]
      to = path[i+1]
      cost = matrix[from][to]
      total_cost += cost
      puts "  #{from} → #{to}: #{cost}"
    end
    puts "  Total: #{total_cost}"
    
    total_cost
  end
end