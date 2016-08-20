class ReviewsController < ApplicationController

  before_action :authenticate_user

  def create
    @review = Review.new params.require(:review).permit(:stars,:body, :product_id)
    @review.user_id = session[:user_id]
    # pry
    @product = Product.find params[:product_id]
    @review.product = @product
    if @review.save
      redirect_to product_path(@product), notice: 'Answer created!'
    else
      flash[:alert] = 'Please fix errors below'
      render '/products/show'
    end
  end

  def destroy
    pr = Product.find params[:product_id]
    r = Review.find params[:id]
    r.destroy
    redirect_to product_path(pr), notice: 'Answer deleted'
  end
end
