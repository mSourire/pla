class ProductsController < ApplicationController

  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: Product.all }
    end
  end

  def create
    new_product = Product.new(allowed_params)
    if new_product.save
      head :ok
    else
      render status: 500
    end
  end

  def show
    respond_to do |format|
      if @product
        format.html
        format.json { render json: @product }
      else
        format.html { redirect_to root_path }
        format.json { render status: 404 }
      end
    end
  end

  def edit
    if @product
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    if @product.update(allowed_params)
      head :ok
    else
      render status: 500
    end
  end

  def destroy
    @product.destroy
  end


  private


  def allowed_params
    params.require(:product).permit(:name, :price, :description)
  end

  def find_product
    @product = Product.where(id: params[:id]).first
  end

end
