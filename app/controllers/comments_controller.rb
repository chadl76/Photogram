class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id
		respond_to do |format|
		  if @comment.save!
			format.html {redirect_to :root }
			format.js
		  end
	    end
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		respond_to do |format|
		
		if @comment.destroy
		format.html {redirect_to :root}
		format.js
	    end
	end
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def set_post
		@post = Post.find(params[:post_id])
	end
end
