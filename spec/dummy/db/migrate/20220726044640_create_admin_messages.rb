class CreateAdminMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_messages do |t|
      t.datetime :user_read_at
      t.timestamps
    end
  end
end
