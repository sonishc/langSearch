class SearchService < ApplicationService
  attr_reader :query, :data

  def initialize(query, data)
    @query = query.to_s
    @data = data
  end

  def find
    return nil if @query == ''

    search
  end

  private

  def search
    content = json_to_array(@data)
    search_words = query_validation(@query)
    search_words.length.times do |index|
      content.select! { |c| /#{search_words[index]}/i.match?(c) }
    end
    json_respond(exclude_validation(@query, content))
  end

  def json_respond(result)
    return [{ 'text_message': 'Not found' }] if result.empty?

    if result.size > 1
      JSON.parse("[" + result.join("},") + "}]")
    else
      JSON.parse("[" + result.join() + "}]")
    end
  end

  def json_to_array(json_file)
    array_file = json_file.split("},")
    array_file[0] = ''
    array_file[-1] = array_file.last[0..-4]
    array_file
  end

  def query_validation(query)
    query.split(' ')
  end

  def exclude_validation(query, search_values)
    words = query.split(' ').select { |w| w[0] == '-' }
    words = words.join(" ").gsub("-", "").split(" ")
    return search_values if words.size == 0
    words.length.times do |index|
      search_values = search_values.reject { |c| /#{words[index]}/i.match?(c) } 
    end
    search_values
  end
end
