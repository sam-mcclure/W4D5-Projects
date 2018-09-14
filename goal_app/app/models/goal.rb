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

class Goal < ApplicationRecord
  validates :user_id, :title, presence: true
  
  belongs_to :user,
  foreign_key: :user_id,
  class_name: 'User'
end
