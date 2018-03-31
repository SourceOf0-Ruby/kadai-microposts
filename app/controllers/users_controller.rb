class UsersController < ApplicationController
  
  # ログイン時のみ表示するページを指定
  before_action :require_user_loggen_in, only: [:index, :show];
  
  def index
    @users = User.all.page(params[:page]);
  end

  def show
    @user = User.find(params[:id]);
  end

  def new
    @user = User.new;
  end

  def create
    @user = User.new(user_params);
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。';
      #session[:user_id] = @user.id;
      redirect_to @user;
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。';
      render :new;
    end
  end
  
  private
  # 以下privateメンバ
  
  # Strong Paramter
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation);
  end
end
