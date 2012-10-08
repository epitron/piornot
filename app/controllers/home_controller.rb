class HomeController < ApplicationController

  def index
    u = current_user

    if params[:reset]
      u.guesses.destroy_all
    end

    if guess = params[:guess]
      @correct = ( guess.to_i == session[:correct_guess] )
      u.guesses.create(correct: @correct)
    end

    @score, @total, @percent = u.stats

    @data = [some_pi, some_random]
    @data = @data.reverse if ( session[:correct_guess] = rand 0..1 ) > 0
  end

private

  def some_pi(amount=60)
    open("pi.txt", "rb") do |f|
      max = f.size - amount
      min = 2

      pos = rand(min..max)
      f.seek(pos)
      data = f.read(amount)

      logger.info "pi: #{data}"

      data
    end
  end


  def some_random(amount=60)
    (0...amount).map { rand(0..9) }.join ''
  end

end
