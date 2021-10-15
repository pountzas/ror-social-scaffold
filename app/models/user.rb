class User < ApplicationRecord
  has_secure_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :invitations
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: 'friend_id'
  has_many :confirmed_invitations, -> { where confirmed: true }, class_name: 'Invitation'

  has_many :friends, through: :confirmed_invitations
  has_many :pending_friends, through: :pending_invitations, source: :friend
  has_many :inverted_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_invitations

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end

  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_invitation && friends_i_got_invitation
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def send_invitation(user)
    invitations.create(friend_id: user.id)
  end
end
