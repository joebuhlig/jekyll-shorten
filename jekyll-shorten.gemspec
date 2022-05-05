require "English"
require_relative "lib/jekyll-shorten/version"

Gem::Specification.new do |s|
  s.name          = "jekyll-shorten"
  s.version       = JekyllShorten::VERSION
  s.license       = "GPL-3.0"
  s.authors       = ["Joe Buhlig"]
  s.email         = ["joe@joebuhlig.com"]
  s.homepage      = "https://rubygems.org/gems/jekyll-shorten"
  s.summary       = "A jekyll generator that creates shortlinks for your site that redirect."
  s.description   = "A jekyll generator that creates shortlinks for your site that redirect."
  s.files         = `git ls-files -z`.split("\x0").grep(%r!^lib/!)
  s.require_paths = ["lib"]
  s.metadata      = {
    "source_code_uri" => "https://github.com/joebuhlig/jekyll-shorten",
    "bug_tracker_uri" => "https://github.com/joebuhlig/jekyll-shorten/issues",
    "changelog_uri"   => "https://github.com/joebuhlig/jekyll-shorten/releases",
    "homepage_uri"    => s.homepage,
  }
  s.add_dependency "jekyll", ">= 3.7", "< 5.0"
end
