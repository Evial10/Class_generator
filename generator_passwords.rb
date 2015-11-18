# -*- coding: utf-8 -*-
puts "Enter the number of symbols for a password and the number of passwords
The first two separated numbers of them will be in line
Number of symbols for a password more than 7 and less than 17
Passwords number greater than zero"

while mas = gets.chomp.scan(/\d+/)

  vowel = ['a', 'e', 'o', 'u', 'y', 'i']
  consonants = ['a'..'z'].map{ |x| x.to_a }.flatten - vowel
  num_symbol = mas[0].to_i
  num_pass = mas[1].to_i

  if ((8..16).include? num_symbol) && num_pass > 0
    num_pass.times do
      puts (0...num_symbol)
      .map { |elem|  elem % 2 == 0 ? consonants[rand(consonants.size)] : vowel[rand(vowel.size)] } 
      .join  
    end

    break
  else
    puts "Invalid input format.Enter numbers of again"
  end
end
