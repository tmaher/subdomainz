Gem::Specification.new do |s|
  s.name = 'subdomainz'
  s.version = '1.2.1.dev'
  s.author = 'Wayne Meissner'
  s.email = 'wmeissner@gmail.com'
  s.homepage = 'http://github.com/tmaher/subdomainz'
  s.summary = 'Ruby SUBDOMAINZ'
  s.description = 'Ruby SUBDOMAINZ library'
  s.files = %w(subdomainz.gemspec History.txt LICENSE COPYING COPYING.LESSER README.md Rakefile) + Dir.glob("{ext,gen,lib,spec,libtest}/**/*").reject { |f| f =~ /lib\/1\.[89]/}
  s.extensions << 'ext/subdomainz_c/extconf.rb'
  s.has_rdoc = false
  s.license = 'LGPL-3'
  s.require_paths << 'ext/subdomainz_c'
  s.required_ruby_version = '>= 1.8.7'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler', '>=0.6.0'
  s.add_development_dependency 'rspec'
end
