class ProductsController < ApplicationController

  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: Product.all }
    end
  end

  def create
    respond_to do |format|
      format.json do
        @product = Product.new(permitted_params)
        if @product.save
          head 201
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
        if @product.try(:update, permitted_params)
          head :ok
        else
          if @product
            render json: { errors: @product.errors.full_messages }, status: 400
          else
            head 404
          end
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
  rescue ActionController::ParameterMissing
    {}
  end

  def find_product
    @product = Product.get(params[:id])
  end

end
