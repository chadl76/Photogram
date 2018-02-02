class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post
  

  def create
  	@like = @post.likes.build

  	@like.user_id = current_user.id
  	if @like.save
  		redirect_to :root
  	end
  end

  def delete
  	@post.like.destroy!
  end

  private 

  def set_post
  	@post = Post.find_by(params[:id])
  end


end
