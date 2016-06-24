@players = {}

def generate_question
	num1 = rand(20)
	num2 = rand(20)
	math = rand(3)
	return generate_addition(num1, num2) if math == 0
	return generate_subtraction(num1, num2) if math == 1
	return generate_multiplication(num1, num2) if math == 2
	return generate_division(num1, num2) if math == 3
end

def generate_addition(num1,num2)
	answer = num1 + num2
	question = { question: "What does #{num1} plus #{num2} equal?", answer: answer}
end

def generate_subtraction(num1,num2)
	answer = num1 - num2
	question = { question: "What does #{num1} minus #{num2} equal?", answer: answer}
end

def generate_multiplication(num1,num2)
	answer = num1 * num2
	question = { question: "What does #{num1} times #{num2} equal?", answer: answer}
end

def generate_division(num1,num2)
	while num2 == 0 do
		num2 = rand(20)
	end
	answer = num1 / num2
	question = { question: "What does #{num1} divided by #{num2} equal?", answer: answer}
end

def get_players
	puts "How many players will play?"
	(gets.strip.to_i).times do |current_player|
		puts "What is Player #{current_player+1}'s name?"
		@players[gets.strip] = 0
	end
end

def get_input
	puts "Tell us your answer."
	gets.strip
end

def restart?
	puts "Do you want to restart? (y/n)"
	gets.strip == 'y' ? true : false
end


def show_results
	puts "The game has ended!"
	puts "The loser is: #{(@scores.detect { |k,v| v <= 0 }).first}"
	@players.each do |(k,v)|
		@players[k] += @scores[k]
		puts "#{k}: #{@scores[k]} [Running score: #{@players[k]}]"
	end
end

def greenify(string)
	"\e[32m#{string}\e[0m"
end

def redify(string)
	"\e[31m#{string}\e[0m"
end

def game_proc
	@scores = Hash.new(3)
	until @scores.detect { |(k,v)| v <= 0} do
		@players.keys.each do |player|
			question = generate_question
			puts "#{player}: #{question[:question]}"
			if get_input.to_i != question[:answer]
				puts redify("Sorry you were wrong. The answer was #{question[:answer]}")
		 		@scores[player] -= 1
		 		if @scores[player] <= 0
		 			break
		 		end
		 	else
		 		puts greenify("Good job. #{question[:answer]} was the right answer!")
		 	end
		end
	end
	show_results
	restart? ? game_proc : (puts "Goodbye")
end

def main
	get_players
	game_proc
end

main