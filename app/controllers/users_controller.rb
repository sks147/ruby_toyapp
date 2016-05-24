class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  # to secure the admin access
  before_action :admin_user, only: :destroy

  # restrict the before_action filter only for edit and update

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find_by(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  # method to edit the user profile
  def edit
    @user = User.find_by(params[:id])
  end

  # method to update the profile attributes
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #Handle a succesful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end


    # Confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  # Before filters
  
  # Confirms a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
