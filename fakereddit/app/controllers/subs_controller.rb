class SubsController < ApplicationController 

  before_action :ensure_logged_in, only: [:new, :edit, :destroy]

  def new 
    @sub = Sub.new 
    render :new 
  end 

  def create 
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end 

  def edit 
    @sub = current_user.moderated_subs.find_by(id: params[:id])
    # @sub = Sub.find(params[:id])
    if @sub # && @sub.moderator_id == current_user.id 
      render :edit 
    else
      flash[:errors] = ["You cannot modify someone elses subs"]
      redirect_to sub_url(params[:id])
    end
  end 

  def update 
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end 

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    flash[:errors] = ['Sub was destroyed']
    redirect_to subs_url  
  end 

  def index 
    @subs = Sub.all 
    render :index
  end 

  def show
    @sub = Sub.find(params[:id])
    render :show 
  end 


  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end 
end 