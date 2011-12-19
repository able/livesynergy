class VisualizationsController < ApplicationController
  def menu
    
  end
  
  def pulse_data
    render :json => {:data => {}}
  end
  
end