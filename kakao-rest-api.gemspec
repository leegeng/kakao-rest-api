Gem::Specification.new do |s|
  s.name = 'kakao-rest-api'
  s.version = '0.9.2'
  s.date = '2016-02-20'
  s.summary = 'Simple Kakao platform REST API client for Ruby'
  s.description = 'Simple Kakao platform REST API client for Ruby'
  s.authors = ['Kyoungwon Lee']
  s.email = 'kyoungwon.lee86@gmail.com'
  s.files = Dir['lib/*.rb', 'lib/v1/*.rb', 'lib/v1/api/*.rb']
  s.homepage = 'http://rubygems.org/gems/kakao-rest-api'
  s.license = 'MIT'

  s.required_ruby_version = '>= 2.0.0'
  s.add_runtime_dependency 'rest-client', '~> 1.8', '~> 1.8.0'
end

