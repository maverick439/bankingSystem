class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]
  before_action :authorize_access_request!, except: [:show, :index]

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  def get_account_transaction_history(account_params)
    if account_params[:username] && account_params[:account_no]
      @transactions = Transactions.where(account_no: account_params[:account_no]).order('created_at desc')
      render json: @transactions, status: :200
    else
      render json: { error: 'Insufficient information' }, status: :unprocessable_entity
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:user_id, :account_type, :account_no, :start_date, :end_date, :ifsc, :balance)
    end
end
