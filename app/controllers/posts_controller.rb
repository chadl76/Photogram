class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :edit, :update, :destroy] 
	before_action :owned_post, only: [:edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def new
		@post = current_user.posts.build
	end


	def create
		
		@post = current_user.posts.build(post_params)
		if @post.save
		flash[:success] = "post created"
			redirect_to posts_path
		else
			flash.now[:alert] = "couldn't create post"
			render :new
		end
	
	end

	def edit
		

	end

	def show
		@post
	end

	def update
		@post.update(post_params)

		redirect_to post_path(@post)
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def post_params
		params.require(:post).permit(:caption, :image)
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def owned_post
		unless current_user == @post.user
			flash[:alert] = "Post isn't yours"
			redirect_to root_paths
		end
	end
end
