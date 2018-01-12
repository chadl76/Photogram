class AddUserIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :user_id, :integer
  end
  	#add_index :posts, :user_id, :unique => true
end
