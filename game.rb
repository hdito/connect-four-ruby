# frozen_string_literal: true

# Game logic
class Game
  attr_accessor :board, :current_move, :status

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

  def valid_move?(move)
    return false unless move.to_i.to_s == move

    move_in_memory = move.to_i - 1

    return false if move_in_memory.negative?
    return false if move_in_memory > BOARD_WIDTH - 1
    return false unless @board[BOARD_HEIGHT - 1][move_in_memory].nil?

    true
  end

  def take_move
    column = nil
    while column.nil?
      move = gets.chomp
      unless valid_move? move
        puts 'Move must be a digit from 1 to 7'
        next
      end
      column = move.to_i - 1
    end
    column
  end

  def make_move
    column = take_move
    row = row_in_column column
    @board[row][column] = current_player

    @status = current_player.to_s.to_sym if winning_move?(row, column)

    @current_move += 1

    @status = :draw if draw_move?
  end

  def header
    case status
    when :playing then "Player #{current_player + 1}'s move"
    when :'0' then 'Player 1 win'
    when :'1' then 'Player 2 win'
    when :draw then 'Draw'
    end
  end

  def string_board
    @board.reverse.reduce('') do |total, row|
      total + (row.reduce('') do |total_row, cell|
        case cell
        when nil then "#{total_row}⚪"
        when 0 then "#{total_row}🔴"
        when 1 then "#{total_row}🟡"
        end
      end) + "\n"
    end
  end

  def row_in_column(column)
    row = 0
    row += 1 until @board[row][column].nil?
    row
  end

  def draw_move?
    @current_move == BOARD_WIDTH * BOARD_HEIGHT
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

  def print_screen
    puts `clear`
    puts header
    puts string_board
  end

  def start
    while @status == :playing
      print_screen
      make_move
    end
    print_screen
  end
end
