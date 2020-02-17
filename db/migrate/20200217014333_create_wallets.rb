class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.decimal :balance, default: 0
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
