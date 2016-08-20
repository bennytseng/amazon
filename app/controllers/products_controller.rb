class ProductsController < ApplicationController
  before_action :authenticate_user, except:[:index, :show]

  def new
     @product = Product.new
  end

  def create
    product_params =find_params
    @product = Product.new product_params
    if @product.save
      redirect_to product_path(@product),
      notice: "valid product!"
    else
      render :new
    end
  end

  def index
    @products = Product.all
  end

  def show
    find_product
    @review = Review.new
  end

  def index
    @products = Product.all
  end

  def destroy
    find_product
    @product.destroy
    redirect_to products_path
  end

  def edit
    find_product
  end

  def update
    product_params = find_params
    find_product
    @product.update product_params
    redirect_to products_path(@product)
  end

  private
  def find_product
    @product = Product.find params[:id]
  end
  def find_params
     params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
