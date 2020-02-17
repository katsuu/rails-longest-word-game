require 'json'
require 'open-uri'
require 'pry-byebug'
require 'time'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @start_time = Time.now
  end

  def score
    @word = params[:word]
    @letters = params[:letters].tr('[]"', '')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    data = JSON.load(open(url).read)
    found = data['found']
    check = @word.upcase.chars.all? { |l| @word.upcase.count(l) <= @letters.count(l) }
    @response = message(found, check)

    start_time = Time.parse(params[:start_time])
    end_time = Time.now
    @final_score = compute_score(@word, end_time - start_time, found, check)
    if session[:score].present?
      session[:score] += @final_score
    else
      session[:score] = @final_score
    end
    @total_score = session[:score]
  end

  def reset_score
    session[:score] = nil
    redirect_to :new
  end

  private

  def message(found, check)
    if !found
      "Sorry but #{@word.upcase} doesn't seem to be a valid English word"
    elsif !check
      "Sorry but #{@word.upcase} can't be built out of #{@letters}"
    else
      "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end

  def compute_score(word, time_taken, found, check)
    if found && check
      time_taken > 60.0 ? 0 : word.length * (1 - time_taken / 60.0)
    else
      0
    end
  end
end
