require 'middleman-core'

class Categories < ::Middleman::Extension
  expose_to_template :categories_for_page
  expose_to_template :pages_by_category
  expose_to_template :category_path
  expose_to_config :proxy_categories

  def initialize(app, options_hash={}, &block)
    super
  end

  def categories_for_page(page)
    split_categories(page.data.categories)
  end

  def category_path(category_name)
    "/category/#{category_name.parameterize}.html"
  end

  def category_names
    @category_names ||= @pages_by_category.keys
  end

  def proxy_categories(template = 'category.html')
    category_names.each do |category_name|
      app.config_context.proxy category_path(category_name), template, locals: { category_name: category_name }
    end
  end

  def pages_by_category
    @pages_by_category
  end

  def split_categories(categories)
    (categories || "Uncategorized").split(/,\s*/)
  end

  def after_configuration
  end

  def manipulate_resource_list(resources)
    @pages_by_category = {}
    resources.each do |resource|
      if !resource.data.categories.nil?
        if resource.data.published != 'false'
          categories_for_page(resource).each do |ac|
            @pages_by_category[ac] ||= []
            @pages_by_category[ac] << resource
          end
        end
      end
    end

    @pages_by_category = @pages_by_category.sort.to_h

    resources
  end

  helpers do
  end
end
