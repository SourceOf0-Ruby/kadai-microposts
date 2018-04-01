class ToppagesController < ApplicationController
  def index
    if logged_in?
      # ログイン中のユーザの投稿を表示する
      @user = current_user;
      @microposts = @user.microposts.order('created_at DESC').page(params[:page]);
      
      # 新規投稿用
      @micropost = @user.microposts.build;
    end
  end
end
