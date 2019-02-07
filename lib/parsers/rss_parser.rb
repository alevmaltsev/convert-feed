require 'active_support/all'

module RssParser
  def self.can_parse?(data)
    data.xpath('/rss').present? || data.xpath('/rdf').present?
  end

  def self.parse(data)
    items = []
    header = {
      title: data.xpath('//title').first.content,
      link: data.xpath('//link').first.content,
      description: data.xpath('//description').first.content,
    }
    data.xpath('//item').each { |el| items << el }
    items = items.map { |el| Hash.from_xml(el.to_s)['item'] }
    items.each { |el| el['date'] = el.delete('pubDate') }
    document = header.merge({ items: items })
  rescue StandardError => e
    puts 'RssParser', e
  end
end 