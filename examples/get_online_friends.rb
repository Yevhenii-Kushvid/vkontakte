# encoding: utf-8

require 'bundler'
Bundler.setup :default

require 'vkontakte'

puts Vkontakte::VERSION

if __FILE__ == $0
  CLIENT_ID = '5135875'
  # Авторизация по логину и паролю
  email = ARGV[0]
  pass  = ARGV[1]
  vk = Vkontakte::Client.new(CLIENT_ID)
  vk.login!(email, pass)

  puts "access_token: #{vk.access_token}"
  puts "api_version: #{vk.api_version}"

  vk.api.lang = 'en'
  friends = vk.api.friends_get(fields: 'online')

  # Использование токена
  #access_token = ARGV[0]
  #api = Vkontakte::API.new(access_token)
  #friends = api.friends_get(fields:  'online')

  friends_online = friends['items'].select {|item| item['online'] == 1}

  puts "Online friends [#{friends_online.size}]:"
  friends_online.each do |f|
    mobile = (f['online_mobile'] == 1) ? "[mobile]" : ""
    puts "[#{f['id']}] #{f['first_name']} #{f['last_name']} #{mobile}"
  end
end
