require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  before :each do
    User.create(name: 'NewUser', email: 'user@example.com', password: '1234567', password_confirmation: '1234567')
  end

  it 'signs me in' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: '1234567'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
