require 'date'
require File.join(File.dirname(__FILE__), "lib", "ar.rb")

Gem::Specification.new do |s|
  s.name        = 'ar'
  s.version     = 0.1
  s.date        = Date.today.to_s
  s.summary     = "Ar archive manipulator"
  s.description = "Pure ruby Ar"
  s.authors     = [ "Nicolas Szalay" ]
  s.email       = [ "nico@rottenbytes.info" ]
  s.files       = %w[
                    README.md
                    lib/ar.rb
                  ]
  s.homepage    = "https://github.com/rottenbytes/ruby-ar"
end
