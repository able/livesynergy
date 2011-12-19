class EventsController < ApplicationController
  require 'json'
  
  # <p>numOccupancyReachesX ( int x )  </p>
  # <p>onHumanEnter ( User human )    </p>
  # <p>onHumanExit ( User human )   </p>
  # <p>powerGreaterThanX ( double x ) </p>
  # <p>powerLessThanX ( double x )    </p>

  def report
    if General.all.count == 0
      General.create(:occupancy => Array.new)
    end
    
    if params['event'] == 'energy'
      x = params['average_power']
      id = params['livePulseID']
      entity = Entity.pulses[id]
      
      print "-------------------------------------\n"
      print "Energy Consumption: " 
      print x
      print "\n-------------------------------------\n"

      @trigger = Trigger.where(:triggering_entity => entity, 'triggering.name' => 'powerGreaterThanX')
      @trigger1 = @trigger[0]
      if @trigger1
        if x.to_i > @trigger1['triggering']['args']['number-param-1'].to_i
          print @trigger1['triggered']['name']
          finishtrigger(@trigger1)
        end
      end 
      @trigger2 = @trigger[1]
      if @trigger2
        if x.to_i > @trigger2['triggering']['args']['number-param-1'].to_i
          finishtrigger(@trigger2)
        end
      end

      @trigger3 = @trigger[2]
      if @trigger3
        if x.to_i > @trigger3['triggering']['args']['number-param-1'].to_i
          finishtrigger(@trigger3)
        end
      end

      @trigger = Trigger.where(:triggering_entity => entity, 'triggering.name' => 'powerLessThanX')[0]
      if @trigger
        if x.to_i < @trigger['triggering']['args']['number-param-1'].to_i 
          finishtrigger(@trigger)
        end
      end

      render :json => {:status => 'success'}
      return
    end
    user = params['liveLinkID']

    if params['event'] == 'onHumanIn'
      if not General.all[0].occupancy.include?(params['liveLinkID'])  
        gen = General.all[0] 
        gen.occupancy << params['liveLinkID']
        gen.save
      end



      
      user = 'liveSynergy/demo-booth/user2'
      @trigger = Trigger.where( # :triggering_entity => params['entity-1'], 
        'triggering.name' => 'onHumanEnter', 'triggering.args.user-param-1' => user)[0]
      
      if @trigger
        finishtrigger(@trigger)
      end
      
      @trigger = Trigger.where( # :triggering_entity => params['entity-1'], 
        'triggering.name' => 'numOccupancyReachesX', 'triggering.args' => General.all[0].occupancy.length)[0]
      
      if @trigger
        finishtrigger(@trigger)
      end
      render :json => {:status => 'success'}
      return
    end
    
    if params['event'] == 'onHumanOut'
      if General.all[0].occupancy.include?(params['liveLinkID'])  
        gen = General.all[0]
        gen.occupancy.delete(params['liveLinkID'])
        gen.save
      end

      @trigger = Trigger.where( # :triggering_entity => params['entity-1'], 
        'triggering.name' => 'onHumanExit', 'triggering.args' => user)[0]
      
      if @trigger
        finishtrigger(@trigger)
      end
      
      @trigger = Trigger.where(
        # :triggering_entity => params['entity-1'], 
        'triggering.name' => 'numOccupancyReachesX', 'triggering.args' => General.all[0].occupancy.length)[0]
      if @trigger
        finishtrigger(@trigger)
      end
      
      render :json => {:status => 'success'}
      return
    end
    
  end
  
  def turn_on (pulse)
    print 'turning on'
    data = Hash.new
    data['livePulseID'] = pulse
    data['args'] = ''
    data['method'] = 'turnOn'
    @host = "0.0.0.0"
    @port = "8084"
    @path = "/"
    @body = ""
    request = Net::HTTP::Post.new(@path, initheader = {'Content-Type' =>'application/json'})
    request.body = data.to_json
    response = Net::HTTP.new(@host, @port).start {|http| http.request(request) }
    print "Response #{response.code} #{response.message}: #{response.body}"
    status = response.body
    if status[1,4] == 'FAIL'
      print 'FAIL'
    end
  end

  def turn_off (pulse)
    print 'turning off'
    data = Hash.new
    data['livePulseID'] = pulse
    data['args'] = ''
    data['method'] = 'turnOff'
    @host = "0.0.0.0"
    @port = "8084"
    @path = "/"
    @body = ""
    request = Net::HTTP::Post.new(@path, initheader = {'Content-Type' =>'application/json'})
    request.body = data.to_json
    response = Net::HTTP.new(@host, @port).start {|http| http.request(request) }
    print "Response #{response.code} #{response.message}: #{response.body}"
    status = response.body
    if status[1,4] == 'FAIL'
      print 'FAIL'
    end
  end

  def toggle (pulse)
    print 'toggling'
    data = Hash.new
    data['livePulseID'] = pulse
    data['args'] = ''
    data['method'] = 'toggle'
    @host = "0.0.0.0"
    @port = "8084"
    @path = "/"
    @body = ""
    request = Net::HTTP::Post.new(@path, initheader = {'Content-Type' =>'application/json'})
    request.body = data.to_json
    response = Net::HTTP.new(@host, @port).start {|http| http.request(request) }
    print "Response #{response.code} #{response.message}: #{response.body}"
    status = response.body
    if status[1,4] == 'FAIL'
      print 'FAIL'
    end
  end
 
  def finishtrigger(trigger)
    print "\nYO LOOK HERE TRIGGERS\n"
    print trigger.triggered['name']
      print "\n++++++++++++++++++++++++++++++++++++++\n"
    print trigger
      print "\n++++++++++++++++++++++++++++++++++++++\n"
    if trigger.triggered['name'] == 'turnOn'
      print "\n******************************************\n"
      print "\n******************************************\n"
      print "\n******************************************\n"
      print trigger['triggered_entity']
      print "\n******************************************\n"

      print Entity.pulses[trigger['triggered_entity']]
      print "---------------------------\n"
      turn_on(Entity.pulses[trigger['triggered_entity']])
    elsif trigger.triggered['name'] == 'turnOff'
      turn_off(Entity.pulses[trigger['triggered_entity']])
    elsif trigger.triggered['name'] == 'toggle'
      print trigger['triggered_entity']
      
      toggle(Entity.pulses[trigger['triggered_entity']])
    else
      print "\nsending message\n"
