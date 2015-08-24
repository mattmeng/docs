module Docs
  class IndexGenerator < Jekyll::Generator
    def build_index( indices, site )
      new_indices = []
      indices.each do |item|
        index = {}

        # If a URL is present...
        if item['path']
          # Find the page.
          page = site.pages.detect {|page| page.relative_path == item['path']}
          if page
            index['title'] = page['title']
            index['url'] = page.url
          else
            # If we didn't find a corrosponding page...
            index['title'] = item['title'] || "No Page Found"
            index['url'] = item['path']
          end

          # Build out contents indices.
          index['contents'] = build_index( item['contents'], site ) if item['contents']
        else
          # If there was no URL, a title is required.
          index['title'] = item['title']
          index['contents'] = build_index( item['contents'], site ) if item['contents']
        end

        new_indices << index
      end

      return new_indices
    end

    def generate( site )
      site.data['index'] = JSON.generate( build_index( site.data['index'], site ) )
    end
  end
end