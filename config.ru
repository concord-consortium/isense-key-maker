require './make-keys'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '/isense-keys', :headers => :any, :methods => [:get, :post]
  end
end

run Sinatra::Application