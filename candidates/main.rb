# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require './candidates'
require './filters'
require './errors'

## Your test code can go here

def get_input
	puts "Please put an input."
	gets.strip
end

def greenify(string)
	"\e[32m#{string}\e[0m"
end

def redify(string)
	"\e[31m#{string}\e[0m"
end

def format_candidate(candidate)
	"#{candidate[:id]} | #{candidate[:years_of_experience]} | #{candidate[:github_points]} | #{candidate[:languages]} | #{candidate[:date_applied]} | #{candidate[:age]}"
end

def format_candidates(candidates)
	result = ""
	candidates.each do |candidate|
		result += "#{candidate[:id]} | #{candidate[:years_of_experience]} | #{candidate[:github_points]} | #{candidate[:languages]} | #{candidate[:date_applied]} | #{candidate[:age]}\n"
	end
	result
end

def main
	#binding.pry
	while true do
		input = get_input
		if /find (?<id>[\d+])/ =~ input
			candidate = find(id.to_i)
			if candidate
				puts "id  | Years of experience | Github Points | Languages                    | Date Applied       | Age"
				qualified?(candidate) ? (puts greenify(format_candidate(candidate))) : (puts redify(format_candidate(candidate)))
				puts "\n"
			else
				puts "No such candidate."
				puts "\n"
			end
		elsif 'all' == input
			puts "id  | Years of experience | Github Points | Languages | Date Applied | Age"
			@candidates.each do |candidate|
				qualified?(candidate) ? (puts greenify(format_candidate(candidate))) : (puts redify(format_candidate(candidate)))
			end
			puts "\n"
		elsif 'qualified' == input
			puts "id  | Years of experience | Github Points | Languages                    | Date Applied       | Age"
			puts greenify(format_candidates(ordered_by_qualifications(qualified_candidates(@candidates))))
		elsif 'quit' == input
			puts "Exiting out of program."
			return
		end
	end
end

main