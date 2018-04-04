class RelationshipsController < ApplicationController

  # フォローの操作は必ずログイン済み前提とする
  before_action :require_user_logged_in;

  def create
    user = User.find(params[:follow_id]);
    if current_user.following?(user)
      flash[:warning] = 'すでにユーザをフォローしています。';
    else
      current_user.follow(user);
      flash[:success] = 'ユーザをフォローしました。';
    end
    redirect_to user;
  end

  def destroy
    user = User.find(params[:follow_id]);
    current_user.unfollow(user);
    flash[:success] = 'ユーザのフォローを解除しました。';
    redirect_to user;
  end
  
end
