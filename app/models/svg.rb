class Svg < ActiveRecord::Base
  attr_accessible :name, :tags
  serialize :tags, ActiveRecord::Coders::Hstore
end
