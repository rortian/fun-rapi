class AddIndexOnSvgName < ActiveRecord::Migration
  def up
    execute "create unique index svg_names on svgs (name);"
  end

  def down
    execute "drop index svg_names;"
  end
end
