class Lifestock < ActiveRecord::Base

  belongs_to :user
  cattr_accessor :lifestocklist
  @@lifestocklist = ["Cow", "Pig", "Cattle"]
  validates_inclusion_of :type, in: lifestocklist


  def value
    quantity * unit_value
  end

  scope :vaccinated, ->(type) { where(:type => type, :periods_since_vaccination => 0)}
end
