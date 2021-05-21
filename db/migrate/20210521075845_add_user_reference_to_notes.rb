class AddUserReferenceToNotes < ActiveRecord::Migration[6.1]
  def change
    add_reference :notes, :user, null: true, foreign_key: true
  end
end
