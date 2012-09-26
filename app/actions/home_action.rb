require 'rexml/document'
require 'net/http'
require 'singleton'

class Sample
  include Singleton
  include REXML

  URL = "http://localhost:6500/sample"
  def fetch
    Net::HTTP.get_response(URI.parse(URL)).body 
  end

  def xml
    REXML::Document.new(fetch)
  end

  def interested_items
    XPath.match(xml, "//ComponentStream[@component='Linear']/Samples/*") 
  end
end

class HomeAction < Cramp::Action
  self.transport = :sse

  on_start :send_latest_time
  periodic_timer :send_latest_time, :every => 3

  def send_latest_time 
    raw = "data: \n"
    Sample.instance.interested_items.each do |sample|
      raw << "#{sample.attributes['name']} - #{sample.text} <br />"
    end 
    raw << "\n\n"
    render raw
  end 
end
