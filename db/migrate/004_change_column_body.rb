class ChangeColumnBody < ActiveRecord::Migration
  def self.up
    change_column :messages, :body, :text, :null => false
  end

  def self.down
    change_column :messages, :body, :string
  end
end
