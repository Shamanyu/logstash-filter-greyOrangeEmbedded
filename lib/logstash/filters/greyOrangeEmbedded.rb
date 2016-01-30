# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::GreyOrangeEmbedded < LogStash::Filters::Base
  config_name "greyOrangeEmbedded"
  config :keys, :validate => :string
  
  public
  def register
  end

  public
  def filter(event)
	if event["keys"].is_a?(String)
        	field_array = event["keys"].split("|")
		$array_length=field_array.length
		$counter=0
		while $counter < $array_length do
			custom_event=LogStash::Event.new()
        		field_value=field_array[$counter].split(":")
			custom_event["host"]=event["tags[0]"]
			custom_event["tagfield"]="key".concat(($counter+1).to_s)
			custom_event["service"]="butler_embedded"
			custom_event["unixTime"]=event["unixTime"]
			custom_event["severity"]=event["severity"]
        		custom_event["attribute"]=field_value[0]
       	 		custom_event["metric"]=field_value[1]
        		$counter += 1
			filter_matched(custom_event)
        		yield custom_event
    		end
	end
     	event.cancel
  end
end
