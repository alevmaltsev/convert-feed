require 'rss'

class AtomConverter
  def self.can_convert?(option)
    option == :atom
  end

  def self.convert(document)
    atom = RSS::Maker.make('atom') do |maker|
      maker.channel.link = document[:link]
      maker.channel.title = document[:title]
      maker.channel.updated = Time.now.to_s
      maker.channel.id = document[:link]
      maker.channel.description = '-'
      maker.channel.author = '-'
      document[:items].each do |el|
        maker.items.new_item do |item|
          item.title = el['title']
          item.link = el['link']
          item.updated = el['date']
          item.description = el['description']
        end
      end
    end
    puts 'Success converting to atom', atom
    File.open('output.atom', 'w') { |f| f.write(atom) }
    rescue StandardError => e
      puts 'AtomConverter', e
  end
end