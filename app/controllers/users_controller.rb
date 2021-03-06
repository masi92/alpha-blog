class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), notice: "welcome to the alpha blog #{@user.username}"
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to articles_path, notice: "Your account was updated successfully"
        end
    end

    def show
        @user_articles = @user.articles.paginate(page: params[:page])
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroyflash[:notice] = "User and all articles created by user have been deleted"
        redirect_to users_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user and !current_user.admin?
            flash[:notice] = "You can only edit your own accout"
            redirect_to root_path
        end
    end

    def require_admin
        if logged_in? and !current_user.admin?
            flash[:notice] = "Only admins can perform that action"
            redirect_to root_path
        end
    end
end
