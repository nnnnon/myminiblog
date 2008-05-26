class AlterColumnMessage < ActiveRecord::Migration
  def self.up
    rename_column :messages, :text, :body
  end

  def self.down
    rename_column :messages, :body, :text
  end
end
