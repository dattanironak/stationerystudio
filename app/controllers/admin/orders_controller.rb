class Admin::OrdersController < ApplicationController
  def index
    case params[:status]
    when "all"
      @orders = Order.includes(:address, :user)
    when "generated"
      @orders = Order.generated
    when "paid"
      @orders = Order.paid
    when "accepted"
      @orders = Order.accepted
    when "shipped"
      @orders = Order.shipped
    when "delivered"
      @orders = Order.delivered
    else
      @orders = Order.all
    end
  end
end
