class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :session_id
      t.boolean :correct
      
      t.datetime :created_at
    end
  end
end
