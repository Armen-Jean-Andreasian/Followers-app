class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }  # Specifying the table
      t.text :body

      t.timestamps  # Rails will add created_at and updated_at automatically
    end
  end
end
