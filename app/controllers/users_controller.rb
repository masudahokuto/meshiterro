class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
	  @user = User.find(params[:id])
	  @post_images = @user.post_images.page(params[:page])
	end

  def edit
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  # ログインしているユーザーのidとURLに含まれるidを比較し、一致しなければ投稿画像一覧ページに移動する
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
end