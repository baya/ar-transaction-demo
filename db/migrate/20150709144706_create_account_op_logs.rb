class CreateAccountOpLogs < ActiveRecord::Migration
  def change
    create_table :account_op_logs do |t|
      t.integer :account_id
      t.string  :action 
      t.timestamps null: false
    end
  end
end
