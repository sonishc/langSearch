Rails.application.routes.draw do
  root to: 'search_languages#index'
  post 'search_languages/index'
end
