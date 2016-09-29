class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :wrong_guesses, :guesses

  def initialize(word)
    @word = word
    @guesses=''
    @wrong_guesses=''
  end

  def guess(char)
    if char.nil?||char.empty?||(char=~/[a-z]/i).nil?
      raise ArgumentError
    end
    char=char.downcase
    if @wrong_guesses.include?(char)||@guesses.include?(char)
      return false
    end
    if @word.include? char
      @guesses+=char
    else
      @wrong_guesses+=char
    end
    true

  end

  def word_with_guesses
    @word.chars.map { |c| @guesses.include?(c)? c : '-'}.join('')
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length>=7
    return :win if !@guesses.empty?&&@word==word_with_guesses
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
