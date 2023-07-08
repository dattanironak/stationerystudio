class Order < ApplicationRecord
    belongs_to :address 
    belongs_to :user 
    has_many :order_details 
    has_many :products, through: :order_details 

    enum  :status, [ "generated", "paid", "accepted", "shipped", "delivered" ]
end
