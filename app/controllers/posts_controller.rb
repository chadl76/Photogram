class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :edit, :update, :destroy, :like] 
	before_action :owned_post, only: [:edit, :update, :destroy]

	def index
		@posts = Post.page(params[:page]).order("created_at DESC")
	end
	
	def new
		@post = current_user.posts.build
	end

	def edit 
		@post = Post.find(params[:id])
	end

	def show
		@post = Post.find(params[:id])
		@comments = Comment.page(params[:page])

		respond_to do |format|
			format.html {render :show}
			format.js {}
		end				
	end

	def update
		@post = Post.find(params[:id])
		@post.update(post_params)
		
		redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:id])

		@post.destroy
		redirect_to :root
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

	def like
		 @post.liked_by current_user
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		
	end

	def unlike
			@post = Post.find(params[:id])
			if @post.liked_by current_user

			respond_to do |format| 
				format.html {redirect_to :back}
				format.js 
			end
		end
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
			redirect_to root_path
		end
	end
end
