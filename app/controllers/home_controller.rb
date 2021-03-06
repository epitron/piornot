class HomeController < ApplicationController

  def index
    amount = case params[:difficulty]
      when "easy"
        100
      when "medium"
        50
      when "hard"
        20
      when "nightmare"
        2
      else
        100
    end

    u = current_user

    if params[:reset]
      u.guesses.destroy_all
    end

    if guess = params[:guess]
      @correct = ( guess.to_i == session[:correct_guess] )
      u.guesses.create(correct: @correct)
    end

    @score, @total, @percent = u.stats

    # Load the digits
    @data = [some_pi(amount), some_random(amount)]

    # Which hand is the pi in?
    @data = @data.reverse if ( session[:correct_guess] = rand 0..1 ) > 0
  end

private

  def random_read(filename, amount, starting_at=0)
    open(filename, "rb") do |f|
      pos = rand starting_at .. f.size-amount
      f.seek pos
      f.read amount
    end
  end

  def some_pi(amount)
    random_read("data/pi-billion.txt", amount, 2).tap do |data|
      logger.info "pi: #{data}"
    end
  end

  def some_random(amount)
    random_read(Dir["data/random/*.digits"].sample, amount).tap do |data|
      logger.info "random: #{data}"
    end
  end

  def some_pseudorandom(amount)
    data = (0...amount).map{ rand(0..9) }.join('').tap do |data|
      logger.info "pseudorandom: #{data}"
    end
  end

end
