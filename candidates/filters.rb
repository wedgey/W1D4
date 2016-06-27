# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
	raise TypeError.new('@candidates must be an Array') if @candidates.nil?
	@candidates.detect { |candidate| candidate[:id] == id }
end

def experienced?(candidate)
	unless candidate.has_key?(:years_of_experience)
		raise InvalidCandidateError, 'candidate must have a :years_of_experience key'
	end
	candidate[:years_of_experience] >= 2
end

def git_hub_master?(candidate)
	candidate[:github_points] >= 100
end

def ruby_python_master?(candidate)
	candidate[:languages].detect { |language| language.downcase == 'ruby' or language.downcase == 'python' }
end

def applied_last_15?(candidate)
	Date.today - candidate[:date_applied] <= 15
end

def over_17?(candidate)
	candidate[:age] > 17
end

def qualified?(candidate)
	begin
		experienced?(candidate) and	git_hub_master?(candidate) and ruby_python_master?(candidate) and applied_last_15?(candidate) and over_17?(candidate)
	rescue InvalidCandidateError => ex
		puts "We couldn't determine whether the candidate was experienced enough."
		puts "The reason was: #{ex.message}"
	end
end

# More methods will go below
def qualified_candidates(candidates)
	candidates.select do |candidate|
		qualified?(candidate)
	end
end

def ordered_by_qualifications(candidates)
	candidates.sort_by do |candidate|
		[candidate[:years_of_experience], candidate[:github_points]]
	end.reverse
end
