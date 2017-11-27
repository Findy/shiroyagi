class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.datetime :read_at

      t.timestamps
    end

    add_index :messages, :from_user_id
    add_index :messages, :to_user_id
  end
end
