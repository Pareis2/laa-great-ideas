# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relations' do
    it { should have_many(:ideas) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:email) }

    it 'should allow emails from justice.gov.uk domains' do
      user = User.create!(email: 'me@justice.gov.uk', password: 'change_me')
      expect(user).to be_valid
    end

    it 'should not allow emails from non justice.gov.uk domains' do
      user = User.create(email: 'me@gmail.com', password: 'change_me')
      expect(user).to_not be_valid
    end
  end
end
