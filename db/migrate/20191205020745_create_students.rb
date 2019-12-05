class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :age
      t.string :gender
      t.string :grade
      t.string :class
      t.integer :teacher_id
    end
  end
end
