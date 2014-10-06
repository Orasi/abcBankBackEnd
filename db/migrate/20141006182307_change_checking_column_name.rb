class ChangeCheckingColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :checking, :checking_balance
    rename_column :users, :savings, :savings_balance
    rename_column :users, :credit, :credit_balance
  end
end
