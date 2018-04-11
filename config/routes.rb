Rails.application.routes.draw do
  
  # トップページ
  root to: 'toppages#index';

  # /favorites へのアクセスでお気に入り一覧を表示するようにする
  get 'favorites', to: 'toppages#favorites';
  
  
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
  resources :microposts, only: [:create, :destroy] do
    # お気に入り周り
    resource :favorites, only: [:create, :destroy];
  end
  
  # フォロー周り
  resources :relationships, only: [:create, :destroy];
  
end
