class Actor 
  include Mongoid::Document

  field :timestamp, :type => String
  field :liveLinkID, :type => String
  field :zoneType, :type => Integer
  
  attr_accessible :zoneType, :timestamp, :liveLinkID
  index ([[:liveLinkID],[:timestamp, Mongo::DESCENDING]])
end
