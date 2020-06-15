# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'Validation tests' do
    subject { Event.new }
    let(:creator) { User.create(name: 'Audrey', lastname: 'Odiaka') }

    it 'valid with valid attributes' do
      subject.description = 'Any description'
      subject.creator = creator
      expect(subject).to be_valid
    end

    it 'not valid without a description' do
      subject.creator = creator
      expect(subject).to_not be_valid
    end

    it 'not valid without a creator' do
      subject.description = 'Any description'
      expect(subject).to_not be_valid
    end

    it 'not valid without valid attributes' do
      expect(subject).to_not be_valid
    end

    it 'adds a new Event' do
      count = Event.count
      subject.update(description: 'New Event', user_id: creator.id)
      expect(Event.count).to eq(count + 1)
    end
  end

  context 'Associations tests' do
    let(:user) { User.create(name: 'Maru', lastname: 'Odiaka') }
    let(:event) { Event.create(description: 'party', user_id: user.id) }
    let(:invitee) { User.create(name: 'Anita', lastname: 'Anyaiwe') }
    let(:invitation) { event.invitations.build(user_id: invitee.id) }
    let(:attended_event) { event.user_attended_events.create(user_id: invitee.id) }

    it 'has many invitees' do
      expect(event.respond_to?(:invitees)).to be_truthy
      expect(event.invitations).to include(invitation)
    end

    it 'has many attendees' do
      expect(event.respond_to?(:attendees)).to be_truthy
      expect(event.user_attended_events).to include(attended_event)
    end
  end
end
