class ProductsController < ApplicationController

  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: Product.all.order(:id) }
    end
  end

  def create
    respond_to do |format|
      format.json do
        @product = Product.new(permitted_params)
        if @product.save
          head :ok
        else
          render json: { errors: @product.errors.full_messages }, status: 400
        end
      end
    end
  end

  def show
    respond_to do |format|
      if @product
        format.html
        format.json { render json: @product }
      else
        format.html { redirect_to root_path }
        format.json { head 404 }
      end
    end
  end

  def edit
    redirect_to root_path unless @product
  end

  def update
    respond_to do |format|
      format.json do
        if @product.update(permitted_params)
          head :ok
        else
          render json: { errors: @product.errors.full_messages }, status: 400
        end
      end
    end
  end

  def destroy
    @product.try(:destroy) and head 204 or head 404
  end


  private


  def permitted_params
    params.require(:product).permit(:name, :price, :description)
  end

  def find_product
    @product = Product.where(id: params[:id]).first
  end

end
