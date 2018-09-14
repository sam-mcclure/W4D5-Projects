# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    # it { should validate_uniqueness_of(:username) }
    it "ensure session_token gives user a session token" do
      user = FactoryBot.build(:user)
      expect(user.session_token).to_not be_nil
    end
  end
  
  describe "associations" do
    it { should have_many(:goals) }
  end
  
  describe "::find_by_credentials" do 
    it "returns nil with invalid credentials" do 
      user = User.find_by_credentials("test", "123456")
      expect(user).to be_nil
    end
    
    it "returns a user with valid credentials" do 
      user = FactoryBot.create(:user)
      returned_user = User.find_by_credentials("User", "password")
      expect(returned_user).to eq(user)
    end
  end
  
  describe "#reset_session_token!" do
    it "changes the users session token" do
      user = FactoryBot.create(:user)
      session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(session_token)
    end
  end
  
  describe "#has_password" do
    it "returns true when given correct password" do
      user = FactoryBot.create(:user)
      result = user.has_password?('password')
      expect(result).to be true
    end
    
    it "returns false when given wrong password" do
      user = FactoryBot.create(:user)
      result = user.has_password?('123456')
      expect(result).to be false
    end
  end
end
