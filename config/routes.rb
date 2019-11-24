Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'

  post 'order/cost', to: 'order#get_cost', as: :get_cost

  get '/payment', to: 'order#payment', as: :payment

  post '/status', to: 'order#status', as: :update_status
end
