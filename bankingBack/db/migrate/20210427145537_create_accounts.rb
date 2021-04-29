class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :account_type
      t.string :account_no
      t.date :start_date
      t.date :end_date
      t.string :ifsc
      t.float :balance

      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
