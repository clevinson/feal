require 'sinatra'

get '/' do
  erb :index
end

get '/perlin' do
  noiseScale = params["scale"] || 300
  noiseDetail = params["spin"] || 2
  erb :perlin, :locals => {:noiseScale => noiseScale, :noiseSpin => noiseDetail}
end
