Rails.application.routes.draw do
  resources :reservation_details
  devise_for :users
  get 'pages/index'

  get 'pages/calendar'

  get 'pages/reservation'

  root to: 'pages#calendar'

  get '/redirect', to: 'google#redirect', as: 'redirect'
  get '/callback', to: 'google#callback', as: 'callback'
  get '/calendars', to: 'google#calendars', as: 'calendars'
  get '/events/:calendar_id', to: 'google#events', as: 'events', calendar_id: /[^\/]+/
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
