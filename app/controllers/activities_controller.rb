class ActivitiesController < ApplicationController
	authorize_resource

	def index
		@activity = Activity.find(params[:id])
		if user_signed_in?
			if UserActivity.where(user_id: current_user.id,activity_id: @activity.id) != []
				@registrada = true
			else
				@registrada = false
			end
		end
	end

	def new
		@activity = Activity.new
		@categories = Category.all
	end

	def create
		@activity = Activity.new
		@activity.name = params[:activity][:name]
		@activity.category_id = params[:activity][:category_id]
		@activity.photo = params[:activity][:photo]
		@activity.remote_photo_url = params[:activity][:remote_photo_url]
		@activity.owner_id = current_user.id
		@activity.save
		redirect_to root_path, notice: 'la actividad fue creada. Puede ingresarla a su registro si lo desea'
	end

	def edit	
		@activity = Activity.where(id: params[:activity_id]).first
		@categories = Category.all
	end

	def update
		@activity = Activity.where(id: params[:activity_id]).first
		@activity.update(author: params[:activity][:author])
		@activity.update(category_id: params[:activity][:category_id])
		@activity.update(photo: params[:activity][:photo])
		@activity.update(remote_photo_url: params[:activity][:remote_photo_url])
    	redirect_to user_path(current_user)
	end

	
	
end
