class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :game
      t.string :platform
      t.integer :user_id

      t.timestamps
    end
  end
end
