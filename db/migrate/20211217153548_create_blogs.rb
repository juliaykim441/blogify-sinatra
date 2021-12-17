class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.text :content
      t.integer :user_id

      t.timestamps null:false
    end
  end
end
