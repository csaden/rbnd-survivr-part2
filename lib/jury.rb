class Jury
  attr_accessor :members

  def initialize
    @members = []
  end

  def add_member member
    @members << member
  end

  def cast_votes finalists
    votes = members.inject({}) do |result, member|
      vote_for = finalists.sample
      result[vote_for] = 0 if result[vote_for].nil?
      result[vote_for] += 1
      puts "#{member}".capitalize.blue + " voted for " + "#{vote_for}".capitalize.magenta + "."
      result
    end
  end

  def report_votes final_votes
    final_votes.each do |finalist, votes|
      puts "#{finalist}".capitalize.magenta + " received #{votes} votes."
    end
  end

  def announce_winner final_votes
    winner = final_votes.key final_votes.values.max
    puts "The winner of Survivor is #{winner.name.capitalize}!".white
    winner
  end
end

