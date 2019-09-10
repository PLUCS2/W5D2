# == Schema Information
#
# Table name: postsubs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sub_id     :integer          not null
#  post_id    :integer          not null
#

class Postsub < ApplicationRecord
  belongs_to :sub
  belongs_to :post


end
