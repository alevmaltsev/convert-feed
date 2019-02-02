require 'open-uri'
require 'nokogiri'

class Reader
  def self.read_file source
    File.open(source) { |f| Nokogiri::XML(f) }
  end
  
  def self.read_uri uri
    Nokogiri::XML(open(uri))
  end
end