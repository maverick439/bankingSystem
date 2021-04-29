class TransactionMailer < ApplicationMailer
    default from: 'finance@bank.com'

    def credit_transaction_email
        @email_details = params[:email_details]
        mail(to: @email_details.email, subject: 'Credit Transaction from Account')
    end

    def debit_transaction_email
        @email_details = params[:email_details]
        mail(to: @email_details.email, subject: 'Dedit Transaction from Account')
    end
end
