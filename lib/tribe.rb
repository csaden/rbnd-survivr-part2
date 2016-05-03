class Tribe
  attr_reader :name, :members

  def initialize options={}
    @name = options[:name]
    @members = options[:members]
    puts "#{name} with members: #{members.map {|member| member.name.capitalize}}"
  end

  def tribal_council options={}
    voted_off = nil
    while voted_off.nil? or voted_off == options[:immune]
      voted_off = @members.sample
    end
    voted_off
  end

  def to_s
    "#{name}"
  end
end
