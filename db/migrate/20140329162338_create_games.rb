class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :user_id
      t.string :location
      t.string :console

      t.timestamps
    end
	add_index :games, [:user_id, :created_at]
  end
end
