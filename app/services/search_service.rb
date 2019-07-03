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
    result_of_search = content.select { |c| /#{query_validation}/i.match?(c) }
    exclude_validation.length.times do |index|
      result_of_search = result_of_search.reject { |c| /#{exclude_validation[index]}/i.match?(c) } if exclude_validation.size > 0
    end
    return [{ 'text_message': 'Not found' }] if result_of_search.empty?
    json_string = result_of_search.size > 1 ? "[" + result_of_search.join("},") + "}]" : "[" + result_of_search.join() + "}]"
    JSON.parse(json_string)
  end

  def query_validation
    @query.match(/\w+/)
  end

  def exclude_validation
    words = @query.split(' ')
    words = words.select { |w| w[0] == '-' }
    words.join(" ").gsub("-", "").split(" ")
  end
end
