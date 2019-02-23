class UsersController < ApplicationController
    before_action :set_user, only:[:show, :edit, :update]
    before_action :prohibited_access, only:[:show, :edit, :update]
    
    def new
        @user = User.new
    end
    
    def create
    @user = User.new(user_params)
        if @user.save
            redirect_to user_path(@user.id)
        else
            render 'new'
        end
    end
    
    def show
        @favorite_blogs=current_user.favorite_blogs
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
          redirect_to user_path(@user.id), notice: "編集しました！"
        else
          render 'edit', notice: "パスワードが一致しません。"
        end
    end
  
private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:image, :image_cache)
  end
  
  def set_user
      @user = User.find(params[:id])
  end
end
