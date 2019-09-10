class CommentsController < ApplicationController 
  before_action :ensure_logged_in, except: [:show] 
def new
  @comment = Comment.new 
  render :new 
end 

def create 
  @comment = Comment.new(comment_params)
  @comment.author_id = current_user.id
  @comment.post_id = params[:post_id]
  @comment.parent_comment_id = params[:parent_comment_id]
  if @comment.save
    redirect_to post_url(params[:post_id])
  else
    @comment = Comment.new(comment_params)
    flash.now[:errors] = @comment.errors.full_messages
    render :new
  end

end 

def edit 
  @comment = current_user.comments.find_by(id: params[:id])
  render :edit 
end 

def update
  @comment = current_user.comments.find_by(id: params[:id])
  if @comment.update_attributes(comment_params)
    redirect_to comment_url(@comment)
  else
    flash[:errors] = ["You cant edit other peoples comments "]
    redirect_to comment_url(@comment)
  end
end 

def destroy
  @comment = current_user.comments.find_by(id: params[:id])
  post_id = @comment.post_id
  @comment.destroy
  flash[:errors] = ['comment was deleted ']
  redirect_to post_url(post_id)
end 

def show
  @comment = Comment.find(params[:id])
  render :show
end 

private 

def comment_params 
  params.require(:comment).permit(:content)
end 

end 
