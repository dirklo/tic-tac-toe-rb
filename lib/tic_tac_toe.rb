# Setup
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def current_player(board)
    if turn_count(board) == 0 || turn_count(board)%2 == 0
        "X"
    else    
        "O"
    end
end

def play(board)
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    end 
    if draw?(board)
        puts "Cat's Game!"
    end
    while !over?(board)
        turn(board)
        if won?(board)
            puts "Congratulations #{winner(board)}!"
            break
        end 
        if draw?(board)
            puts "Cat's Game!"
            break
        end
    end
end    



# Moving
def input_to_index(index)
    return index.to_i - 1
end

def move(board, index, value)
    board[index] = value
    return board
end

def turn(board)
    loop do
        puts "Place an #{current_player(board)}"
        puts "Please enter 1-9:"   
        input = gets.chomp
        index = input_to_index(input)
        value = current_player(board)
        if valid_move?(board, index) == true
            move(board, index, value)
            display_board(board)
            return board
        end
        puts "invalid input, try again!"
    end
end

def turn_count(board)
    count = 0
    board.each do |space|
        if space == "X" || space == "O"
            count += 1
        end
    end
    count                
end



# Move checks
def valid_move?(board, index)
    if index >= 0 && index < 9 && position_taken?(board, index) == false
        return true    
    else    
        return false
    end
end       

def position_taken?(board, index)
    if board[index] == "" || board[index] == " "
        return false
    else
        return true
    end
end   



# Board State Checks
def won?(board)
    WIN_COMBINATIONS.each do |combo|
        if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
            return true
        elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
            return true
        end      
    end 
    return false
end

def winner(board)
    WIN_COMBINATIONS.each do |combo|
            if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
            return "X"
            elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
            return "O"
        end
    end
    return nil
end
    
def full?(board)
    if !board.include? " "
        true
    else
        false  
    end  
end

def draw?(board)
    if !won?(board) && full?(board)
        true
    else 
        false  
    end  
end  

def over?(board)
    if won?(board) || full?(board)
        true
    end      
end  
