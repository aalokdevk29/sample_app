FactoryBot.define do
  factory :purchase_order do
    client_name { 'John Smith' }
    amount { 100 }
    tax { 12 }
    vendor { 'temp1' }
    status { 'draft' }
    association :invoice
  end
end
