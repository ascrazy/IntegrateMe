class Competition < ActiveRecord::Base
  has_many :entries, inverse_of: :competition

  validates_presence_of :name

  def mail_chimp_list_id
    '3b79f0be47'
  end

  def runner_email
    'luke@example.com'
  end
end
