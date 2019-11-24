require 'uri'
require 'net/http'

class Amazon

  attr_reader :image, :shipping, :price, :product_name, :amazon_url

  def initialize(amazon_url)
    @amazon_url = amazon_url
    @asin = exact_asin_number(amazon_url)
  end

  def get_product_details
    url = URI("https://api.zinc.io/v1/products/#{@asin}?retailer=amazon")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = 'Basic MjZGRkRDRkJBNEE0OTY4NzM4NDJENUIwOg=='
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = '7436d421-9623-4c31-985c-106e5075a433'
    response = http.request(request)
    response_json = ActiveSupport::JSON.decode(response.read_body)
    parse_response(response_json)
  end

  def exact_asin_number(amazon_url)
    asin = 0
    if amazon_url.match(/\/dp\/(\w{10})(\/|\Z)/)
        # /dp/B0015T963C
        asin = $1
    elsif amazon_url.match(/\/gp\/\w*?\/(\w{10})(\/|\Z)/)
        # /gp/product/D0015T963C
        asin = $1
    elsif amazon_url.match(/\/gp\/\w*?\/\w*?\/(\w{10})(\/|\Z)/)
        # /gp/product/glance/E0015T963C
        asin = $1
    elsif amazon_url.match(/\/gp\/[\w-]*?\/(\w{10})(\/|\Z)/)
        # /gp/offer-listing/F018Y23P7K
        asin = $1
    elsif amazon_url.match(/\/product-reviews\/(\w{10})(\/|\Z)/)
        # /product-reviews/G018Y23P7K
        asin = $1
    elsif amazon_url.match(/[?&]asin=(\w{10})(&|#|\Z)/i)
        # ?asin=H018Y23P7K
        # &ASIN=H018Y23P7K
        asin = $1
    else
        asin = false
    end
      asin
  end

  def parse_response(json)
    @product_name = json['title']
    @image = json['main_image']
    @shipping = 40
  end

  def shipping_cost_by_air
    # TODO
  end

  def place_order
    # TODO 
  end
  

end