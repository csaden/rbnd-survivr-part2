require_relative "../lib/tribe"

class Game
  attr_reader :tribes

  def initialize *tribes
    @tribes = tribes
  end

  def add_tribe tribe
    @tribes << tribe
  end

  def immunity_challenge
    @tribes.sample
  end

  def individual_immunity_challenge
    @tribes.first.members.sample
  end

  def clear_tribes
    @tribes = []
  end

  def merge name
    contestants = tribes.map(&:members).flatten
    @tribes = Tribe.new name: name, members: contestants
  end
end
