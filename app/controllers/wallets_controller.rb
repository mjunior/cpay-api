class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :update, :destroy]
  before_action :authenticate_customer

  def balance
    render json: { balance: current_customer.wallet.balance } if current_customer.wallet
  end

  def charge
    ActiveRecord::Base.transaction do
      amount = params[:amount]
      wallet = current_customer.wallet
      wallet.charge(amount)
      wallet.save!
      render json: { balance: wallet.balance } if current_customer.wallet
    end
  end

  def draw
    ActiveRecord::Base.transaction do
      amount = params[:amount]
      wallet = current_customer.wallet
      wallet.draw(amount)
      wallet.save!
      render json: { balance: wallet.balance } if current_customer.wallet
    end
  end
end
