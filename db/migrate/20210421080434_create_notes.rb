class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :description
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
