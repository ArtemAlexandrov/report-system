class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status, default: 0, null: false
      t.integer :tracker, default: 0, null: false

      t.timestamps
    end
  end
end
