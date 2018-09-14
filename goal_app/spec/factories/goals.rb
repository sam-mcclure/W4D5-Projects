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

FactoryBot.define do
  factory :goal do
    title { "MyString" }
    user_id { 1 }
    public { false }
  end
end
