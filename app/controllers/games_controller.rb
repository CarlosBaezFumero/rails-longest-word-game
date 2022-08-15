require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split(' ')
    @query = params[:query]
    uri = URI("https://wagon-dictionary.herokuapp.com/#{@query}")
    answer = JSON.parse(URI.open(uri).read)
    if @query.split(//).any? { |letter| !@letters.include?(letter) }
      @result_message = "Sorry but #{@query} can't be built out of #{@letters}"
    elsif answer['found'] == false
      @result_message = "Sorry but #{@query} does not seem to be a valid word"
    else
      @result_message = "Congratulations! #{@query} is a valid English word!"
    end
  end
end
