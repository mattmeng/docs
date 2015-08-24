module Docs
  class TOCGenerator < Jekyll::Generator
    def generate( site )
      site.pages.each do |page|
        puts "title: #{page['title']}, dir: #{page.dir}, url: #{page.url}"
      end

      site.posts.each do |post|
        puts "title: #{post['title']}, dir: #{post.dir}, url: #{post.url}"
      end
    end
  end
end