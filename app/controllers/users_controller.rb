class UsersController < ApplicationController

  def new
    @title = 'Sign up'
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the sample app"
      sign_in @user
      redirect_to user_url(@user)
    else
      @user.password = nil
      @user.password_confirmation = nil
      @title = "Sign up"
      render 'new'
    end
  end

end
