class CreateStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :statistics do |t|
      t.integer :sleep
      t.integer :happiness
      t.integer :energy
      t.integer :stress
      t.integer :optimism
      t.text :wins
      t.text :losses
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
