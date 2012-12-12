Gem::Specification.new do |s|
  s.name = 'subdomainz'
  s.version = '0.0.1'
  s.author = 'Tom Maher'
  s.email = 'tmaher@tursom.org'
  s.homepage = 'http://github.com/tmaher/subdomainz'
  s.summary = 'Ruby SUBDOMAINZ'
  s.description = 'Ruby SUBDOMAINZ library'
  s.files = %w(subdomainz.gemspec) + Dir.glob("{ext,spec}/**/*.{c,h,rb}")
  s.extensions << 'ext/subdomainz_c/extconf.rb'
  s.has_rdoc = false
  s.required_ruby_version = '>= 1.8.7'
  s.add_dependency 'mkmf'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler', '>=0.6.0'
  s.add_development_dependency 'rspec'
end
