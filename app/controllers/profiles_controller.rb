class ProfilesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user
  def show
    	@posts = User.find_by(username: params[:username]).posts.order('created_at DESC') 
      
  end

  def edit
  	
  end

  def update
  	@user.update(user_params)

  	redirect_to :root
  end


  private 

  def set_user
  	@user = User.find_by(username: params[:username])
  end

  def user_params
  	params.require(:user).permit(:bio, :avatar)
  end
end
