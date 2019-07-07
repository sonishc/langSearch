class SearchService < ApplicationService
  attr_reader :query, :data

  def initialize(query = '', data)
    @query = query.to_s
    @data = data
  end

  def find
    return nil if @query == ''
    search
  end

  private

  def search
    content = @data.split("},")
    content[0] = ''
    content[-1] = content.last[0..-4]
    query_validation.length.times do |index|
      content.select! { |c| /#{query_validation[index]}/i.match?(c) }
    end
    result_of_search = exclude_validation(content)
    return [{ 'text_message': 'Not found' }] if result_of_search.empty?
    json_string = result_of_search.size > 1 ? "[" + result_of_search.join("},") + "}]" : "[" + result_of_search.join() + "}]"
    JSON.parse(json_string)
  end

  def query_validation
    @query.split(' ')
  end

  def test(query, content)
    result_of_search = []
    query.length.times do |index|
      content.reject! { |c| /#{query[index]}/i.match?(c) }
    end
    content
  end

  def exclude_validation(search_values)
    words = @query.split(' ').select { |w| w[0] == '-' }
    words = words.join(" ").gsub("-", "").split(" ")
    return search_values if words.size == 0
    words.length.times do |index|
      search_values = search_values.reject { |c| /#{words[index]}/i.match?(c) } 
    end
    search_values
  end
end
