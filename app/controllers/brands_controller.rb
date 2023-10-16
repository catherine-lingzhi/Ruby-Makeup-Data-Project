class BrandsController < ApplicationController
  def index
    @brands = Brand.all.page(params[:page]).per(15)
  end

  def show
    @brand = Brand.find(params[:id])
  end
end
