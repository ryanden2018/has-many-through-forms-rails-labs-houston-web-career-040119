class CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    redirect_to comment.post
  end

  private

  def comment_params
    new_params = params.require(:comment).permit(:content, :post_id, :user_id, user_attributes:[:username])

    if new_params[:user_attributes] && (new_params[:user_attributes][:username] == "")
      new_params.delete("user_attributes")
    end

    new_params
  end
end
