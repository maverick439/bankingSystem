class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :account_no
      t.string :transaction_type
      t.float :transaction_amount
      t.string :mode
      t.string :state

      t.timestamps
    end
    add_index :transactions, :user_id
  end
end
