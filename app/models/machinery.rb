class Machinery < ActiveRecord::Base

  belongs_to :user
  cattr_accessor :machinerylist
  @@machinerylist = ["Tractor", "Harvester"]
  validates_inclusion_of :type, in: machinerylist

  alias_attribute :value, :unit_value
  scope :repaired, ->(type) { where(:type => type, :periods_since_maintenance => 0)}


end
