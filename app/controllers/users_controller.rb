class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t("user_not_found")
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t("create_success")
      redirect_to @user
    else
      render :new

    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation, :date_of_birth, :gender
    )
  end
end
