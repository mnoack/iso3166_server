$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

require 'sinatra'
require 'active_record'
require 'db/connect'
require 'country'
require 'subdivision'

get '/countries' do
  res = Hash[Country.from_cache.map{ |c| [c.code, c.name] }]
  [200, {"Content-Type" => "application/json"}, [res.to_json]]
end

get '/subdivisions/:name' do |name|
  subdivisions = Subdivision.where([ 'LOWER(name) LIKE ?', name + '%' ]).limit(15)
  res = Hash[subdivisions.map{ |s| [s.code, s.name] }]
  [
    200,
    {'Content-Type' => 'application/json', 'Access-Control-Allow-Origin' => '*'},
    [res.to_json]
  ]
end
