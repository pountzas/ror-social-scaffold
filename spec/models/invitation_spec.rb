require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it 'Succeeds when you create a friendship with user and friend' do
    user = User.new(name: 'valid3', email: 'valid@3', password: 'valid3', password_confirmation: 'valid3')
    user.save
    friend = User.new(name: 'valid4', email: 'valid@4', password: 'valid4', password_confirmation: 'valid4')
    friend.save
    expect(user.invitations.create(friend_id: friend.id,
                                   confirmed: false)).to eql(Invitation.find_by(user_id: user.id))
  end

  it 'Fails when you try to create a friendship without all parameters' do
    friendship = Invitation.create
    expect(friendship.errors.full_messages).to eql(['User must exist'])
  end
end
