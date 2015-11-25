require 'net/http'
require 'json'

YandexError = Class.new(StandardError)

class Translator
  
  KEY = "trnsl.1.1.20151124T095711Z.d41f13a82e427408.736db2b43c90575b5934e1b988554b94947240e1" 
  HOST = "https://translate.yandex.net/api/v1.5/tr.json/"
  CODES = {
    :ok => 200,
    :invalid_key => 401,
    :blocked_key => 402,
    :daily_limit_requests => 403,
    :dailt_limit_scope => 404,
    :max_limit => 413,
    :not_translate => 422,
    :translation_not_suppoted => 501    
  }
  
  class << self
  
    def get_list_language(lang = "ru")   
      doc = Net::HTTP.get_response(URI.parse("#{HOST}/getLangs?key=#{KEY}&ui=#{lang}"))
      json = JSON.parse doc.body             
      fail YandexError, json['message'] unless json['code']            
      return json['langs'], json['dirs']              
    end
    
    def detect_language(text, lang = "ru")
      langs = get_list_language lang
      fail ArgumentError, "Incorrect reduction" unless langs[0]
      
      doc = Net::HTTP.get_response(URI.parse(URI.encode("#{HOST}/detect?key=#{KEY}&text=#{text}")))
      json = JSON.parse doc.body
      
      fail YandexError, json['message'] unless json['code'] == CODES[:ok]      
      langs[0][json['lang']]
    end
    
    def translate(text, lang, format = "plain")    
      doc = Net::HTTP.get_response(URI.parse(URI.encode("#{HOST}/translate?key=#{KEY}&text=#{text}&lang=#{lang}&format=#{format}")))
      json = JSON.parse doc.body
      
      fail YandexError, json['message'] unless json['code'] == CODES[:ok]        
      json['text']
    end
    
  end


end
