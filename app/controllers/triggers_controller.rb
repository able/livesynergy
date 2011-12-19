class TriggersController < ApplicationController
  def all
    @triggers = Trigger.all
  end
  
  def menu
    print '#{Rails.root}/public/fonts/dS-oM09uC7agWFnFSCUGievvDin1pK8aKteLpeZ5c0A.woff'
  end
  
  def create
    arg1 = ""
    arg2 = ""
   
		if params['event-1'] == "onHumanEnter"     
		  arg1 = params['user-param-1']   
		end
		if params['event-1'] == "onHumanExit"
		  arg1 = params['user-param-1']
		end
		if params['event-1'] == "powerGreaterThanX"
		  arg1 = params['number-param-1']
		end
		if params['event-1'] == "powerLessThanX"      
		  arg1 = params['number-param-1']
		end
		if params['event-1'] == "numOccupancyReachesX"
		  arg1 = params['number-param-1']
		end
		
    Trigger.create( 
      :name => params['name'],
      :description => params['description'],
      :triggering_entity => params['entity-1'],
      :triggering => 
          {
            :name => params['event-1'], 
            :args => {'user-param-1' => params['user-param-1'], 'number-param-1' => params['number-param-1']}
          },
      :triggered_entity => params['entity-2'],
      :triggered => 
          {
            :name => params['method-2'], 
            :args => {'message-param-2' => params['message-param-2']}
          })
    
    # {"entity-1"=>"choose-one", "event-1"=>"choose-one", "number-param-1"=>"", 
      # "user-param-1"=>"choose-one", "entity-2"=>"choose-one", "method-2"=>"choose-one", "message-param-2"=>""}
      
    redirect_to '/triggers'
  end
 
  def view
    @trigger = Trigger.find(params[:id])
    params = @trigger.triggering["args"]

    @arg1 = @trigger.triggering["args"].to_s
    @arg2 = @trigger.triggered["args"].to_s
    #     if @trigger.triggering["name"] == "onHumanEnter"     
    #   @arg1 = params['user-param-1']   
    # end
    # if @trigger.triggering["name"] == "onHumanExit"
    #   @arg1 = params['user-param-1']
    # end
    # if @trigger.triggering["name"] == "powerGreaterThanX"
    #   @arg1 = params['number-param-1']
    # end
    # if @trigger.triggering["name"] == "powerLessThanX"      
    #   @arg1 = params['number-param-1']
    # end
    # if @trigger.triggering["name"] == "numOccupancyReachesX"
    #   @arg1 = params['number-param-1']
    # end
		    # 
		    # @arg2 = ""
		    # if @trigger.triggered["name"] == "send"
		    #   @arg1 = params['message-param-2']
		    # end
  end
  
  def delete
    @trigger = Trigger.find(params[:id])
    @trigger.delete
  end
  
  def report
    @trigger = Trigger.where(:triggering_entity => params['entity-1'], 'triggering.name' => params['event-1'])
  end
end
