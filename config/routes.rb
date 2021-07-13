Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only:[:create,:destroy]
    get'followings'=>'relationships#followings',as:'followings'
    get 'followers'=>'relationships#followers',as:'followers'
  end

  resources :books do
    resource:favorites,only:[:create,:destroy]
  end
  
  
  get '/search', to: 'searches#search'
  resources :groups do
    get "join"=>"groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
end