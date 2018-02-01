class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================
    def count_subs(string, substring)
      string.scan(/(?=#{substring})/).count
    end

    @word_count = @text.split(" ").count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @occurrences = count_subs(@text.downcase,@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@apr/1200*@principal)/(1-((1+@apr/1200)**(-12*@years)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = (@ending-@starting)/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    if @sorted_numbers.count.odd?
      @median = @sorted_numbers[@count/2]
    else
      @median = (@sorted_numbers[@count/2]+@sorted_numbers[@count/2]-1)/2
    end

    running_total = 0
    @numbers.each do |current|
      running_total += current
    end
    @sum = running_total

    @mean = @sum/@count

    sq_differences = []
    @numbers.each do |current|
      sq_differences.push((current-@mean)**2)
    end

    sum_of_squares = 0
    sq_differences.each do |current|
      sum_of_squares += current
    end
    @variance = sum_of_squares/@count

    @standard_deviation = (@variance**0.5)

    mode_count = 0
    temp_mode = 0
    @numbers.each do |current|
      if @numbers.count(current) > mode_count
        mode_count = @numbers.count(current)
        temp_mode = current
      end
    end
    @mode = temp_mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

