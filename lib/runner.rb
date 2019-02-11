require_relative './converters/atom_converter'
require_relative './converters/rss_converter'
require_relative './parsers/atom_parser'
require_relative './parsers/rss_parser'
require_relative './readers/file_reader'
require_relative './readers/url_reader'
require_relative './data_modifier'

READERS = [FileReader, UrlReader]
PARSERS = [RssParser, AtomParser]
CONVERTERS = [RssConverter, AtomConverter]

module Runner
  def self.start(options, source)
    reader = READERS.find{ |reader| reader.can_read?(source) }
    feed = reader.nil? ? raise : reader.read(source)
    parser = PARSERS.find{ |parser| parser.can_parse?(feed) }
    data = parser.nil? ? raise : parser.parse(feed)
    # updateData = DataModifier.nil?(options[:modifier]) ? data : options[:modifier].keys.each { |opt| puts opt.to_s }
    converter = CONVERTERS.find{ |converter| converter.can_convert?(options[:output]) }
    converter.convert(data)
  rescue StandardError => e 
    puts 'Runner', e
  end
end