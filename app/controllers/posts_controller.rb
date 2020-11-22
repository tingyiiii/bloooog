class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def user
    @posts = Post.all
  end

  def new
    # @post = Post.new
    @post = current_user.posts.build
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path, notice: '新增成功！'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to user_posts_path, notice: '更新成功！'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path, notice: '已刪除'
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: '不是作者無法編輯此文章喔！' if @post == nil
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def find_post
    @post = Post.find_by(params[:id])
  end
end
