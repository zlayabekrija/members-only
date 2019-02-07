class UsersController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
        signed_up(@user,user_params[:password])
        else 
            render 'new'
        end
    end
    private
    def user_params
        params.require(:user).permit(:name,:email,:password)
    end
end
