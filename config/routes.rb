Rails.application.routes.draw do
  
  root to: 'toppages#index' 
  
  
  # ログイン周り
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  # ユーザ周り
  
  # /signup へのアクセスでuserが新規作成できるようにする
  get 'signup', to: 'users#new'
  
  # edit, update, destroyは無し
  resources :users, only: [:index, :show, :new, :create]
end
