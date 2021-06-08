class FriendshipsController < ApplicationController
  def create
    # @friendship = current_user.friendships.new(friend_id: params[:user_id])
    @friend = User.find_by_id(params[:user_id])
    if current_user.friend_request(@friend)
      redirect_to users_path, notice: 'You have sent a friendship request.'
    else
      redirect_to users_path, alert: 'The friendship request can not be sent.'
    end
  end

  def destroy
    friendship = Friendship.by_user(current_user).for_user(User.find_by_id(params[:user_id]))
    if friendship
      friendship.destroy
      redirect_to user_path, notice: 'You are not friend with this guy anymore.'
    else
      redirect_to user_path, alert: 'You are not a friend so you can not delete this friendship.'
    end
  end
end
