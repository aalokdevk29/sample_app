require 'test_helper'

class InvoiceControllerTest < ActionDispatch::IntegrationTest
  let(:invoice) { create(:invoice) }

  test 'should get index' do
    get invoices_path
    assert_response :success
  end

  test 'should get new' do
    get new_invoice_path
    assert_response :success
  end

  test 'should create new invoice' do
    attributes = { invoice: { client_name: 'Test name', amount: '1200', tax: 120 } }
    assert_difference('Invoice.count') do
      post invoices_path, params: attributes
    end

    invoice = Invoice.last
    assert_response :redirect
    follow_redirect!
    assert_equal 'Test name', invoice.client_name
    assert_equal flash[:notice], 'Invoice for Test name successfully created.'
  end

  test 'should get update client name' do
    attributes = { invoice: { client_name: 'Test name' } }
    patch xhr_change_client_name_invoice_path(invoice), xhr: true, params: attributes

    invoice.reload
    assert_response :success
    assert_equal 'Test name', invoice.client_name
  end

  test 'should destroy invoice' do
    invoice.save
    assert_difference('Invoice.count', -1) do
      delete invoice_path(invoice)
    end

    assert_response :redirect
    follow_redirect!

    assert_equal flash[:notice], 'Invoice for John Smith successfully destroyed.'
  end
end
