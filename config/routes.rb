Rails.application.routes.draw do
  root 'home#index'

  resources :links
  get '*short_link', to: 'links#redirect'
end
