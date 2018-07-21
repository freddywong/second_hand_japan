class ListingsController < ApplicationController
  def index
    @listings = Listing.paginate(page: params[:page])
  end
end