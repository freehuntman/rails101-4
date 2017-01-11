class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.user = current_user
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.user = current_user

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.user = current_user

    @post.destroy
    redirect_to group_path(@group), alert: "Post deleted"
  end




  private

  def post_params
    params.require(:post).permit(:content)
  end

end
