class OrderController < ApplicationController

  def get_cost
    @amazon = Amazon.new(request[:order][:amazon_url])
    @amazon.get_product_details
  end

  def status
    rave = RavePay.new
    response = rave.call(params[:txref])
    response_charge_code = response['data']['chargecode']
    purchase_request_status = response['data']['status']
    reference_code = response['data']['txRef']
    customer_email = response['data']['customer']['email']
    if response_charge_code == '00' || response_charge_code == '0'
      order = Order.where(txref: reference_code, email: customer_email)
      order.status = 2
      order.update
    end
      #place order on amazon
  end

  def payment
    Order.create(full_name: params[:name], 
                phone_number: params[:phone_number], 
                price: params[:price], 
                shipping_cost: params[:shipping], 
                amazon_url: params[:amazon_url], 
                email: params[:email],
                status: 1,
                txref: params[:reference_code])
  end
  



  private

  def order_params
    params.require(:order).permit(
      :amazon_url,
      :quantity,
      :delivery_method,
      :region
    )
  end

end
