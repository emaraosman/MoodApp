class Statistic < ApplicationRecord
  def change
    create_table :statistics do |t|
      t.integer :sleep
      t.integer :happiness
      t.integer :energy
      t.integer :stress
      t.integer :optimism
      t.text :wins
      t.text :losses
      t.belongs_to :user_id, index: true
      t.timestamps
    end
  end
end
