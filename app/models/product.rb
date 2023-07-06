class Product < ApplicationRecord
  paginates_per 5
  belongs_to :category
  has_one_attached :main_picture 
  has_many_attached :pictures 

  validates :name, :price, :description, :brand, :category_id, :weight, presence: true

  validates :price, :weight, numericality: true
end
