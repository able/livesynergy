class ZonesController < ApplicationController
  def data
    hash = {
    'B2C8AD64036DDB7E' => :link1,
    'B2C8AD64036DC478' => :link2
    # 'B2C8AD64036DD9AA' => :link3

	}

    # reading = Zone.order_by([:timestamp, :desc]).limit(1)[0]
    render :json => {:data => 
		{  :link1 => Actor.order_by([:timestamp, :desc]).limit(1)[0] ,
		 :link2 => Boy.order_by([:timestamp, :desc]).limit(1)[0] ,
		 :link3 => Cow.order_by([:timestamp, :desc]).limit(1)[0]  } }
    
  end
end
