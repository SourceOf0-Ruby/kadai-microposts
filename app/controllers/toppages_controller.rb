class ToppagesController < ApplicationController
  
  def index
    if logged_in?
      @user = current_user;
      
      # ログイン中のユーザとフォローしているユーザの投稿を表示する
      @microposts = @user.feed_microposts.order('created_at DESC').page(params[:page]);
      
      # 新規投稿用
      @micropost = @user.microposts.build;
    end
  end
  
end
