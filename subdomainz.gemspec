Gem::Specification.new do |s|
  s.name = 'subdomainz'
  s.version = File.read("VERSION").chomp
  s.authors = ['Tom Maher']
  s.email = 'tmaher@tursom.org'
  s.homepage = 'http://github.com/tmaher/subdomainz'
  s.summary = 'Ruby SUBDOMAINZ'
  s.description = 'Ruby SUBDOMAINZ library'
  s.files = `git ls-files`.split("\n")
  s.extensions << 'ext/subdomainz/extconf.rb'
  s.has_rdoc = false
  s.required_ruby_version = '>= 1.8.7'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler', '>=0.6.0'
  s.add_development_dependency 'rspec'
end
