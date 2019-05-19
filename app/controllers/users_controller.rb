class UsersController < ApplicationController
  authorize_resource :class => UsersController

  def show
  	@user = User.find(params[:id])
    @categories = Category.all

    @act_realizadas = UserActivity.realizadas
    @act_user_realizadas = @act_realizadas.where(user_id: params[:id]).order(:created_at).reverse
    
    @act_pendientes = UserActivity.pendientes
    @act_user_pendientes = @act_pendientes.where(user_id: params[:id]).order(:created_at).reverse

    @act_por_realizar = UserActivity.por_realizar
    @act_user_por_realizar = @act_por_realizar.where(user_id: params[:id]).order(:created_at).reverse

    if user_signed_in?
      if current_user.contacting.find_by(followed_id: @user.id) != nil
        @following = true
      else
        @following = false
      end
    end


    @trek = UserActivity.where(user_id: params[:id])
    @trekking = []
    @trek.each do |i|
      if i.activity.category.id == 3
        @trekking << i
      end
    end

    @hash = Gmaps4rails.build_markers(@trekking) do |trek, marker|
      marker.lat trek.activity.latitude
      marker.lng trek.activity.longitude
      marker.infowindow trek.activity.name
    end
  end
end
