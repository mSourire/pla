require 'rails_helper'

RSpec.describe Product, type: :model do

  before :each do
    @product = Product.new
  end

  let :create_many_products do
    Product.create([
      { id: 2, name: 'Beetroot', description: 'Magenta' },
      { id: 1, name: 'Carrot', description: 'Orange' },
      { id: 3, name: 'Lemon', description: 'Yellow' },
      { id: 4, name: 'Orange', description: 'Orange' },
      ])
  end

  context "when just initialized" do
    it "is not valid" do
      expect(@product.valid?).to eq(false)
    end
  end

  it "is not valid without name" do
    @product.description = "Red juice balls"
    @product.price = 25
    expect(@product.valid?).to eq(false)
  end

  it "is not valid without description" do
    @product.name = "Tomato"
    @product.price = 25
    expect(@product.valid?).to eq(false)
  end

  it "is valid without price" do
    @product.name = "Tomato"
    @product.description = "Red juice balls"
    expect(@product.valid?).to eq(true)
  end


  describe ".all" do
    it "returns all products from database ordered by ascending id" do
      create_many_products
      expect(Product.all.collect(&:id)).to be_eql [1, 2, 3, 4]
    end
  end

  describe ".get" do
    context "when a record found" do
      it "returns the record" do
        create_many_products
        expect(Product.get(1)).to be_kind_of(Product)
      end
    end

    context "when a record isn't found" do
      it "returns nil" do
        create_many_products
        expect(Product.get(7)).to be_nil
      end
    end
  end

end
