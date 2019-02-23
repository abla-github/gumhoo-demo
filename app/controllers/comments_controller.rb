class CommentsController < ApplicationController
  before_action :logged_in_user
  
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params.merge(user: current_user))
    
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post }
        format.js
      end
    else
      render 'posts/show'
    end
  end
  
  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
