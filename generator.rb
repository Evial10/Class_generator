# -*- coding: utf-8 -*-

class Generator  
  NUM_SYMBOLS = 10 # Symbols number in password

  def self.get_password(num_symbols = NUM_SYMBOLS)    
    fail ArgumentError, "Expected argument > 0" if num_symbols <= 0    
    
    vowel = ['a', 'e', 'o', 'u', 'y', 'i']
    consonants = ['a'..'z'].map{ |x| x.to_a }.flatten - vowel
    
    (0...num_symbols)
    .map { |elem|  elem % 2 == 0 ? consonants[rand(consonants.size)] : vowel[rand(vowel.size)] } 
    .join 
  end

end
