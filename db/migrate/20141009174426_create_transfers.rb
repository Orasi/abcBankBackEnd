class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.date :date
      t.string :location
      t.string :from_account
      t.string :to_account
      t.decimal :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
