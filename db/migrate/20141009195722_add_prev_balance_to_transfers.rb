class AddPrevBalanceToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :prev_balance, :decimal
    add_column :transfers, :new_balance, :decimal
  end
end
