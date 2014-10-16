class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update,
                                  :destroy, :history, :transfer,
                                  :transfer_page, :report]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @id = params[:id]
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @hybrid = true if params[:format]
    @id = params[:id]
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def history
    @filter = params[:account]
    @hybrid = true if params[:format]
    @id = params[:id]
  end

  def transfer_page
    @hybrid = true if params[:format]
    @id = params[:id]
  end

  def transfer
    @hybrid = params[:hybrid]
    params[:transfer][:amount] = params[:transfer][:amount].sub('$', '')
    transaction = @user.transfers.new(transfer_params)
    transaction.prev_balance = @user.amount_in(transfer_params[:from_account])
    transaction.new_balance = @user.amount_in(transfer_params[:from_account]) - transfer_params[:amount].to_i
    if transaction.save
      @user.create_transaction(transfer_params)
      flash[:success] = 'Transfer Completed'
    else
      flash[:error] = 'Transfer Failed'
    end

    redirect_to balances_path(format: @hybrid)
  end

  def report

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password)
    end

    def transfer_params
      params.require(:transfer).permit(:date, :amount, :to_account, :from_account, :location)
    end
end
