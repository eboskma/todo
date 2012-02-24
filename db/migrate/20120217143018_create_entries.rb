class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :text
      t.boolean :done
      t.integer :order

      t.timestamps
    end
  end
end
