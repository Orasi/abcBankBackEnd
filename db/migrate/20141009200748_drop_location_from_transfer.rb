class DropLocationFromTransfer < ActiveRecord::Migration
  def change
    remove_column :transfers, :location
  end
end
