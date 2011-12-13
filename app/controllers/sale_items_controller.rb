class SaleItemsController < ApplicationController
  def create
    @sale = Sale.find(params[:sale_id])
    @item = @sale.sale_items.build(params[:sale_item])
    @item.save
    
    respond_to do |format|
      format.html { redirect_to edit_sale_path @sale }
      format.js
    end
  end
end