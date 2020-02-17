require 'json'
require 'open-uri'
require 'pry-byebug'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].tr('[]"', '')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    data = JSON.load(open(url).read)
    @found = data['found']
    @check = @word.upcase.chars.all? { |l| @word.upcase.count(l) <= @letters.count(l) }
    if !@found
      @response = "Sorry but #{@word.upcase} doesn't seem to be a valid English word"
    elsif !@check
      @response = "Sorry but #{@word.upcase} can't be built out of #{@letters}"
    else
      @response = "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end
end
