require 'active_resource'

class CrmBase < ActiveResource::Base
    
  self.site = ENV['SITE']
  #self.user = ENV['USER']
  #self.password = ENV['PASS']
  self.format = :json
  self.include_root_in_json = true 
  
  def self.remote_new options={}
    new(get("new").merge(options.merge(format: :json)))
  end
  
  
  #API KEY Auth for ActiveResscource
  class << self
    def headers
      @headers ||= {}
      @headers['X-apikey'] = ENV['APIKEY']
      @headers
    end
  end
  
end