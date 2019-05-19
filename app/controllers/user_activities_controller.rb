class UserActivitiesController < ApplicationController
	
  def create
  @activity = UserActivity.new
  @activity.user_id = params[:user_id]
  @activity.activity_id = params[:activity_id]
  @activity.status = params[:status]
  @activity.title = "#{Activity.find(params[:activity_id]).category.name}: #{Activity.find(params[:activity_id]).name}"
  authorize! :create, @activity
  @activity.save
  redirect_to edit_user_activity_path(@activity.user_id,@activity.activity.id)
  end

  def edit
  	@user = User.find(params[:user_id])
    @activity = UserActivity.where(user_id: params[:user_id], activity_id: params[:activity_id]).first
    authorize! :edit, @activity
  end


  def update
    @activity = UserActivity.where(user_id: params[:user_id], activity_id: params[:activity_id]).first
    authorize! :update, @activity
    @activity.update(start: params[:user_activity][:start])
    if params[:user_activity][:photo] != nil
      @actuser_photo = ActuserPhoto.new
      @actuser_photo.photo = params[:user_activity][:photo]
      @actuser_photo.user_activity_id = @activity.id
      @actuser_photo.save
    end
    redirect_to user_path(current_user)
  end

  def update_calendar
    @activity = UserActivity.find(params[:activity_id])
    authorize! :update_calendar, @activity
    @activity.update(start: params[:user_activity][:start])
  end


  def destroy
  	@activity = UserActivity.where(user_id: params[:user_id], activity_id: params[:activity_id]).first
  	authorize! :destroy, @activity
    @activity.destroy
    redirect_to user_path(current_user), notice: 'La actividad fue eliminada'
  end

end
