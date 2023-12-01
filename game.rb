# frozen_string_literal: true

# Game logic
class Game
  attr_accessor :board, :current_move

  BOARD_WIDTH = 7
  BOARD_HEIGHT = 6
  COMBINATION_COUNT = 4

  def initialize
    @current_move = 0
    @board = Array.new(BOARD_HEIGHT) { Array.new(BOARD_WIDTH) { nil } }
    @status = :playing
  end

  def current_player
    @current_move % 2
  end

  def valid_move?(column)
    return false if column < 1
    return false if column > BOARD_WIDTH - 1
    return false unless @board[BOARD_HEIGHT - 1][column].nil?

    true
  end

  def make_move(column)
    move_in_memory = column - 1
    return nil unless valid_move? move_in_memory

    row = 0
    row += 1 unless @board[row][column].nil?

    @board[row][column] = current_player

    [row, column]
  end

  def winning_move?(row, column)
    directions = %w[row column diagonal reverse_diagonal]

    directions.any? { |direction| check_direction(row, column, direction) }
  end

  def check_direction(row, column, direction)
    match = 1

    before = case direction
             when 'row' then column
             when 'column' then row
             when 'diagonal' then [column, BOARD_HEIGHT - (row + 1)].min
             when 'reverse_diagonal' then [BOARD_WIDTH - column, BOARD_HEIGHT - (row + 1)].min
             end
    before = [before, COMBINATION_COUNT - match].min

    before.times do |i|
      iteration = i + 1
      y, x = case direction
             when 'row' then [row, column - iteration]
             when 'column' then [row - iteration, column]
             when 'diagonal' then [row + iteration, column - iteration]
             when 'reverse_diagonal' then [row + iteration, column + iteration]
             end
      break unless @board[y][x] == current_player

      match += 1

      return true if match == COMBINATION_COUNT
    end

    after = case direction
            when 'row' then BOARD_WIDTH - column
            when 'column' then BOARD_HEIGHT - (row + 1)
            when 'diagonal' then [row, BOARD_WIDTH - column].min
            when 'reverse_diagonal' then [row, column].min
            end

    after = [after, COMBINATION_COUNT - match].min

    after.times do |i|
      iteration = i + 1
      y, x = case direction
             when 'row' then [row, column + iteration]
             when 'column' then [row + iteration, column]
             when 'diagonal' then [row - iteration, column + iteration]
             when 'reverse_diagonal' then [row - iteration, column - iteration]
             end

      break unless @board[y][x] == current_player

      match += 1

      return true if match == COMBINATION_COUNT
    end

    false
  end
end
