class CollectionsController < ApplicationController
	authorize_resource
  def show
  	@collection = Collection.find(params[:id])
  end
end
