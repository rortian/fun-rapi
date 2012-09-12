class CreateSvgs < ActiveRecord::Migration
  def change
    create_table :svgs do |t|
      t.string :name
      t.hstore :tags
    end
  end
end
