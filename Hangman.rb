require "./Player.rb"
#require 'yaml'
require 'sinatra'
#require 'sinatra/reloader' if development?

class Hangman
  	attr_accessor :choosen_word, :player
 def initialize
   @choosen_word = rand_word_select
   @player = Player.new(choosen_word.length)
   @message =''
 end

 def play(input)
   
     @player.input_the_word(input,choosen_word)
   	  	 
 end

  

  def rand_word_select
	  str = []
	  word =""
	  f = File.open("5desk.txt","r")
	  str = f.readlines
	  f.close
	  until (word.size >=5 && word.size <= 12) do
   	  word = str[rand(0..str.length)].strip.downcase
    end
   word
  end

  def game_win
  	if @choosen_word == @player.arr_correct.join  
   return true
  	else 
  	  false
  	end
  end

end

hangman = Hangman.new


get "/" do
  message = ''
  hangman.play(params['letter'])
  word = hangman.choosen_word
  correct = hangman.player.arr_correct.join(" ")
  
  incorrect = hangman.player.arr_incorect.join(" ")
  count = hangman.player.count_words_remaining

 if count == 0 && correct.include?("_")
   message = "Game is over, correct word is #{word}"
   hangman = Hangman.new
 elsif count >=0 && !correct.include?("_")
   message = "You guessed right"
   hangman = Hangman.new
 end


erb :index, :locals => {:message => message,:word => word, :correct => correct.upcase, :incorrect => incorrect.upcase, :count => count}
end

post '/runMethod' do
  hangman = Hangman.new
  redirect '/'
end

