class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.decimal :amount
      t.string :description
      t.date :due_date
      t.integer :from_customer_id, foreign_key: true
      t.integer :to_customer_id, foreign_key: true
      t.timestamps
    end
  end
end
