class WelcomeController < ApplicationController

  def login
    @user = User.new
  end

  def validate
    params[:user][:username].downcase!
    @user = User.find_by(username: params[:user][:username])
    respond_to do |format|
      if @user.nil?
        @user = User.create_user(params[:user][:username], params[:user][:password])
        format.html { redirect_to user_path(@user.id) }
        format.json { render json: @user }
      elsif @user.password == params[:user][:password]
        format.html { redirect_to user_path(@user.id) }
        format.json { render json: @user }
      else
        format.html { redirect_to :root }
        format.json { render json: nil }
      end
    end
  end
end
