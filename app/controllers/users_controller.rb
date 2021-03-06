class UsersController < ApplicationController
  skip_before_filter :store_target_location, :except => :show

  def show
  	@user = User.find(params[:id])
    if current_user == @user
      @group = Group.new
    end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
      flash[:success] = "Welcome to Name Draw! You are now logged in."
      redirect_to_target_or_default(@user)
    else
  		render 'new'
  	end
  end

  def update
    @user = User.find(params[:id])

    if @user && current_user && current_user == @user
      @user.update_attributes(user_params)
    end
  end

  private

	  def user_params
	    params.require(:user).permit(:name, :email, :password, :password_confirmation, :interests, :public_avatar)
	  end
end
