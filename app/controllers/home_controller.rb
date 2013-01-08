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
        1
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

    @data = [some_pi(amount), some_random(amount)]
    @data = @data.reverse if ( session[:correct_guess] = rand 0..1 ) > 0
  end

private

  def random_read(filename, amount)
    open(filename, "rb") do |f|
      pos = rand(0..f.size - amount)
      f.seek(pos)
      f.read(amount)
    end
  end    

  def some_pi(amount)
    random_read("data/pi-billion.txt", amount).tap do |data|
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
