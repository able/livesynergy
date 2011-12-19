class EnergyController < ApplicationController
  protect_from_forgery
  def light
  end
  
  def fandata
    hour_data2('liveSynergy/demo-booth/fan')
  end                                    
  def lcdmonitordata                        
    hour_data2('liveSynergy/demo-booth/lcd-monitor' )
  end                                    
  def lightdata                              
    hour_data2('liveSynergy/demo-booth/light' )
  end                                    
  def demoboothdata                          
    hour_data3('liveSynergy/demo-booth' )
  end  
  
  def hour_data2(uri)
    livePulseID = Entity.pulses[uri]
    data = Array.new
    max = DateTime.now.to_f
    min = max - 3600
    legend_hash = Array.new
    arr = Energy.where(
      :livePulseID => livePulseID, 
      :timestamp.lte => max, 
      :timestamp.gte =>min).order_by([:timestamp, :desc]).to_a
      
    legend_hash << uri
    new_arr = []
    arr.map.with_index do |item, index|
      a = Hash.new
      a['index'] = index
      a['timestamp'] = item['timestamp']
      a['average_power'] = item['average_power']
      new_arr << a 
    end
    data << new_arr
    energy_data = Hash.new
    energy_data['data'] = data
    energy_data['legend'] = legend_hash
    print energy_data
    render :json => energy_data
    return
  end
  
 
  def hour_data3(uri)
    data = Array.new
    max = DateTime.now.to_f
    min = max - 3600

    legend_hash = Array.new
    children = ['liveSynergy/demo-booth/lcd-monitor', 'liveSynergy/demo-booth/light']
    children.each.with_index do |child, i|
      livePulseID = Entity.pulses[child]
      arr = Energy.where(:livePulseID => livePulseID, :timestamp.lte => max, :timestamp.gte =>min).order_by([:timestamp, :desc]).to_a
      new_arr = []
      arr.map.with_index do |item, index|
        a = Hash.new
        a['index'] = index
        a['timestamp'] = item['timestamp']
        a['average_power'] = item['average_power']
        new_arr << a
      end
      legend_hash << child
      data << new_arr
    end
    energy_data = Hash.new
    energy_data['data'] = data
    energy_data['legend'] = legend_hash
    render :json => energy_data
    return
  end
  def hour_data(uri)
    max = DateTime.now.to_f
    min = max - 3600 

    data = [] 
    legend_hash = Array.new 

    ent = Entity.where(:uri => uri)[0]
    print ent
    print ent.type

    if ent.type == 'thing'
      print 'it is a thing'
      livePulseID = ent.livePulseID
      arr = Energy.where(
        :livePulseID => livePulseID, 
        :timestamp.lte => max, 
        :timestamp.gte =>min).order_by([:timestamp, :desc]).to_a
        
      legend_hash[0] = ent.name 
      new_arr = []
      arr.map.with_index do |item, index|
        a = Hash.new
        a['index'] = index
        a['timestamp'] = item['timestamp']
        a['average_power'] = item['average_power']
        new_arr << a 
      end
      data << new_arr
      energy_data = Hash.new
      energy_data['data'] = data
      energy_data['legend'] = legend_hash
      print energy_data
      render :json => energy_data
      return 
    end
  

    children = ['liveSynergy/demo-booth/fan','liveSynergy/demo-booth/lcd-monitor','liveSynergy/demo-booth/light']
    children.each.with_index do |child, i|
      livePulseID = Entity.where(:uri => child)[0].livePulseID
      arr = Energy.where(:livePulseID => livePulseID, :timestamp.lte => max, :timestamp.gte =>min).order_by([:timestamp, :desc]).to_a
      new_arr = []
      arr.map.with_index do |item, index|
        a = Hash.new
        a['index'] = index
        a['timestamp'] = item['timestamp']
        a['average_power'] = item['average_power']
        new_arr << a
      end
      legend_hash << child
      data << new_arr

    end
    energy_data = Hash.new
    energy_data['data'] = data
    energy_data['legend'] = legend_hash
    render :json => energy_data
  end
end

