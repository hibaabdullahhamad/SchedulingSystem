Rails.application.routes.draw do
  resources :tutors do
    resources :availabilities, only: [:create, :index]
  end

  resources :students do
    resources :bookings, only: [:create, :index]
  end
end
