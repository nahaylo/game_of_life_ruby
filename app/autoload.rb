# puts Dir['./*']
# puts Dir["app/*"]
# puts __FILE__
# puts '---'
# # File.dirname(__FILE__)
Dir["app/*"].each { |f| require_relative "../#{f}" }
