require 'bigdecimal'

open("pi-billion.txt") do |f|
  puts "Computing..."
  amount = 5_000_000
  tau = BigDecimal.new(f.read) * 2

  puts "Writing to tau.txt..."
  open("tau.txt","wb"){ |out| out << tau.to_s("F") }
  puts "Done!"
end