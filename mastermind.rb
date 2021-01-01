module UserComputer
  def number_to_color(num)
    case num
    when 0
      "r"
    when 1
      "b"
    when 2
      "y"
    when 3
      "g"
    when 4
      "c"
    when 5
      "w"
    end
  end

  def user_code
    possibilities = (1111..6666).to_a
    possibilities.map! { |el| el.to_s}
    possibilities.select! do |el| 
      !el.include?("7") && !el.include?("8") && !el.include?("9") && !el.include?("0")
    end
    possibilities.map! { |el| el.split("")}
    puts "Set the code that the computer is going to guess."
    code = gets.chomp!.split("").freeze
    puts "Your code is: #{code}"
    computer_guess = ["1", "1", "2", "2"]
    num_run = 0
    while num_run != 12
      possibilities_helper = []
      answer = Array.new
      code_helper = code.dup
      code_helper.each_with_index do |element, index|
        if element == computer_guess[index]
          answer.push("O")
          code_helper[index] = "X"
        elsif code_helper.include?(computer_guess[index])
          answer.push("o")          
        end
      end
      puts "The computer's guess is #{computer_guess}."
      p answer
      if answer == ["O", "O", "O", "O"]
        puts "The computer wins!"
        break
      else
        puts "The computer didn't quite get it yet..."
      end
=begin
      possibilities.each do |elthing|
        holder_answer = Array.new
        code_helper = code.dup
        code_helper.each_with_index do |element, index|
          if element == elthing[index]
            holder_answer.push("O")
            code_helper[index] = "X"
          elsif code_helper.include?(elthing[index])
            holder_answer.push("o")
          end
        end
        if !holder_answer.sort.join.include?(answer.sort.join)
          possibilities.delete(elthing)
        end
      end
      computer_guess = possibilities[0]
      num_run += 1
      p num_run
      p possibilities
    end
=end
  end
=begin
    p answer
    computer_guess = computer_guess.join("")
    p computer_guess
    p possibilities[0]
    copy_holder = []
    possibilities.each do |element|
      if element != computer_guess
        copy_holder.push(element)
      end
    end
    possibilities -= copy_holder
    p possibilities
=end

=begin
  def computer_code
    code = Array.new
    4.times {code.push(number_to_color(rand(6)))}
    code.freeze
    holder = 2
    p code
    12.times do
      user_guess = Array.new
      num_user_guess = 1
      4.times do
        print "Make your number #{num_user_guess} guess: "
        guess_holder = gets.chomp!.downcase
        user_guess.push(guess_holder)
        num_user_guess += 1
      end
      puts "Your guess is #{user_guess}, and..."
      if user_guess == code
        puts "You win!"
        break
      else
        puts "You didn't quite get it just yet, but the computer says..."
        answer = Array.new
        code.each_with_index do |element, index|
          if element == user_guess[index]
            answer.push("Right color, right position")
          elsif code.include?(user_guess[index])
            answer.push("Right color, wrong position")
          else
            answer.push("Not the right color")
          end
        end
        puts answer.shuffle!
        puts
      end
    end
  end
=end
end

class Game
  extend UserComputer
  
  def self.start_game
    puts "Do you want to set the code (s) or guess (g) the code from the computer?:"
    response = gets.chomp!.downcase
    unless response == "s" || response == "g"
      puts "Please, select either 's' (you set the code) or 'g' (the computer sets the code and you guess it):"
      response = gets.chomp!.downcase
    end
    if response == "s"
      user_code()
    else
      computer_code()
    end
  end
end

Game.start_game
