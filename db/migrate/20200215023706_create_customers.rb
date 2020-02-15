class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :national_registry_code
      t.string :email
      t.integer :registry_type

      t.timestamps
    end
  end
end
