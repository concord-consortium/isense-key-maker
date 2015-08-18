require 'sinatra'
require 'json'
require 'rest-client'

project_list_response =
  RestClient.get ENV['ISENSE_PROJECTS_URL']

project_list = JSON.parse project_list_response.to_str

get '/' do
  body project_list.to_json
end

post '/' do
  request.body.rewind
  request_payload = JSON.parse request.body.read

  # RestClient.post "http://example.com/resource", { 'x' => 1 }.to_json, :content_type => :json, :accept => :json

  add_key_data = {
  	email: ENV['ISENSE_EMAIL'],
  	password: ENV['ISENSE_PASSWORD'],
  	contrib_key: request_payload
  }

  project_list.each{|project|
  	begin
	  add_key_response =
        RestClient.post "https://isenseproject.org/api/v1/projects/#{project['id']}/add_key",
          add_key_data.to_json, :content_type => :json, :accept => :json
      puts add_key_response
    rescue RestClient::Exception => e
      puts e.response
    end
  }

  body request_payload.to_json
end