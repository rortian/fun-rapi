class Svg < ActiveRecord::Base
  attr_accessible :name, :tags
  serialize :tags, ActiveRecord::Coders::Hstore

  def self.stats(scope=all,track=%w(path g line))
    first_moment = Hash.new 0
    second_moment = Hash.new 0
    n = 0
    scope.each do |svg|
      n += 1
      track.each do |tag|
        x = svg.tags[tag].to_i || 0
        first_moment[tag] += x
        second_moment[tag] += x*x
      end
    end
    binding.pry
    tags = {}
    track.each do |tag|
      first = first_moment[tag]*1.0/n
      second = second_moment[tag]*1.0/n
      tags[tag] = {
        mean: first,
        variance: second - first*first,
        std_dev: Math.sqrt(second - first*first),
        raw: first_moment[tag]
      }
    end
    { N: n, tags: tags}
  end
end
