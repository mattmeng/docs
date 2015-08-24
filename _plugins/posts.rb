module Docs
  class PostsGenerator < Jekyll::Generator
    def generate( site )
      index = []

      site.posts.reverse.each do |post|
        index << {
          title: post.title,
          url: post.url
        }
      end
      site.data['posts'] = JSON.generate( [{
        contents: [{
          contents: index
        }]
      }] )
    end
  end
end