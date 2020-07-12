require_relative 'lib/services/version.rb'

Gem::Specification.new do |spec|
  spec.name          = "cli-nasa"
  spec.version       = Nasa::VERSION
  spec.authors       = ["Ray Ockenfels"]
  spec.email         = ["ockenfelsr@gmail.com"]

  spec.summary       = %q{A simple CLI for NASA's Image and Video Library}
  spec.description   = %q{CLI interface for accessing multimedia metadata from
                        the NASA Image and Video Library. Can run broad keyword
                        searches as well as image, audio, and video specific
                        searches. Displays a link to a piece of content as
                        well as the title, keywords, and description.}
  spec.homepage      = "https://rubygems.org/gems/cli-nasa"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]
  spec.executables   = "run_me"
end
