class Invoice < ApplicationRecord
  belongs_to :to_customer, class_name: "Customer", foreign_key: "to_customer_id"
  belongs_to :from_customer, class_name: "Customer", foreign_key: "from_customer_id"
end
