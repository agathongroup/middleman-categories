# Middleman Categories

This is an extension to make it easy to categorize Middleman pages with
front matter. Methods are exposed that provide for linking to generated
pages that can provide a list of links to all pages in a category.

The key use case is for porting a blog from WordPress that defines both
tags and categories. [WordPress says that tags should enumerate content
details for a page, and categories should describe larger buckets for content.](https://en.support.wordpress.com/posts/categories-vs-tags/)

## upstream

 This project was originally forked from https://github.com/jgn/middleman-categories


## To use

1. In your `Gemfile`, add the gem:

        gem 'middleman-categories', git: 'https://github.com/agathongroup/middleman-categories'

2. In your `config.rb`, activate the extension:

        activate :categories

3. To any page that you want to categorize, add front matter with a
`categories` line. If you want a page to be in multiple buckets, separate
the category names with a space. Example:

        ---
        categories: Reading, Reviews, Management
        ---

4. In your `config.rb`: If you want pages to be generated listing links for each category,
call `proxy_categories` in the `ready` block:

        ready do
          proxy_categories
        end

5. Create a page called `category.html.erb`. Here you will add markup
that lists links for all pages within a category. It might look something like
this:

        Page in the category "<%= category_name %>"

        <ul>
          <% pages_by_category[category_name].each_with_index do |page, i| %>
            <li><%= link_to page.data.title, page %> <span>(<%= page.data.date %>)</span></li>
          <% end %>
        </ul>

    `category_name` is injected into this template by the extension. The extension
    exposes `pages_by_category`, which acts like a hash, to give you access to an
    array of pages for each category name.

    You also need to exclude the category.html from your build.

    configure :build do
        ...
        ignore '/category.html'
    end

    Note: If you are using the Middleman Blog extension, and you know that the
    page in question is a blog article, you might use the Middleman Blog helpers
    to get at the title and date, for instance . . .

        <ul>
          <% pages_by_category[category_name].each_with_index do |page, i| %>
            <li><%= link_to page.title, page %> <span>(<%= page.date.strftime('%B %e, %Y') %>)</span></li>
          <% end %>
        </ul>


6. You can also list the categories defined in the front matter for a page.
For example:

        ---
        title: Demo of categories
        date: 2018-03-03 16:15 +0000
        categories: Reading, Reviews, Management
        tags:
        ---

        ## Categories demo

        Hello!

        This page is in the categories
        <% categories_for_page(current_page).each do |category| %>
          <%= link_to category, category_path(category) %>
        <% end %>

## Exposed methods and variables

And just to be clear about methods exposed by the extension: `proxy_categories`
is exposed to `config.rb` so that pages can be dynamically generated for each
category.

The following three methods are exposed to a template:

| method or variable          | explanation |
|-----------------------------|-----------|
| categories_for_page(page)   | Returns an Enumerable of Strings representing the category names |
| pages_by_category           | Returns a Hash-like object with an Enumerable of Middleman pages for each key which is a String representing a category name (so you can write `pages_by_category["Reading"]`) |
| category_path(category)     | Returns a path to the page describing the category |
| category_name               | Not a method, but a variable injected into the `category.html` proxy |
