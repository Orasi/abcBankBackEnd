class WelcomeController < ApplicationController

  def login
    @user = User.new
  end

  def validate
    @user = User.find_by(username: params[:user][:username])
    if @user.nil?
      @user = User.create_user(params[:user][:username], params[:user][:password])
      redirect_to user_path(@user.id)
    elsif @user.password == params[:user][:password]
      redirect_to user_path(@user.id)
    else
      redirect_to :root
    end
  end
end
