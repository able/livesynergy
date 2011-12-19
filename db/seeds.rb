# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# booth = Entity.create(
#   :name => 'booth', 
#   :livePulseID => 'A', 
#   :uri => 'liveSynergy/demo-booth', 
#   :type => 'space')
# 
# light = Entity.create(
#   :name => 'light', 
#   :livePulseID => 'B', 
#   :uri => 'liveSynergy/demo-booth/light', 
#   :type => 'thing')
#   
# fan = Entity.create(
#   :name => 'fan', 
#   :livePulseID => 'C', 
#   :uri => 'liveSynergy/demo-booth/fan', 
#   :type => 'thing')
#   
# lcd = Entity.create(
#   :name => 'lcd-monitor', 
#   :livePulseID => 'D', 
#   :uri => 'liveSynergy/demo-booth/lcd-monitor', 
#   :type => 'thing')
#   
#   
=begin
  require 'net/http'
  @host = "db3.notify.live.net"
  @port = "80"
  @path = "/throttledthirdparty/01.00/AAGFzyJYtgeDSo8RF_n78WS9AgAAAAADCgAAAAQUZm52OjVDMTJBMjhFQzM0MzgyOUM"
  param1 = 'entering zone'
  param2 = 'test'
  param3 = "/Pages/ViewObject.xaml?selectedItem=" + "test"
  @body = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<wp:Notification xmlns:wp=\"WPNotification\">" + "<wp:Toast>" + "<wp:Text1>" + param1 + "</wp:Text1>" + "<wp:Text2>" + param2 + "</wp:Text2>" + 
  "<wp:Param>" + param3 + "</wp:Param>" + "</wp:Toast> " + "</wp:Notification>"
  @body = @body.encode( "euc-CN" )
  print @body.length.to_s()

  request = Net::HTTP::Post.new(@path, initheader = {'content-length'=> @body.length.to_s(), 'content-type' => 'text/xml',"X-WindowsPhone-Target" => "toast", "X-NotificationClass"=> "2"})
  request.body = @body
  response = Net::HTTP.new(@host).start {|http| http.request(request) }
  print response
  print "Response #{response.code} #{response.message}: #{response.body}"
  status = response.body
=end

Trigger.create(
      :name => 'numOccupancyReaches3turnLampOn',
      :description => 'when there are three people in this space, turn on lamp!',
      :triggering_entity => 'liveSynergy/demo-booth',
      :triggering =>
          {
            :name => 'numOccupancyReachesX',
            :args => 3
          },
      :triggered_entity => 'liveSynergy/demo-booth/fan',
      :triggered =>
          {
            :name => 'turnOn',
            :args => ''
          }
)


Trigger.create(
      :name => 'powerGreaterThanXtoggleFlashlight',
      :description => 'please flash the light if the power of the lcd monitor exceeds 5 to warn me.',
      :triggering_entity => 'liveSynergy/demo-booth/lcd-monitor',
      :triggering =>
          {
            :name => 'powerGreaterThanX',
            :args => 55 
          },
      :triggered_entity => 'liveSynergy/demo-booth/light',
      :triggered =>
          {
            :name => 'toggle',
            :args => ''
          }
)


Trigger.create(
      :name => 'powerGreaterThanXnotifyMe',
      :description => 'please send me a notification if the power of the lcd monitor exceeds 10 to warn me.',
      :triggering_entity => 'liveSynergy/demo-booth/lcd-monitor',
      :triggering =>
          {
            :name => 'powerGreaterThanX',
            :args => 55 
          },
      :triggered_entity => 'liveSynergy/demo-booth/messenger',
      :triggered =>
          {
            :name => 'notifyMe',
            :args => 'the lcd monitor is taking too much energy.'
          }
)
Trigger.create(
      :name => 'powerSmallerThanXturnoffLight',
      :description => 'turn off the light if the lcd-monitor is using less than 3 watts of energy.',
      :triggering_entity => 'liveSynergy/demo-booth/lcd-monitor',
      :triggering =>
          {
            :name => 'powerLessThanX',
            :args => 30
          },
      :triggered_entity => 'liveSynergy/demo-booth/light',
      :triggered =>
          {
            :name => 'turnOff',
            :args => ''
          }
)
=begin
require 'net/http'
def send_message(message)
    print 'in notifyME'
    @host = "db3.notify.live.net"
    @port = "80"
    @path = "/throttledthirdparty/01.00/AAG4FY92Rc9BQqJK_7ZMaAl5AgAAAAADAQAAAAQUZm52OjVDMTJBMjhFQzM0MzgyOUM"
    param1 = 'entering zone'
    param2 = message
    uri = "^msra^demo-booth^lcd-monitor"
    param3 = "/Pages/ViewObject.xaml?selectedItem=" + uri
    @body = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<wp:Notification xmlns:wp=\"WPNotification\">" + "<wp:Toast>" + "<wp:Text1>" + param1 + "</wp:Text1>" + "<wp:Text2>" + param2 + "</wp:Text2>" +
"<wp:Param>" + param3 + "</wp:Param>" + "</wp:Toast> " + "</wp:Notification>"
    # @body = @body.encode( "euc-CN" )
    print @body.length.to_s()

    request = Net::HTTP::Post.new(@path, initheader = {'content-length'=> @body.length.to_s(), 'content-type' => 'text/xml',"X-WindowsPhone-Target" => "toast", "X-NotificationClass"=> "2"})
    request.body = @body
    response = Net::HTTP.new(@host).start {|http| http.request(request) }
    print response
    print "Response #{response.code} #{response.message}: #{response.body}"
    status = response.body
end
send_message('hello')
=end
