Rails.application.routes.draw do
  resources :tutors do
    resources :availabilities, only: [:create, :index]
  end

  resources :students do
    resources :bookings, only: [:create, :index]
    get 'search_tutors', on: :collection
  end

  post '/availability', to: 'availabilities#add_or_update'
end
