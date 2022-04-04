class ProfileUsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweeets = @user.tweeets.order("created_at DESC")

    @likes = Like.where(user_id: params[:id])
  end

  def create_follow
    @user = User.find(params[:id])
    current_user.followees.push(@user)
    redirect_back(fallback_location: root_url)
  end
  
  def destroy_follow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: root_url)
  end

  def follower
    @user = User.find(params[:id])
    @users = Follow.find_by(follower_id: @user.id)
    @q = User.ransack(params[:q]) 
    @followers = @q.result
    if @followers.nil?
      @followers = Follow.where(follower_id: @user.id, followee_id: @user.id)
    else
      @followers = @user.followers
    end
  end

  def following
    @user = User.find(params[:id])
    @followees = @user.followees.order("created_at DESC")
  end
end