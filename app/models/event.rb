class Event < ActiveRecord::Base
  attr_accessor :skip_id_validation
#   validates_uniqueness_of :app_name
#   validates :app_name, presence: true
  belongs_to :user
  belongs_to :app
end
