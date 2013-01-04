require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/dev.db")

class Item
	include DataMapper::Resource

	property :id, Serial
	property :title, String
	property :quantity, Integer
	property :notes, Text
end

DataMapper.auto_upgrade!

get '/' do 
	erb :index
end

post '/' do
	@item = Item.new(:title => params[:new_item], :quantity => params[:quantity], :notes => params[:notes])
	@item.save
	redirect to('/')
end
