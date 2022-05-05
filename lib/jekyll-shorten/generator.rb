module JekyllShorten
  class Generator < Jekyll::Generator
    safe true
    priority :lowest

    def generate(site)
      config = Jekyll.configuration["collections"]
      shorten = Jekyll.configuration["jekyll_shorten"]
      site.collections.each do |name, collection|
        if config[name] && config[name]["output"] && shorten[name] && shorten[name]["permashortlink"]
          template = shorten[name]["permashortlink"]
          collection.docs.each do |post|
          url = Jekyll::URL.new(
            :template => template,
            :placeholders => post.url_placeholders
          )
          new_page = PermashortlinkPage.new(site, post, url.to_s)
          site.pages << new_page
        end
        end
      end
    end

  end

  class PermashortlinkPage < Jekyll::Page
    def initialize(site, post, url)
      @site = site
      @base = site.source
      @dir = url[1..-1]
      @basename = "index"
      @ext = ".html"
      @name = "index.html"
      @data = {
        "redirect_to" => post.url,
        "layout" => "permashortlink"
      }
    end
  end
end
