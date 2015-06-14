class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.float :money, default: 0

      t.timestamps null: false
    end
  end
end