#      send_message(trigger['triggered']['args'])
      sendNotification("dsafsafjdsal")
    end
  end
  
  def sendNotification(message)
    param1 = 'High Energy Usage'
    param2 = 'LCD Monitor is using too much energy.'
    uri = "^msra^demo-booth^lcd-monitor"
    param3 = "/Pages/ViewObject.xaml?selectedItem=" + uri
    timestamp = "time: " + Time.now.utc.iso8601
    @body = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<wp:Notification xmlns:wp=\"WPNotification\">" + "<wp:Toast>" + "<wp:Text1>" + param1 + "</wp:Text1>" + "<wp:Text2>" + param2 + "</wp:Text2>" + "<wp:Param>" + param3 + "</wp:Param>" + "</wp:Toast> " + "</wp:Notification>"
    
    File.open('notify-message', 'w') do |fwrite|
      fwrite.puts timestamp
    end
  end

  def notification

    File.open('notify-message', 'r') do |fread|
      while line = fread.gets
        @content = line    
      end
    end
  end

  def send_message(message)
    # proxy_class = Net::HTTP::Proxy('jpnproxy.fareast.corp.microsoft', 80)
    # proxy_class.start('db3.notify.live.net') {|http|

    print "in notifyME\n"
 
   # Ben: just post this on one web address, using another server to fetch and execute, to avoid congestion and hanging-up

    @host = "127.0.0.1"
    @port = "8888"
    @path = "/msra/sms-gateway/methods/send"

    @user = "nihao"
    @body = {}
    @body['phone_number'] = "15120003948"
    @body['text'] = params[:entity][:text]

    print 'body'
    print @body
    request = Net::HTTP::Post.new(@path, initheader = {'Content-Type' =>'application/json'})
    request.body = @body.to_json
    response = Net::HTTP.new(@host, @port).start {|http| http.request(request) }
    print "Response #{response.code} #{response.message}: #{response.body}"
    status = response.body
#    if status[1,4] == 'FAIL'
#     redirect_to failure_actuation_path
#    end
#    redirect_to sms_sent_path

  if 0
    @host = "db3.notify.live.net"
    @port = "80"
    @path = "/throttledthirdparty/01.00/AAH2bnh3Qba-S6x69PxEJ9bNAgAAAAADFQAAAAQUZm52OjVDMTJBMjhFQzMzgyOUM"
    param1 = 'High Energy Usage'
    param2 = 'LCD Monitor is using too much energy.'

    uri = "^msra^demo-booth^lcd-monitor"
    param3 = "/Pages/ViewObject.xaml?selectedItem=" + uri
    @body = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<wp:Notification xmlns:wp=\"WPNotification\">" + "<wp:Toast>" + "<wp:Text1>" + param1 + "</wp:Text1>" + "<wp:Text2>" + param2 + "</wp:Text2>" + 
"<wp:Param>" + param3 + "</wp:Param>" + "</wp:Toast> " + "</wp:Notification>"
    @body = @body.encode( "euc-CN" )
    print @body.length.to_s()

    request = Net::HTTP::Post.new(@path, initheader = {'content-length'=> @body.length.to_s(), 'content-type' => 'text/xml',"X-WindowsPhone-Target" => "toast", "X-NotificationClass"=> "2"})
    request.body = @body
    response = Net::HTTP.new(@host).start {|http| http.request(request) }
    http.request(request)
	print response
	print "Response #{response.code} #{response.message}: #{response.body}"
	status = response.body    
	
    end
	#}
  end
  
end
