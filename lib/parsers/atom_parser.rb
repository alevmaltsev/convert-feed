module AtomParser
  def self.can_parse?(data)
    data.xpath('//xmlns:entry').present?
  end

  def self.parse(data)
    items = []
    header = {
      title: data.xpath('//xmlns:title').first.content,
      link: data.xpath('//xmlns:link').first['href'],
      description: '-',
    }
    data.xpath('//xmlns:entry').each { |el| items << el }
    items = items.map { |el| Hash.from_xml(el.to_s)['entry'] }
    items.each do |el| 
      el['date'] = el.delete('updated')
      el['description'] = el.delete('summary') 
      el['link'] = el['link']['href'] 
    end
    document = header.merge({ items: items })
  rescue StandardError => e
    puts 'AtomParser', e
  end
end