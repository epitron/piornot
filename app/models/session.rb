class Session < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :guesses

  def stats
    if guesses.blank?
      [ nil, nil, nil ]
    else
      good, bad = guesses.partition { |g| g.correct }

      score = good.size
      total = good.size + bad.size
      percent = "%0.0f%" % ((score.to_f/total) * 100)

      [ score, total, percent ]
    end
  end
end
