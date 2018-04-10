$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'shiroyagi/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'shiroyagi'
  s.version     = Shiroyagi::VERSION
  s.authors     = ['Rui Onodera']
  s.email       = ['deraru@gmail.com']
  s.homepage    = 'https://github.com/Findy/shiroyagi'
  s.summary     = 'Read/Unread status management module for Rails.'
  s.description = 'Read/Unread status management module for Rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.2.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'pry-byebug'
end
