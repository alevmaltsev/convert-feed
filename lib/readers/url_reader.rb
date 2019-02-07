require 'open-uri'
require 'nokogiri'

module UrlReader
  def self.can_read?(source)
    open(source).status == %w(200 OK)
  rescue
    false
  end

  def self.read(source)
    Nokogiri::XML(open(source))
  rescue StandardError => e
    puts 'UrlReader', e
  end
end