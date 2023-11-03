class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create show)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.sorted_by_name, items: Settings.items_pagination)
  end

  def show
    @pagy, @microposts = pagy @user.microposts, items: Settings.items_pagination
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t("flash_check_email")
      redirect_to root_url
    else
      render :new

    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t("update_success")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("delete_success")
    else
      flash[:danger] = t("delete_fail")
    end
    redirect_to users_path
  end

  def following
    @title = t "following"
    @pagy, @users = pagy @user.following, items: Settings.items_pagination
    render :show_follow
  end

  def followers
    @title = t "followers"
    @pagy, @users = pagy @user.followers, items: Settings.items_pagination
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation, :date_of_birth, :gender
    )
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:warning] = t("user_not_found")
    redirect_to root_path
  end

  def correct_user
    return if current_user? @user

    flash[:error] = t("cannot_edit")
    redirect_to root_url
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
