class FavoritesController < ApplicationController
  
  # お気に入りの操作は必ずログイン済み前提とする
  before_action :require_user_logged_in;
  
  def create
    current_user.favorites.find_or_create_by(micropost_id: params[:micropost_id]);
    flash[:success] = 'お気に入りに追加しました。';
    redirect_back(fallback_location: root_url);
  end

  def destroy
    favorite = current_user.favorites.find_by(micropost_id: params[:micropost_id]);
    favorite.destroy if favorite;
    flash[:success] = 'お気に入りを解除しました。';
    redirect_back(fallback_location: root_url);
  end
  
end
