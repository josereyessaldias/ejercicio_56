class PromoteActivitiesController < ApplicationController
  authorize_resource

  def index
  	@user = User.find(params[:user_id])
  	@promotes = PromoteActivity.where(user_id: params[:user_id])
  end

  def new
    @activities = Activity.all
  	@promote_activity = PromoteActivity.new
  end

  def create
    @promote_activity = PromoteActivity.new
    @promote_activity.user_id = params[:user_id]
    @promote_activity.activity_id = params[:promote_activity][:activity_id]
    @promote_activity.amount = params[:promote_activity][:amount]
    @promote_activity.save
    redirect_to promote_activities_path(current_user)
  end

  def destroy
    @promote_activity = PromoteActivity.find(params[:id])
    @promote_activity.destroy
    redirect_to promote_activities_path(current_user), notice: 'La promoción fue eliminada'
  end

end
