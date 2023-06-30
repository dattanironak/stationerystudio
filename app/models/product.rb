class Product < ApplicationRecord
  belongs_to :category
  has_one_attachment :main_picture
  has_many_attachments :pirctures
end
