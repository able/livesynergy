class General
  include Mongoid::Document

  field :occupancy, :type => Array, :default => Array.new
  attr_accessible :occupancy
end


