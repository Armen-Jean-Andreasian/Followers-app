class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :follows, array: true, default: []  # Array of user IDs that this user follows
      t.integer :subscribers, array: true, default: []  # Array of user IDs that follow this user

      t.timestamps
    end
  end
end
