Rails.application.routes.draw do
  
  # トップページ
  root to: 'toppages#index';

  # /favoritings へのアクセスでお気に入り一覧を表示するようにする
  get 'favoritings', to: 'toppages#favoritings';
  
  
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
  
  # お気に入り周り
  resources :favorites, only: [:create, :destroy];
  
end
