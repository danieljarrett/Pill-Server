lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'pill/version'

Gem::Specification.new do |spec|
  spec.name          = 'pill'
  spec.version       = Pill::VERSION
  spec.authors       = ['Daniel Jarrett']
  spec.email         = ['djarrett@alumni.princeton.edu']
  spec.summary       = %q{A Rack-Compliant Web Server}
  spec.description   = %q{A minimal, multi-threaded, Rack-compliant web server}
  spec.homepage      = 'http://github.com/danieljarrett/Pill-Server'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'http_parser.rb', '~> 0.5.3'
end
