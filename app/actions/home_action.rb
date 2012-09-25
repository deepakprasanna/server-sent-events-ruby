require 'rexml/document'
require 'net/http' 
require 'pp'

class HomeAction < Cramp::Action
  self.transport = :sse

  on_start :send_latest_time
  periodic_timer :send_latest_time, :every => 3

  def send_latest_time
    #url = "http://localhost:6500/current"  
    #xml_data = Net::HTTP.get_response(URI.parse(url)).body 
    #xml_data = REXML::Document.new(xml_data)
    #xml_data.each_element("//Samples/*") do |sample|
      #render "deepak" 
    #end 
    render "<b>deepak</b>" 
  end 
end
