class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]
  before_action :authorize_access_request!, except: [:show, :index]

  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @user = User.find(transaction_params[:user_id])
    if @user.role_id == 1
      @transaction = Transaction.new(transaction_params)
      if @transaction.save
        render json: @transaction, status: :created, location: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Role access issue' }, status: :unprocessable_entity
  end

  def credit_money(transaction_params)
    if transaction_params[:username] && transaction_params[:account_no] && transaction_params[:transaction_type] && transaction_params[:transaction_amount] && transaction_params[:mode]  
      ActiveRecord::Base.transaction do  
        @account = Account.where(account_no: transaction_params[:account_no]).first
        final_balance = @account.balance + transaction_params[:transaction_amount]
          Account.find(@account.id).update(balance: final_balance)
          Transaction.new(transaction_params)
          TransactionMailer.with(email_details: transaction_params).credit_transaction_email.deliver_now  
      end  
      render json: { error: 'Successful transaction' }, status: :200
    else
      render json: { error: 'Insufficient information' }, status: :unprocessable_entity
    end
  end

  def debit_money(transaction_params)
    if transaction_params[:username] && transaction_params[:account_no] && transaction_params[:transaction_type] && transaction_params[:transaction_amount] && transaction_params[:mode]  
      ActiveRecord::Base.transaction do  
        @account = Account.where(account_no: transaction_params[:account_no]).first
        final_balance = @account.balance - transaction_params[:transaction_amount]
        if final_balance > 0
          Account.find(@account.id).update(balance: final_balance)
          Transaction.new(transaction_params)
          TransactionMailer.with(email_details: transaction_params).debit_transaction_email.deliver_now  
        else
          render json: { error: 'Insufficient balance' }, status: :unprocessable_entity
        end
      end
      render json: { error: 'Successful transaction' }, status: :200
    else
      render json: { error: 'Insufficient information' }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:user_id, :account_no, :transaction_type, :transaction_amount, :mode, :state)
    end
end
