# frozen_string_literal: true

require_relative '../game'

describe Game do
  describe '#check_direction' do
    before :example do
      @game = Game.new
    end
    it 'Calculates a row match' do
      @game.board[0][0] = 0
      @game.board[0][1] = 0
      @game.board[0][2] = 0
      @game.board[0][3] = 0

      expect(@game.check_direction(0, 3, 'row')).to eq(true)
      expect(@game.check_direction(0, 2, 'row')).to eq(true)
      expect(@game.check_direction(0, 1, 'row')).to eq(true)
      expect(@game.check_direction(0, 0, 'row')).to eq(true)

      expect(@game.check_direction(1, 3, 'row')).to eq(false)
      expect(@game.check_direction(1, 2, 'row')).to eq(false)
      expect(@game.check_direction(1, 1, 'row')).to eq(false)
      expect(@game.check_direction(1, 0, 'row')).to eq(false)
    end

    it 'Calculates a row match in top left corner' do
      @game.board[5][0] = 0
      @game.board[5][1] = 0
      @game.board[5][2] = 0
      @game.board[5][3] = 0

      expect(@game.check_direction(5, 0, 'row')).to eq(true)
      expect(@game.check_direction(5, 1, 'row')).to eq(true)
      expect(@game.check_direction(5, 2, 'row')).to eq(true)
      expect(@game.check_direction(5, 3, 'row')).to eq(true)
    end

    it 'Calculates a column match' do
      @game.board[0][0] = 0
      @game.board[1][0] = 0
      @game.board[2][0] = 0
      @game.board[3][0] = 0

      expect(@game.check_direction(0, 0, 'column')).to eq(true)
      expect(@game.check_direction(1, 0, 'column')).to eq(true)
      expect(@game.check_direction(2, 0, 'column')).to eq(true)
      expect(@game.check_direction(3, 0, 'column')).to eq(true)
    end

    it 'Calculates a column match in top left corner' do
      @game.board[5][0] = 0
      @game.board[4][0] = 0
      @game.board[3][0] = 0
      @game.board[2][0] = 0

      expect(@game.check_direction(5, 0, 'column')).to eq(true)
      expect(@game.check_direction(4, 0, 'column')).to eq(true)
      expect(@game.check_direction(3, 0, 'column')).to eq(true)
      expect(@game.check_direction(2, 0, 'column')).to eq(true)
    end

    it 'Calculates a diagonal match in top left corner' do
      @game.board[5][0] = 0
      @game.board[4][1] = 0
      @game.board[3][2] = 0
      @game.board[2][3] = 0

      expect(@game.check_direction(5, 0, 'diagonal')).to eq(true)
      expect(@game.check_direction(4, 1, 'diagonal')).to eq(true)
      expect(@game.check_direction(3, 2, 'diagonal')).to eq(true)
      expect(@game.check_direction(2, 3, 'diagonal')).to eq(true)
    end

    it 'Calculates a reverse diagonal match' do
      @game.board[1][0] = 0
      @game.board[2][1] = 0
      @game.board[3][2] = 0
      @game.board[4][3] = 0

      expect(@game.check_direction(1, 0, 'reverse_diagonal')).to eq(true)
      expect(@game.check_direction(2, 1, 'reverse_diagonal')).to eq(true)
      expect(@game.check_direction(3, 2, 'reverse_diagonal')).to eq(true)
      expect(@game.check_direction(4, 3, 'reverse_diagonal')).to eq(true)
    end

    it 'Calculates a reverse diagonal match in top left corner' do
      @game.board[2][0] = 0
      @game.board[3][1] = 0
      @game.board[4][2] = 0
      @game.board[5][3] = 0

      expect(@game.check_direction(2, 0, 'reverse_diagonal')).to eq(true)
      expect(@game.check_direction(3, 1, 'reverse_diagonal')).to eq(true)
      expect(@game.check_direction(4, 2, 'reverse_diagonal')).to eq(true)
      expect(@game.check_direction(5, 3, 'reverse_diagonal')).to eq(true)
    end

    it 'Handles corners' do
      expect(@game.check_direction(5, 6, 'reverse_diagonal')).to eq(false)
      expect(@game.check_direction(5, 0, 'reverse_diagonal')).to eq(false)
      expect(@game.check_direction(0, 0, 'reverse_diagonal')).to eq(false)
      expect(@game.check_direction(0, 6, 'reverse_diagonal')).to eq(false)

      expect(@game.check_direction(5, 6, 'diagonal')).to eq(false)
      expect(@game.check_direction(5, 0, 'diagonal')).to eq(false)
      expect(@game.check_direction(0, 0, 'diagonal')).to eq(false)
      expect(@game.check_direction(0, 6, 'diagonal')).to eq(false)

      expect(@game.check_direction(5, 6, 'column')).to eq(false)
      expect(@game.check_direction(5, 0, 'column')).to eq(false)
      expect(@game.check_direction(0, 0, 'column')).to eq(false)
      expect(@game.check_direction(0, 6, 'column')).to eq(false)

      expect(@game.check_direction(5, 6, 'row')).to eq(false)
      expect(@game.check_direction(5, 0, 'row')).to eq(false)
      expect(@game.check_direction(0, 0, 'row')).to eq(false)
      expect(@game.check_direction(0, 6, 'row')).to eq(false)
    end
  end
end
