
class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.reload
    @users = @post.users.reload.uniq
    @categories = @post.categories.reload
    @comment = @post.comments.build
    @all_users = User.all
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    post = Post.create(post_params)
    redirect_to post
  end

  private

  def post_params

    new_params = params.require(:post).permit(:title, :content, category_ids:[], categories_attributes: [:name])
    
    if new_params[:categories_attributes] && new_params[:categories_attributes]["0"] && (new_params[:categories_attributes]["0"][:name] == "")
      new_params[:categories_attributes] = {}
    end
    new_params
  end
end
