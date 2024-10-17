class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :commenter, null: false, foreign_key: { to_table: :users }
      t.references :commented_to, polymorphic: true, null: false # :comments, :posts
      t.text :body
      t.timestamps

    end
  end
end
