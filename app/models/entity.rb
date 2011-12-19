class Entity
  include Mongoid::Document

  field :name, :type => String
  field :livePulseID, :type => String
  field :uri, :type => String
  field :type, :type => String
  has_many :readings, :class_name => 'Energy'
  has_many :triggers, :class_name => 'Trigger'
  attr_accessible :name, :livePulseID, :uri, :triggers, :readings, :type

  
  @@links = {
    'B2C8AD64036DDB7E' => 'liveSynergy/demo-booth/user1',
    'B2C8AD64036DC478' => 'liveSynergy/demo-booth/user2',
    'B2C8AD64036DD9AA' => 'liveSynergy/demo-booth/user3',
    'liveSynergy/demo-booth/user1' => 'B2C8AD64036DDB7E',
    'liveSynergy/demo-booth/user2' => 'B2C8AD64036DC478',
    'liveSynergy/demo-booth/user3' => 'B2C8AD64036DD9AA'
  }

    @@pulses= {
    'B2C8AD64036E94FD' => 'liveSynergy/demo-booth',
#    'B2C8AD64036DD7B5' => 'liveSynergy/demo-booth/fan',
    'B2C8AD64036E94FD' => 'liveSynergy/demo-booth/light',
    'B2C8AD64036DD7B5' => 'liveSynergy/demo-booth/lcd-monitor',
    'liveSynergy/demo-booth' => 'B2C8AD64036E94FD',
    'liveSynergy/demo-booth/fan' => 'B2C8AD64036DE5D9',
    'liveSynergy/demo-booth/light' => 'B2C8AD64036E94FD',
    'liveSynergy/demo-booth/lcd-monitor' => 'B2C8AD64036DD7B5'
  }

  def self.links
    @@links
  end
  
  def self.pulses
    @@pulses
  end
end
