class Event
  include Mongoid::Document

  field :event_type # [enter_zone, exit_zone]
  field :live_link_id
  field :live_pulse_id
  field :timestamp
  field :rssi

  attr_accessible :event_type, 
                  :live_link_id,
                  :live_pulse_id,
                  :timestamp,
                  :rssi
                  
  @@live_pulse_map = [
    {:zone => 1, :live_pulse_id => 1}, 
    {:zone => 2, :live_pulse_id => 2}, 
    {:zone => 3, :live_pulse_id => 3}, 
    {:zone => 4, :live_pulse_id => 4} 
  ]
  
  @@live_link_map = [
    {:user => 'Jeff', :live_link_id => 1},
    {:user => 'Ben', :live_link_id => 2},
    {:user => 'Fred', :live_link_id => 3},
    {:user => 'Kaifei', :live_link_id => 4},
    {:user => 'Mike', :live_link_id => 5}
  ]
  
  @@event_type_map = [
    {:name => 'ground_enter_zone', :string => ' enters zone '},
    {:name => 'ground_exit_zone', :string => ' exits zone '}
  ]
  
  def self.live_pulse_map
    return @@live_pulse_map
  end
  
  def self.live_link_map
    return @@live_link_map
  end
                  
  def self.event_type_map
    return @@event_type_map
  end
end


