class Svg < ActiveRecord::Base
  attr_accessible :name, :tags
  serialize :tags, ActiveRecord::Coders::Hstore

  SVG_ROOT = '/home/rortian/wikicommons/downloads'

  scope :rdf, where("tags ? 'rdf:RDF'")

  def self.stats(scope=all,track=%w(path g line))
    first_moment = Hash.new 0
    second_moment = Hash.new 0
    histograms = {}
    track.each do |tag|
      histograms[tag] = Hash.new 0
    end
    n = 0
    scope.each do |svg|
      n += 1
      track.each do |tag|
        x = svg.tags[tag].to_i || 0
        first_moment[tag] += x
        second_moment[tag] += x*x
        histograms[tag][x] += 1
      end
    end
    tags = {}
    track.each do |tag|
      first = first_moment[tag]*1.0/n
      second = second_moment[tag]*1.0/n
      tags[tag] = {
        mean: first,
        variance: second - first*first,
        std_dev: Math.sqrt(second - first*first),
        raw: first_moment[tag],
        histogram: histograms[tag]
      }
    end
    { N: n, tags: tags}
  end

  def to_xml
    File.read path
  end

  def path
    "#{SVG_ROOT}/#{name}"
  end

end

