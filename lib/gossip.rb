class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.foreach("./db/gossip.csv") do |row|
      all_gossips << Gossip.new(row[0], row[1])
    end
    all_gossips
  end

  def self.find(id)
    all_gossips = self.all
    all_gossips[id]
  end

  def update(new_author, new_content)
    @author = new_author
    @content = new_content
    save
  end

  def delete
    all_gossips = Gossip.all
    all_gossips.delete_if { |gossip| gossip.author == @author && gossip.content == @content }
    CSV.open("./db/gossip.csv", "w") do |csv|
      all.gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
  end
end
