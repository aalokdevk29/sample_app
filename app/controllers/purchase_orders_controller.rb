class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: %i[edit update destroy]
  before_action :load_invoice, only: :create
  # GET /purchase_orders
  def index
    @purchase_orders = PurchaseOrder.all
  end

  # GET /purchase_orders/1/edit
  def edit; end

  # POST /purchase_orders
  def create
    @purchase_order = @invoice.purchase_orders.build(@invoice.dup.attributes)

    if @purchase_order.save
      redirect_to edit_purchase_order_path(@purchase_order)
    else
      redirect_to root_path, notice: 'unprocessable entity'
    end
  end

  # PATCH/PUT /purchase_orders/1
  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to purchase_orders_path, notice: 'Purchase order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /purchase_orders/1
  def destroy
    @purchase_order.destroy
    redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.'
  end

  private

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def purchase_order_params
    params.require(:purchase_order).permit(:client_name, :amount, :tax, :vendor, :status)
  end

  def load_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end
end
