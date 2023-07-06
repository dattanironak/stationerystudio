class Admin::ProductsController < ApplicationController
    layout "admin"
    before_action :authenticate_user!
    before_action :authenticate_admin_user?
    before_action :set_product, only: %i[ show edit update destroy ]
  
    def index
      @products = Product.page params[:page]
    end
  

    def show
    end
  

    def new
      @product = Product.new
      @categories = Category.all
    end
  

    def edit 
      @categories = Category.all
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: "Product was successfully created." 
      else
        @categories = Category.all
        render :new, status: :unprocessable_entity 
      end
    end

    def update
        if @product.update(product_params)
          redirect_to admin_products_path, notice: "Product was successfully updated."
        else
          @categories = Category.all  
          render :edit, status: :unprocessable_entity 
        end
    end
  
    def destroy
      @product.destroy
         redirect_to admin_products_path, notice: "Product was successfully destroyed."
    end
  
    private
      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :price, :description, :brand, :category_id, :weight, :main_picture, pictures: [], )
      end
end
