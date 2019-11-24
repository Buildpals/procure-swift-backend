class Order < ApplicationRecord
  enum status: [:failed, :pending, :success]
end
