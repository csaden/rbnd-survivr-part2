require "colorizr"
require_relative "ordinal"
require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"

#After your tests pass, uncomment this code below
#=========================================================
# Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!

# Create two new tribes with names
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))

# Create a new game of Survivor
@borneo = Game.new(@coyopa, @hunapu)
#=========================================================


#This is where you will write your code for the three phases
def phase_one
  8.times do
    losing_tribe = @borneo.immunity_challenge
    if losing_tribe == @coyopa
      voted_off = @coyopa.tribal_council
      @coyopa.members.delete voted_off
    else
      voted_off = @hunapu.tribal_council
      @hunapu.members.delete voted_off
    end
    tribe_loss_message losing_tribe, voted_off
  end
end

def phase_two
  3.times do
    immune = @borneo.individual_immunity_challenge
    voted_off = @merge_tribe.tribal_council immune: immune
    @merge_tribe.members.delete voted_off
    voted_off_message voted_off
  end
end

def phase_three
  7.times do |round|
    immune = @borneo.individual_immunity_challenge
    voted_off = @merge_tribe.tribal_council immune: immune
    voted_off_message voted_off
    @jury.add_member voted_off
    puts "#{voted_off}".capitalize.blue + " is the #{(round + 1).ordinal} person to join the jury."
    @merge_tribe.members.delete voted_off
  end
end

def tribe_loss_message losing_tribe, voted_off
  puts "#{losing_tribe}".capitalize.red + " lost the immunity challenge."
  puts "#{losing_tribe}".capitalize.red + " voted off " +"#{voted_off}".capitalize.yellow + ". The tribe has spoken."
end

def voted_off_message loser
  puts "#{loser}".capitalize.yellow + " has been eliminated. The tribe has spoken."
end

# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
@jury = Jury.new
phase_three #7 elminiations become jury members
finalists = @merge_tribe.members #set finalists
names = finalists.map{|finalist| finalist.name.capitalize.magenta}
puts "The two finalists are " + names.join(" and ") + "."
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
@jury.announce_winner(vote_results) #Jury announces final winner
