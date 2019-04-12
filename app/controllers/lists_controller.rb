class ListsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :create, :destroy]
  before_action :get_list,       only: [:show, :destroy]
  before_action :correct_user,   only: :destroy
  
  def index
    @lists = current_user.lists
  end
  
  def show
  end
  
  def new
    @list = List.new
  end
  
  def create
    list = current_user.lists.create(list_params)
    if list
      redirect_to list
    else
      flash.now[:error] = "Could not save list"
      render action: "new"
    end
  end
  
  def destroy
    @list.destroy
    flash[:success] = "List deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  
    def list_params
      params.require(:list).permit(:name)
    end
    
    def get_list
      @list = current_user.lists.find_by(id: params[:id])
    end
  
    def correct_user
      redirect_to root_url if @list.nil?
    end
end
