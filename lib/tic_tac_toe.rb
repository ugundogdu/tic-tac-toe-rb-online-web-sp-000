WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, player_token)
  board[position] = player_token
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, position)
  position.between?(0,8)  && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if !valid_move?(board, index)
    turn(board)
  else move(board, index, current_player(board))
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |index|
    if index != " "
      count += 1
    end
  end

  count

end

def  current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def  won?(board)
  WIN_COMBINATIONS.each do |win|
    if win.all?{|win| board[win] == "X"}
      return win
    elsif win.all?{|win| board[win] ==  "O"}
      return win
    end
  end
  return false
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
      return true
  else
      return false
  end
end

  def over?(board)
    if full?(board) == true
      return true
  end
  return false
end

def winner(board)
  if (draw?(board) || !full?(board)) && !won?(board)
    return nil
  elsif (board[won?(board)[0]] == "X")
    return "X"
  elsif (board[won?(board)[0]] == "O")
    return "O"
  end
end

def play(board)
   until over?(board) || won?(board) || draw?(board)
      turn(board)
   end
   if won?(board)
      winner(board) == "X" || winner(board) == "O"
      puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
      puts "Cat\'s Game!"
   end
end
