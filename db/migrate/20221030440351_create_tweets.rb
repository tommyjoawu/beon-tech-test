class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.references :user, foreign_key: trues
      t.text :body
      t.timestamps
    end
  end
end
