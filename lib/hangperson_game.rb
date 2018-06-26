class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_reader :word
  attr_reader :guesses
  attr_reader :wrong_guesses
  def initialize(word)
    @word = word
    @wrong_guesses = ""
    @guesses = ""
  end

  def guess character
    #valid = @word.include?(character)
	  raise ArgumentError.new("debe indicar un caracter") if !(character =~ /[[:graph:]]/i) or !(character =~ /[[:alpha:]]/i ) or character.nil?
    valid = @word =~ /#{character}/i

    change = false 
     if valid
       #unless @guesses.include?(character)
       unless @guesses =~ /#{character}/i
	 puts "GUESS valida: se agrega la letra #{character} a #{@guesses}"
         @guesses << character
	 change = true
       else
	 puts "GUESS valida:  pero no se agrega la letra #{character} a #{@guesses}"
       end
    else
      #unless @wrong_guesses.include?(character) 
      unless @wrong_guesses =~ /#{character}/i 
	 puts "wroNG GUESS invalida: se agrega la letra #{character} a #{@wrong_guesses}"
        @wrong_guesses << character 
	change = true
       else
	 puts "WRONG GUESSES invalida:  pero no se agrega la letra #{character} a #{@wrong_guesses}"
      end
    end
     puts "GUESS: change #{change}"
    change
  end

  def word_with_guesses
    #result = word.tr("^#{@guesses}","-")
    #result == word ? "-"*(word.size) : result
    temp = ""
    word.chars.each do |character|
      #puts "temp: #{temp}, character: #{character}"
      temp << (@guesses =~ /#{character}/i ? character : "-")
    end
    temp
  end

  def check_win_or_lose
    return :lose if wrong_guesses.size > 6
    return :win if word_with_guesses == word
    :play
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
