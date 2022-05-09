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

module Jekyll
  module Drops
    class UrlDrop

      def nbsixty
        epoch_days = Time.parse(@obj.date.to_date.to_s).to_i / (60 * 60 * 24)
        num_to_sxg(epoch_days)
      end


      # converts base10 integers into NewBase60
      def num_to_sxg(num=nil)
        sxg        = ""
        vocabulary = "0123456789ABCDEFGHJKLMNPQRSTUVWXYZ_abcdefghijkmnopqrstuvwxyz"

        return 0 if num.nil? || num.zero?

        while num > 0 do
          mod = num % 60
          sxg = "#{vocabulary[mod,1]}#{sxg}"
          num = (num - mod) / 60
        end

        sxg
      end
    end
  end
end

