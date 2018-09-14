# == Schema Information
#
# Table name: goals
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  public     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
  end
  
  describe "assocations" do
    it { should belong_to(:user) }
  end
end
