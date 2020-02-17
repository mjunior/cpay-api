class Wallet < ApplicationRecord
  belongs_to :customer
  validates :balance, numericality: { greater_than_or_equal_to: 0 }


  def charge (amount)
    self.balance = self.balance + amount
    self.save!
  end

  def draw(amount)
    self.balance = self.balance - amount
    self.save!
  end
end
