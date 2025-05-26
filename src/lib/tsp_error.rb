class TspError < StandardError
  attr_reader :type, :details

  def initialize(type, details = {})
    @type = type
    @details = details
    super(message)
  end

  private

  def message
    case @type
    when :invalid_city_count
      "Invalid city count: #{@details[:count]}. Must be at least 2."
    when :invalid_matrix_size
      "Invalid matrix size: expected #{@details[:expected]}, got #{@details[:actual]}"
    when :negative_distance
      "Negative distance #{@details[:distance]} at position (#{@details[:row]}, #{@details[:col]})"
    when :non_square_matrix
      "Matrix must be square (same number of rows and columns)"
    when :invalid_input
      "Invalid input: #{@details[:message]}"
    else
      "Unknown TSP error"
    end
  end
end