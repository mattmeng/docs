module Docs
  class Index
    attr_accessor :name, :url, :children

    def initialize( name: nil, url: nil )
      @name = name
      @url = url
      @children = IndexCollector.new
    end
  end

  class IndexCollector
    attr_accessor :collection

    def initialize()
      @collection = []
    end

    def []( indices )
      return nil unless indices
      indices.split!( '/' ).shift unless indices.is_a? Array
      index = indices.shift
      return @collection[index].children[indices] if indices.empty?
      return @collection[index]
    end

    def []=( indices )
      return nil unless indices
      indices.split!( '/' ).shift unless indices.is_a? Array
      index = indices.shift
      @collection[index] = Index.new( index )
    end
  end

  class IndexGenerator < Jekyll::Generator
    # def parse_page( indices,  )
    def generate( site )
      site.pages.each do |page|
        puts "basename: #{page.basename}, dir: #{page.dir}, url: #{page.url}"
      end
    end
  end
end