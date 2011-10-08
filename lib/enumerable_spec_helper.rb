module EnumerableSpecHelper
  # :name is a method on #subject. 
  def all_the name, description &block
    it "all the #{name} #{description}" do
      (subject.send(:name).all? &blk).should be_true
    end
  end
end

describe World do
  extend EnumerableSpecHelper
  subject { World.new(:people => [Factory.party_person, Factory.player, Factory.player_hater]) }
  
  all_the :people, "like to party" do |p|
    p.party_preference == 'hell yes'
  end

  all_the :people, "live life for today" do |p|
    p.live_life_for?(Time.now)
  end
  
  all_the :people, "live life in peace" do |p|
    p.peaceful?
  end

  all_the :people, "share all the world" do |p|
    described_class.has?(p)
  end
end