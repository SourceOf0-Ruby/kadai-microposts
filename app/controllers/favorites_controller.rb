class FavoritesController < ApplicationController
  
  # お気に入りの操作は必ずログイン済み前提とする
  before_action :require_user_logged_in;
  
  def create
    @micropost = Micropost.find(params[:micropost_id]);
    current_user.favorite(@micropost);
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id]);
    current_user.unfavorite(@micropost);
  end
  
end
