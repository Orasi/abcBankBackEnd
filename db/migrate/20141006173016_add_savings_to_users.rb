class AddSavingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :savings, :string
  end
end
