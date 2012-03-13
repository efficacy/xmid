#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/xmin.db")  
  
class Creator  
  include DataMapper::Resource  
  property :id, Serial, :required => true, :key => true  
  property :token, Text, :required => true  
  property :name, Text, :required => true  
  property :email, Text, :required => true  
  property :password, Text, :required => true  
  property :created_at, DateTime  
end  

class Item
  include DataMapper::Resource  
  property :id, Serial, :required => true, :key => true    
  property :token, Text, :required => true  
  property :creator, Text, :required => true  
  property :created_at, DateTime  
end  
  
DataMapper.finalize.auto_upgrade!  

class App < Sinatra::Application
  get '/' do
    haml :index
  end

  get '/dump' do
    @creators = Creator.all :order => :id.desc  
    haml :dump
  end

  post '/login' do

  end

  post '/signup' do  
    c = Creator.new  
    c.token = 'xxx'  
    c.name = params[:name]  
    c.email = params[:email]  
    c.password = params[:password]  
    c.created_at = Time.now  
    c.save  
    redirect '/'  
  end
end
