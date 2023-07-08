class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :district
      t.integer :pincode
      t.string :landmark
      t.string :name
      t.string :contact_number
      t.references :user, null: false, foreign_key: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
