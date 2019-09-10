class PostsController < ApplicationController 

  before_action :ensure_logged_in, only: [:new, :destroy]
  def new 
    @post = Post.new
    render :new
  end 

  def create
    @post = Post.new(post_params)
     
    @post.author_id = current_user.id
    # @post.sub_ids = post_params[:sub_ids]
    if @post.save
      
      redirect_to subs_url
    else
      flash.now[:errors] = @post.errors.full_messages 
      render :new
    end  
  end 

  def show 
    @post = Post.find(params[:id])
    render :show
  end 

  def edit 
    @post = current_user.posts.find_by(id: params[:id])
    if @post 
      render :edit 
    else 
      flash[:errors] = ["Cannot update a post that is not yours"]
      redirect_to post_url(params[:id])
    end 
  end 

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post
      @post.destroy
      flash[:errors] = ['Post was deleted!']
      redirect_to subs_url
    else
      flash[:errors] = ['You can only delete your own posts']
      redirect_to post_url(params[:id])
    end
  end 

  private 

  def post_params 
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end 

end 