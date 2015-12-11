# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# This example filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::GreyOrangeEmbedded < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "greyOrangeEmbedded"
  
  # Replace the message with this value.
  config :keys
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)
    if @keys
      # Replace the event message with our message as configured in the
      # config file.
     	event["keys"] = @keys
	field_array = event["keys"].split("|")
	$array_length=field_array.length
	$counter=0
	while $counter < $array_length do
		custom_event=LogStash::Event.new()
                field_value=field_array[$counter].split(":")
                custom_event["unixTime"]=%{unixTime}
                custom_event["severity"]=%{severity}
                custom_event["attribute"]=field_value[0]
                custom_event["metric"]=field_value[1]
                $counter += 1
                yield custom_event
    	end
     end
     filtered_match(event)
     #Cancel the main event
     #event.cancel
  end # def filter
end # class LogStash::Filters::GreyOrangeEmbedded
