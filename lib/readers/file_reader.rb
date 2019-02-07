require 'nokogiri'

module FileReader
  def self.can_read?(source)
    File.file?(source)
  end

  def self.read(source)
    File.open(source) { |f| Nokogiri::XML(f) }
  rescue StandardError => e
    puts  'StandardError', e
  end
end