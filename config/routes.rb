Rails.application.routes.draw do
  
  # トップページ
  root to: 'toppages#index' ;
  
  
  # ログイン周り
  get    'login' , to: 'sessions#new';
  post   'login' , to: 'sessions#create';
  delete 'logout', to: 'sessions#destroy';


  # ユーザ周り
  
  # /signup へのアクセスでuserが新規作成できるようにする
  get 'signup', to: 'users#new';
  
  # edit, update, destroyは無し
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
    collection do
      #get :search
    end
  end


  # 投稿周り
  resources :microposts, only: [:create, :destroy];

  # フォロー周り
  resources :relationships, only: [:create, :destroy];
  
end
