class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :text
      t.string :name
      t.datetime :when

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
