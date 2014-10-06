class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :account
      t.string :location
      t.decimal :amount
      t.decimal :prev_balance
      t.decimal :new_balace

      t.timestamps
    end
  end
end
