# == Schema Information
#
# Table name: auth_tokens
#
#  id         :integer          not null, primary key
#  value      :uuid             not null
#  expires_at :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AuthToken < ApplicationRecord
  belongs_to :user

  def expired?
    expires_at > Time.now
  end
end
