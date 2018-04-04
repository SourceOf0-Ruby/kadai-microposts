class MicropostsController < ApplicationController
  
  # 記事の操作は必ずログイン済み前提とする
  before_action :require_user_logged_in;
  
  # 操作によっては投稿主とログインユーザが一致するかチェックする
  before_action :correct_user, only: [:destroy];
  
  
  def create
    @user = current_user;
    @micropost = @user.microposts.build(micropost_params);
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。';
      redirect_to root_url;
    else
      @microposts = @user.feed_microposts.order('created_at DESC').page(params[:page]);
      flash.now[:danger] = 'メッセージの投稿に失敗しました。';
      render 'toppages/index';
    end
  end
  
  def destroy
    @micropost.destroy;
    flash[:success] = 'メッセージを削除しました。';
    
    # アクションを行ったページにリダイレクトするが、戻れなかった場合はルートへリダイレクト
    redirect_back(fallback_location: root_url);
  end
  
  
  private
  
  # Strong Parameter
  def micropost_params
    params.require(:micropost).permit(:content);
  end
  
  # 操作を行う投稿主のチェックを行う
  # 一致すれば@micropostに該当postを格納する
  # 一致しなければルートへリダイレクト
  def correct_user
    # ログインユーザの投稿記事から該当するものを検索する
    @micropost = current_user.microposts.find_by(id: params[:id]);
    unless @micropost
      flash[:danger] = '操作を実行できませんでした。';
      redirect_to root_url;
    end
  end
  
end
