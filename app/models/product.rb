class Product < ApplicationRecord
  paginates_per 5
  belongs_to :category
  has_one_attached :main_picture 
  has_many_attached :pictures 
  has_many :order_details 
  has_many :orders, through: :order_details
  validates :name, :price, :description, :brand, :category_id, :weight, presence: true

  validates :price, :weight, numericality: true
end
