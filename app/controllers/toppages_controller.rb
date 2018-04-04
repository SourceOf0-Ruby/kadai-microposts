class ToppagesController < ApplicationController

  # ログイン時のみ表示するページを指定
  before_action :require_user_logged_in, only: [:favoritings];

  def index
    if logged_in?
      @user = current_user;
      
      # ログイン中のユーザとフォローしているユーザの投稿一覧を表示する
      @microposts = @user.feed_microposts.order('created_at DESC').page(params[:page]);
      
      # 新規投稿用
      @micropost = @user.microposts.build;
    end
  end
  
  def favoritings
    @user = current_user;
    
    # ログイン中のユーザのお気に入り投稿一覧を表示する
    @favoritings = @user.favoritings.page(params[:page]);
    
    # 新規投稿用
    @micropost = @user.microposts.build;
  end
  
end
