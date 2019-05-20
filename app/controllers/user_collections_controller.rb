class UserCollectionsController < ApplicationController
	authorize_resource

	def create
		@user_collection = UserCollection.new
		@user_collection.user_id = current_user.id
		@user_collection.collection_id = params[:collection_id]
		@user_collection.save
		redirect_to root_path
	end
end
