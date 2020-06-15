# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'login followed by logout', type: :feature do
  let(:user) { User.create(name: 'Maru', lastname: 'Odiaka') }

  scenario 'header section' do
    visit root_path
    click_on 'Log in'
    fill_in 'session_ide', with: user.id
    click_button 'Log in'
    sleep(3)
    expect(page).to have_content('User Logged in')
    click_on 'Log out'
    sleep(3)
    expect(page). to have_content('User Logged out')
  end
end
