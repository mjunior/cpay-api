class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update, :destroy]

  # GET /invoices
  def index
    @customer_to = Customer.find_by(national_registry_code: params[:to]) if params[:to]
    @customer_from = Customer.find_by(national_registry_code: params[:from]) if params[:from]

    @invoices = Invoice.all
    @invoices = @invoices.where(from_customer_id: @customer_from.id) if params[:from]
    @invoices = @invoices.where(to_customer_id: @customer_to.id) if params[:to]
    
    render json: @invoices, include: [:from_customer, :to_customer]
  end

  # GET /invoices/1
  def show
    render json: @invoice, include: [:from_customer, :to_customer]
  end

  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      render json: @invoice, status: :created, location: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1
  def update
    if @invoice.update(invoice_params)
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/1
  def destroy
    @invoice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_params
      params.require(:invoice).permit(:amount, :description, :due_date, :from_customer_id, :to_customer_id)
    end

    def set_customer
      @to_customer = Customer.find_by_id(invoice_params[:to_customer_id])
      @from_customer = Customer.find_by_id(invoice_params[:from_customer_id])
    end
end
