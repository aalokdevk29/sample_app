class PurchaseOrder < ApplicationRecord
  belongs_to :invoice

  validates :client_name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum status: {
    draft: 0, paid: 1, delivered: 2
  }
end
