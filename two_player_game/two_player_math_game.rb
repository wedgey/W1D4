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
	puts "The winner is: #{(@scores[:player1] == 0 ? "Player 2" : "Player 1")}!"
	puts "Player 1: #{@scores[:player1]}"
	puts "Player 2: #{@scores[:player2]}"
end

def greenify(string)
	"\e[32m#{string}\e[0m"
end

def redify(string)
	"\e[31m#{string}\e[0m"
end

def main
	player1 = true
	@scores = Hash.new(3)
	while @scores[:player1] != 0 && @scores[:player2] != 0 do
		question = generate_question
		if player1
			puts "Player 1: #{question[:question]}"
			if get_input.to_i != question[:answer]
				puts redify("Sorry you were wrong. The answer was #{question[:answer]}")
				@scores[:player1] -= 1
			else
				puts greenify("Good job. #{question[:answer]} was the right answer!")
			end
		else
			puts "Player 2: #{question[:question]}"
			if get_input.to_i != question[:answer].to_i
				puts redify("Sorry you were wrong. The answer was #{question[:answer]}")
				@scores[:player2] -= 1
			else
				puts greenify("Good job. #{question[:answer]} was the right answer!")
			end
		end
		player1 = !player1
	end
	show_results
	restart? ? main : (puts "Goodbye")
end

main