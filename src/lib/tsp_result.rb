class TspResult
    # nampilin resultnya
  attr_reader :min_cost, :optimal_path

  def initialize(min_cost, optimal_path)
    @min_cost = min_cost
    @optimal_path = optimal_path
  end

  def to_s
    path_str = @optimal_path.join(' -> ')
    "Minimum cost: #{@min_cost}\nOptimal path: #{path_str}"
  end

  def ==(other)
    other.is_a?(TspResult) && 
    @min_cost == other.min_cost && 
    @optimal_path == other.optimal_path
  end
end