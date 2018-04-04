class ApplicationController < ActionController::Base
  # CSRF対策
  # 参考:http://hakutoitoi.hatenablog.com/entry/2013/01/05/014857
  protect_from_forgery with: :exception
  
  # ログイン周りのメソッドを使用するためinclude
  include SessionsHelper;
  
  private
  
  # ログインしていない場合はログインページにリダイレクトする
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url;
    end
  end
  
  # 各種総数をセットする
  # @param user: 対象のユーザ
  def counts(user)
    @count_microposts = user.microposts.count;
    @count_followings = user.followings.count;
    @count_followers  = user.followers.count;
  end
  
end
