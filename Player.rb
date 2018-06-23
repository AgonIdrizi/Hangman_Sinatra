class Player
  attr_accessor :arr_correct, :arr_incorect
  def initialize(wlength)
  	@arr_correct=["_"]*wlength
  	@arr_incorect=[]
  end


  def input_the_word(input,word)
  	if word.include?("#{input}")
  		 word.split("").each_with_index do |item,i|
  		   arr_correct[i] = input if input == item
  	   end
  		
  	else
  		arr_incorect << input
  	end
   end




  def count_words_remaining
    arr_correct.count {|item| item == "_"} - arr_incorect.length
  end

end