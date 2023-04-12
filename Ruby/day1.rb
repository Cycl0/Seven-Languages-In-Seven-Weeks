# Print Hello, world
puts 'Hello, world'

# Print index of Ruby
str = 'Hello, Ruby'
puts /Ruby/ =~ str

# Print my name 10 times
5.times { puts 'Lucas' }
(1..5).each { puts 'Lucas' }

# Print This is the sentence number i
(1..100).each {|i| puts "This is the sentence number #{i}" }

# Random number guess
puts 'Choose a number from 1 to 10: '
n = gets.to_i
r = rand(1..10)
puts "Congratulations! You won, the random number was #{r}" if n == r
puts "You lost, the random number was #{r}" if n != r
