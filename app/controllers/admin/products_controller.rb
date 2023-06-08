class Admin::ProductsController < ApplicationController
    layout "admin"
    before_action :authenticate_user!
    def index 
    end
end
