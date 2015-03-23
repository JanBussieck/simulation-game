class Lifestock < ActiveRecord::Base

  belongs_to :user
  cattr_accessor :lifestocklist
  @@lifestocklist = ["Cow", "Pig", "Cattle"]
  validates_inclusion_of :type, in: lifestocklist

  def unit_value
    Price.where(type: self.type)
  end

  def value
    quantity * unit_value
  end

end
