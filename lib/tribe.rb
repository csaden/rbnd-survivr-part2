class Tribe
  attr_reader :name, :members

  def initialize options={}
    @name = options[:name]
    @members = options[:members]
    names = members.map{|member| member.name.capitalize.light_grey}
    puts "#{self}".cyan + " with members: " + names.join(", ") + "."
  end

  def tribal_council options={}
    @members.reject {|member| member == options[:immune]}.sample
  end

  def to_s
    @name.capitalize
  end
end
