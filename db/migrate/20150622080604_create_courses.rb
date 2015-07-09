class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :units, default: 0
      t.timestamps null: false
    end
  end
end
