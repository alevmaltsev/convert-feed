require 'active_support/core_ext/hash/conversions'
require 'rss'

module RssConverter
  def self.can_convert?(option)
    option == :rss
  end

  def self.convert(document)
    rss = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = document[:title]
      maker.channel.link = document[:link]
      maker.channel.description = document[:description]
      document[:items].each do |el|
        maker.items.new_item do |item|
          item.link = el['link']
          item.title = el['title']
          item.updated = el['date']
          item.description = el['description']
        end
      end
    end
    File.open('output.rss', 'w') { |file| file.write(rss) }
    rescue StandardError => e
      puts 'RssConverter', e
  end
end