# frozen_string_literal: false

# Module that holds the methods to run the game
module UserComputer
  def number_to_color(num)
    case num
    when 0
      'r'
    when 1
      'b'
    when 2
      'y'
    when 3
      'g'
    when 4
      'c'
    when 5
      'w'
    end
  end

  def user_code
    possibilities = (1111..6666).to_a
    possibilities.map!(&:to_s)
    possibilities.select! do |el|
      !el.include?('7') && !el.include?('8') && !el.include?('9') && !el.include?('0')
    end
    possibilities.map! { |el| el.split('') }
    puts 'Set the code that the computer is going to guess.'
    code = gets.chomp!.split('').freeze
    puts "Your code is: #{code}"
    computer_guess = %w[1 1 2 2]
    rounds_to_solve = 1
    12.times do
      answer = []
      code_helper = code.dup
      guess_copy = computer_guess.dup
      code_helper.each_with_index.map do |element, index|
        next unless element == guess_copy[index]

        answer.push('O')
        guess_copy[index] = 'X'
        code_helper[index] = 'n'
      end
      code_helper.each_with_index do |element, index|
        next unless guess_copy.include?(element)

        answer.push('o')
        hold_index = guess_copy.index(element)
        guess_copy[hold_index] = 'X'
        code_helper[index] = 'n'
      end
      puts "The computer's guess is #{computer_guess}."
      puts "The answer is #{answer}"
      if answer == %w[O O O O]
        puts "The computer cracked your code in #{rounds_to_solve} rounds!"
        break
      else
        puts "The computer didn't quite get it yet..."
        puts
        print 'Press any key to continue into the next round'
        gets
        possibilities_helper = []
        first_pos_holder = possibilities.dup
        first_pos_holder.each do |el|
          el_holder = el.dup
          holder_answer = []
          guess_help = computer_guess.dup
          guess_help.each_with_index.map do |element, index|
            next unless element == el_holder[index]

            holder_answer.push('O')
            guess_help[index] = 'X'
            el_holder[index] = 'n'
          end
          guess_help.each_with_index do |element, _index|
            next unless el_holder.include?(element)

            holder_answer.push('o')
            hold_index = el_holder.index(element)
            el_holder[hold_index] = 'n'
          end
          possibilities_helper.push(el) if holder_answer.sort! == answer.sort!
        end
        possibilities = possibilities_helper.dup
        computer_guess = possibilities[0]
      end
      rounds_to_solve += 1
    end
  end

  def computer_code
    code = []
    4.times { code.push(number_to_color(rand(6))) }
    code.freeze
    round_num = 1
    p code
    12.times do
      puts "Round #{round_num}"
      user_guess = []
      num_user_guess = 1
      4.times do
        print "Make your number #{num_user_guess} guess: "
        guess_holder = gets.chomp!.downcase
        user_guess.push(guess_holder)
        num_user_guess += 1
      end
      puts "Your guess is #{user_guess}, and..."
      if user_guess == code
        puts "You win! You craked the code in #{round_num} rounds."
        break
      else
        puts "You didn't quite get it just yet, but the computer says..."
        answer = []
        code_helper = code.dup
        guess_copy = user_guess.dup
        code_helper.each_with_index.map do |element, index|
          next unless element == guess_copy[index]

          answer.push('O')
          guess_copy[index] = 'X'
          code_helper[index] = 'n'
        end
        code_helper.each_with_index do |element, index|
          next unless guess_copy.include?(element)

          answer.push('o')
          hold_index = guess_copy.index(element)
          guess_copy[hold_index] = 'X'
          code_helper[index] = 'n'
        end
        p answer.shuffle!
        puts
      end
      round_num += 1
      puts "You haven't been able to crack the code. :-(\nThe original code was #{code}." if round_num == 13
    end
  end
end

# class that starts the game
class Game
  extend UserComputer

  def self.start_game
    puts 'Do you want to set the code (s) or guess (g) the code from the computer?:'
    response = gets.chomp!.downcase
    unless %w[s g].include?(response)
      puts "Please, select either 's' (you set the code) or 'g' (the computer sets the code and you guess it):"
      response = gets.chomp!.downcase
    end
    if response == 's'
      user_code
    else
      computer_code
    end
  end
end

Game.start_game
