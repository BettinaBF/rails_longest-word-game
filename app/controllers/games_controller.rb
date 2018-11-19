require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:word].downcase
    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      if english_word?(@word)
        @answer = "Congrats ! #{@word.capitalize} is a valid English word!"
      else @answer = "Sorry but '#{@word.capitalize}' is not an english word"
      end
    else @answer = " Sorry but the letters in '#{@word}' aren't in the grid #{@letters}"
    end
  end
end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  json['found']
end
