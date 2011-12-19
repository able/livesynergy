
@host = "http://db3.notify.live.net"
@port = "80"
@path = "/throttledthirdparty/01.00/AAGFzyJYtgeDSo8RF_n78WS9AgAAAAADCgAAAAQUZm52OjVDMTJBMjhFQzM0MzgyOUM"
param1 = 'entering zone'
param2 = 'test'
param3 = "/Pages/ViewObject.xaml?selectedItem=" + "test"
@body = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<wp:Notification xmlns:wp=\"WPNotification\">" + "<wp:Toast>" + "<wp:Text1>" + param1 + "</wp:Text1>" + "<wp:Text2>" + param2 + "</wp:Text2>" + 
"<wp:Param>" + param3 + "</wp:Param>" + "</wp:Toast> " + "</wp:Notification>"
@body = @body.encode( "euccn" )


request = Net::HTTP::Post.new(@path, initheader = {'content-length'=> @body.length.to_s(), 'content-type' => 'text/xml',"X-WindowsPhone-Target" => "toast", "X-NotificationClass"=> "2"})
request.body = @body
response = Net::HTTP.new(@host, @port).start {|http| http.request(request) }
print response
print "Response #{response.code} #{response.message}: #{response.body}"
status = response.body

