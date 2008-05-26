class AlterColumnName < ActiveRecord::Migration
  def self.up
    execute "alter table messages alter name set  default 'laoma'"
  end

  def self.down
  end
end
