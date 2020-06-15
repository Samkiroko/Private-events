# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validation tests' do
    subject { User.new }

    it 'valid with valid attributes' do
      subject.name = 'Any name'
      subject.lastname = 'Any last name'
      expect(subject).to be_valid
    end

    it 'not valid without a name' do
      subject.lastname = 'Any last name'
      expect(subject).to_not be_valid
    end

    it 'not valid without a last name' do
      subject.name = 'Any name'
      expect(subject).to_not be_valid
    end

    it 'not valid without valid attributes' do
      expect(subject).to_not be_valid
    end

    it 'creates a user' do
      expect { User.create(name: 'Chifumnanya', lastname: 'Peña') }.not_to raise_error
    end

    it 'adds a new user' do
      count = User.count
      subject.update(name: 'Audrey', lastname: 'Queme')
      expect(User.count).to eq(count + 1)
    end
  end

  context 'Associations tests' do
    let(:user) { User.create(name: 'Maru', lastname: 'Odiaka') }
    let(:event) { Event.create(description: 'party', user_id: user.id) }
    let(:invitee) { User.create(name: 'Anita', lastname: 'Anyaiwe') }
    let(:invitation) { invitee.invitations.build(event_id: event.id) }
    let(:attended_event) { invitee.user_attended_events.create(event_id: event.id) }

    it 'has many events' do
      expect(user.respond_to?(:events)).to be_truthy
      expect(user.events).to include(event)
    end

    it 'has many invitations' do
      expect(invitee.respond_to?(:invitations)).to be_truthy
      expect(invitee.invitations).to include(invitation)
    end

    it 'has many user_attended_events' do
      expect(invitee.respond_to?(:user_attended_events)).to be_truthy
      expect(invitee.user_attended_events).to include(attended_event)
    end
  end
end
