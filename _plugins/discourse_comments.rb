# Discourse Comments for Jekyll
#
# Generates Discourse comments for posts
#
# Author: Blake Erickson, Justin Gordon
# Site: http://blakeerickson.com, http://www.railsonmaui.com
# Plugin Source: http://github.com/oblakeerickson/jekyll_discourse_comments
# Plugin License: MIT

module Jekyll

  class DiscourseComments < Generator

    def generate(site)
      @site = site

      process_posts
    end

    def process_posts
      @site.posts.each do |post|
        post.content += snippet(post.url)
      end
    end

    def snippet(url)
      <<-EOF.unindent

        <div id="discourse-comments"></div>
        <script type="text/javascript">
          DiscourseEmbed = {
            discourseUrl: "#{File.join(@site.config['discourse_url'], '')}",
            discourseEmbedUrl: "#{@site.config['url']}#{@site.config['baseurl']}#{url}"
          };

          (function() {
            var d = document.createElement('script');
            d.type = 'text/javascript';
            d.async = true;
            d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';

            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
          })();

          $(document).ready( function() {
            $('#discourse-embed-frame').iFrameResize( {log: true} );
          } );
        </script>
      EOF
    end
  end

end

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end
