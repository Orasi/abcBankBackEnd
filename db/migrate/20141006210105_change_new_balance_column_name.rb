class ChangeNewBalanceColumnName < ActiveRecord::Migration
  def change
    rename_column :transactions, :new_balace, :new_balance
  end
end
