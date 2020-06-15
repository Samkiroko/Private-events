# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events Manager', type: :feature do
  let(:user) { User.create(name: 'Maru', lastname: 'Odiaka') }
  let(:event) { Event.create(description: 'party', user_id: user.id) }
  scenario 'Events index page' do
    visit root_path
    expect(page).to have_content('Upcoming Events')
    expect(page).to have_content('Past Events')
    expect(page).to have_content('All Events')
  end

  scenario 'Events show page' do
    visit "http://localhost:3000/events/#{event.id}"
    sleep(3)
    expect(page).to have_content("Creator: #{user.name}")
    expect(page).to have_content('Attendees')
  end

  scenario 'Create Event and event show page with user logged in' do
    visit root_path
    click_on 'Log in'
    fill_in 'session_ide', with: user.id
    click_button 'Log in'
    sleep(3)
    expect(page).to have_content('User Logged in')
    click_on 'Create new event'
    sleep(3)
    fill_in 'Description', with: event.description
    click_button 'Create my event'
    sleep(3)
    expect(page).to have_content('Event Created')
    expect(page).to have_content("Description: #{event.description}")
    expect(page).to have_content("Creator: #{user.name}")
    expect(page).to have_content('Attendees')
    expect(page).to have_link('Invite People')
  end
end
