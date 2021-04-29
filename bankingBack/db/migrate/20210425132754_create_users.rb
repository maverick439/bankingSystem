class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :role_id

      t.timestamps
    end
    add_index :users, :role_id
  end
end
