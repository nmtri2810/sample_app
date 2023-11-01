class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
      check_user_activated user
    else
      flash.now[:danger] = t("invalid_email_password")
      render :new, status: :unprocessable_entity
    end
  end

  def check_user_activated user
    if user.activated
      log_in user
      params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t("account_not_activated")
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
