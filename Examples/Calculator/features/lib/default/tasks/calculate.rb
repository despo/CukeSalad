module Calculate

  def perform_task
    enter_numbers_and_operators_in_turn
  end

  private
  def enter_numbers_and_operators_in_turn
    operator = {"+" => :plus, "-" => :minus, "=" => :equals}
    tokens.each do | token |
      enter token.to_i if token =~ /\d+/
      press operator[token] if operator.include? token
    end
  end

  def tokens
    value_of( :with_the_following ).split(" ")
  end
end