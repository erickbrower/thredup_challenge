$:.unshift File.expand_path('../../', __FILE__)

require 'bundler/setup'

Bundler.require(:default, ENV['THREDUP_ENV'] || 'development')

Dir.glob('lib/**/*.rb').each do |file|
  require file
end
