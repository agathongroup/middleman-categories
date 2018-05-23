require "middleman-core"

Middleman::Extensions.register :categories do
  require "middleman-categories/extension"
  Categories
end
