class Product < ApplicationRecord
  validates_uniqueness_of :name
  validates_numericality_of :price, allow_blank: true
  validates_presence_of :description 
end
