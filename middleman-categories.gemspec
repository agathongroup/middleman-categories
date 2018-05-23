# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-categories"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John G. Norman"]
  s.email       = ["john@7fff.com"]
  s.homepage    = "https://7fff.com"
  s.summary     = %q{Provides categories to Middleman}
  s.description = <<DESCRIPTION
Provides categories to Middleman. This is especially useful for use with
Middleman Blog, when, in addition to tags, you want to put pages into
categories.

Put the list of categories in the front matter, for example:

---
title: Values
date: 2018-02-10 17:30 +0000
categories: Iora, Reading, Values
tags:
---

The extension exposes a method so that you can build a page for each category
with a list of posts for that category. Your templates get methods to extract
the category names from the front matter as a list, and a means to get a
hash where the key represents the name of a category, and the value is an
array of the pages, so that you can link to them, etc.
DESCRIPTION

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])
end
