class AddCheckingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :checking, :string
  end
end
