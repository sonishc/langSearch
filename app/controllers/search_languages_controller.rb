require 'json'

class SearchLanguagesController < ApplicationController
  def index
    languages = SearchService.new(params[:query], read_file).find

    @data = languages.nil? ? [{ 'text_message': 'Empty' }] : languages

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def read_file
    File.read(File.join(File.expand_path(Rails.root), "/public/data.json"))
  end
end
