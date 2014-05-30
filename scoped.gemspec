$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'scoped/version'

Gem::Specification.new do |s|
  s.name     = "scoped"
  s.version  = ::Scoped::VERSION
  s.authors  = ["Evan Sherwood"]
  s.email    = ["evan@sherwood.io"]
  s.homepage = "http://github.com/neezer"

  s.description = s.summary = "A rigid, readable alternative for defining AR scopes."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  if ENV["AR"]
    s.add_dependency 'activerecord', ENV["AR"]
  else
    s.add_dependency 'activerecord', '>= 3.1.0', '< 5'
  end

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "README.md", "Rakefile", "scoped.gemspec"]
end
