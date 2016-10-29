class Product < ApplicationRecord

  validates_presence_of :name, :description 
  validates_uniqueness_of :name
  validates_numericality_of :price, greater_than_or_equal_to: 0, allow_blank: true

  def self.all
    super.order(:id)
  end

  def self.get id
    where(id: id).first
  end

end
