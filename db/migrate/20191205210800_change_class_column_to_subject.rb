class ChangeClassColumnToSubject < ActiveRecord::Migration
  def change
    rename_column :students, :class, :subject
  end
end
