class Admin::UsersController < ApplicationController

  before_action :check_admin

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "#{@user.fullname} added"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname)
  end

  def check_admin
    redirect_to root_url, notice: "Cannot view unless admin" unless current_user.admin
  end

end
