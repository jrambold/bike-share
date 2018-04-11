class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    
  end

  def create
    item = Item.find(params[:item_id])

    @basket.add_item(item.id)
    session[:cart] = @basket.contents

    flash[:notice] = "You now have #{pluralize(@basket.count_of(item.id), item.title)}."
    redirect_to bike_shop_path
  end
end
