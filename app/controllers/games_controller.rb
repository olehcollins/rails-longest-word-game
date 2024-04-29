class GamesController < ApplicationController
  before_action :set_word, :valid_word?, :find_word
  skip_before_action :verify_authenticity_token, only: [:score]
  require 'net/http'
  require 'json'

  def new
  end

  def score
    if !@valid_word
      @message = 1
    elsif @found
      @message = 2
    else
    end
  end

  private

  def set_word
    @word = params[:word]
    @letters = ['y', 'z', 'd', 'u', 'q', 'e', 'z', 'y', 'q', 'i', 'n']
  end

  def valid_word?
    @valid_word = @word.chars.all? { |char| @letters.include?(char) } if @word
  end

  def find_word
    if valid_word?
      uri = URI("https://wagon-dictionary.herokuapp.com/#{@word}")
      response = Net::HTTP.get(uri)

      # Parse the JSON response
      result = JSON.parse(response)
      @found = result['found']
    end
  end
end
