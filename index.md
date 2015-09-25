---
title: Welcome to the Documentation Server!
layout: page
---

This application is meant to be a repository of knowledge about our product and environment.  It was created to provide each employee a place to learn and share knowledge.  It's use is not required; it was built as an open source project, available for everyone for the benefit of everyone by the combined effort of everyone.  Some reasons for using this type of service instead of a Wiki are:

* Our current Wiki is so free-form and open that much gets lost or is not organized well.  By storing our documentation in a repo, essentially product-izing it, we make it code-reviewable and provide a structure for submitting changes.
* The Wiki also contains outdated documentation.  With a managing organization (the SIT team) tracking the documentation, outdated docs can be requested to be updated or openly updated by others in the community.
* This documentation server keeps things organized through an index feature, so it should be easy to find what you're looking for.

## Contributing

The project is open source and available for all to contribute to.  The main repo is hosted by the SIT team and is located at https://git.ida.lab/sit/docs.  Feel free to fork the repo and work on it, adding your own documentation.  When you are ready for it to be pushed to the server, create a pull request back into the SIT team's `master` branch.

## Structure

The server uses the [Jekyll Ruby Gem](http://jekyllrb.com/), so reading up on that would be helpful for you.  Any folder that is preceded with an `_` is a Jekyll framework file and shouldn't be messed with generally, with the exception of `_data/index.yml`.

### The Index

The `_data/index.yml` file defines the index for the site.  You'll see something like the following in that file:

{% highlight yaml linenos %}
- title: Git
  contents:
    - title: FAQ and Helpful Hints
      contents:
        - path: /git/stories.md
        - path: /git/cool_commands.md
- title: Support
  contents:
    - title: Supportability Documents
      contents:
        - path: /core_docs
          title: Gollum Documentation
{% endhighlight %}

There are three levels for organization:

* **Sections** like `Git` or `Support`
* **Chapters** like `FAQ and Helpful Hints` or `Supportability Documents`
* **Pages** like `/git/stories.md` or `/core_docs`

Each level supports both the `title` and `path` tags.  The `title` indicates the title of the document, which will override the title specified in the YAML data of the document.  The `path` tag tells Jekyll where these files are located so that it can link to them when it generates the index.

### Pages

Pages should be organized just like their section/chapter/page layout in the index, with each section and chapter being folders.  **All folder and file names should be in snake case.**

The page can be written in markdown, asciidoc, etc and needs to include a YAML header at the top:

{% highlight yaml linenos %}
---
title: Stories for Working with the Repository
authors:
  - name: John Doe
    email: john.doe@intel.com
  - name: Jane Doe
    email: jane.doe@intel.com
layout: page
---
{% endhighlight %}

It can contain a `title` that describes the document, `authors` of the document and must have `layout: page` in order to display correctly.

Do not use `h1`s (`#`) in your document.  They are reserved for the title.
