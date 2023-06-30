class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :brand
      t.integer :price
      t.references :category, null: false, foreign_key: true
      t.integer :weight

      t.timestamps
    end
  end
end