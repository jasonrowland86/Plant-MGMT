class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :session_token
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :username
    add_index :users, :session_token
  end
end
