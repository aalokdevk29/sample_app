require 'test_helper'

class PurchaseOrdersControllerTest < ActionDispatch::IntegrationTest
  let(:purchase_order) { create(:purchase_order) }
  let(:invoice) { create(:invoice) }

  test 'should get index' do
    get purchase_orders_path
    assert_response :success
  end

  test 'should create new purchase order' do
    assert_difference('PurchaseOrder.count') do
      post purchase_orders_path(invoice_id: invoice)
    end

    purchase_order = PurchaseOrder.last
    assert_response :redirect
    assert_equal 'John Smith', purchase_order.client_name
  end

  test 'should get update client name' do
    attributes = { purchase_order: { client_name: 'Test name', status: 'paid' } }
    patch purchase_order_path(purchase_order), params: attributes

    purchase_order.reload
    assert_response :redirect
    assert_equal 'Test name', purchase_order.client_name
    assert_equal 'paid', purchase_order.status
  end

  test 'should destroy purchase_order' do
    purchase_order.save
    assert_difference('PurchaseOrder.count', -1) do
      delete purchase_order_path(purchase_order)
    end

    assert_response :redirect
    follow_redirect!

    assert_equal flash[:notice], 'Purchase order was successfully destroyed.'
  end
end
