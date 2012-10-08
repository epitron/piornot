class Guess < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :session
end
