require 'open-uri'

class GamesController < ApplicationController
  def new

    @letters = [*'a'..'z'].sample(10)
  end
  def score
    @answer = params[:letters].upcase()
    @score = params[:word]
    @letters = params[:letters].split(' ')
    if letter_check(@score, @letters) && english_word(@score)
      @result = "Congratulations #{@score} is a valid English word"
    elsif english_word(@score)
      @result = "Sorry but #{@score} can't be built from #{@answer}"
    else
      @result = 'The word does not exists'
    end
  end

  def letter_check(score, letters)
  attempt_array = score.split('')
  grid_modified = []
  attempt_array.each { |e| grid_modified << e && letters.delete_at(letters.index(e)) if letters.include? e }
  grid_modified == attempt_array
  end
  def english_word(word)
    response = open(URI.parse("https://wagon-dictionary.herokuapp.com/#{word}"))
    json = JSON.parse(response.read)
    json['found']
  end
  end
