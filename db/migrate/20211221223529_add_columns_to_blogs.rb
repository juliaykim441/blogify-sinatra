class AddColumnsToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :title, :string
  end
end
