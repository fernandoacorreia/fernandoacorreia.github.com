# Title: GitHub File Tag for Jekyll
# Author: Fernando Correia http://TBD
# Description: A Liquid tag for Jekyll sites that imports files hosted in GitHub repositories into a blog post or a page with syntax highlighting and a link to the file on GitHub.
# Source: TBD
# Post: TBD
#
# Copyright (c) Fernando Correia. All rights reserved.
# Based on include_code by Brandon Mathis and gist_tag by Brandon Tilley.
# Licensed under the MIT License.
#
# Syntax:
#
# {% github_file user/repo [branch|tag|commit] /path/to/file [lang:language_name] %}
#
# If no branch, tag or commit is specified, it defaults to 'master'.
#
# Example 1:
#
# {% github_file twitter/bootstrap js/bootstrap-alert.js %}
#
# This will import the 'js/bootstrap-alert.js' file on the 'master' branch of
# the twitter/bootstrap GitHub repository and output the contents in a syntax
# highlighted code block inside a figure, with a figcaption listing the file
# name and a link to https://github.com/twitter/bootstrap/blob/master/js/bootstrap-alert.js
#
# Example 2:
#
# {% github_file twitter/bootstrap 2.1.0-wip js/bootstrap-alert.js %}
#
# This will import the 'js/bootstrap-alert.js' file on the '2.1.0-wip' branch of
# the twitter/bootstrap GitHub repository and output the contents in a syntax
# highlighted code block inside a figure, with a figcaption listing the file
# name and a link to https://github.com/twitter/bootstrap/blob/2.1.0-wip/js/bootstrap-alert.js
#
# Example 3:
#
# {% github_file twitter/bootstrap 5de1e39a8fba831faa170f46e868068fa069dd0e js/bootstrap-alert.js %}
#
# This will import the 'js/bootstrap-alert.js' file on the
# '5de1e39a8fba831faa170f46e868068fa069dd0e' commit of the twitter/bootstrap
# GitHub repository and output the contents in a syntax highlighted code block
# inside a figure, with a figcaption listing the file name and a link to
# https://github.com/twitter/bootstrap/blob/5de1e39a8fba831faa170f46e868068fa069dd0e/js/bootstrap-alert.js
#
# Example 4:
#
# {% github_file github/hubot src/robot.coffee lang:coffeescript %}
#
# This will import the 'src/robot.coffee' file on the 'master' branch of the
# github/hubot GitHub repository and output the contents in a syntax
# highlighted code block inside a figure, with a figcaption listing the file
# name and a link to https://github.com/github/hubot/blob/master/src/robot.coffee
# The syntax highlighting will be forced to 'coffeescript'.
#
# Use the 'lang:' option if the highlighting detection based on the file
# extension doesn't work.

require './plugins/pygments_code'
require './plugins/raw'

module Jekyll
  class GitHubFileTag < Liquid::Tag
    include HighlightCode
    include TemplateWrapper
    def initialize(tag_name, markup, tokens)
      @markup = markup
      super
    end

    def render(context)
      markup = @markup

      # set language
      if markup.strip =~ /\s*lang:(\w+)/i
        filetype = $1
        markup = markup.strip.sub(/lang:\w+/i,'')
      else
        filetype = nil
      end

      # parse parameters
      if markup.strip =~ /^(\S+\/\S+)(?:(?:\s+)(\S*))?(?:\s+)(\S+)$/i
        repo = $1
        ref = $2 || "master"
        file = $3
        filetype = File.extname(file).sub('.','') if filetype.nil?
      else
        return "Invalid parameters. Usage: {% github_file user/repo [branch|tag|commit] /path/to/file [lang:language_name] %}"
      end

      # generate output
      html_output_for repo, ref, file, filetype
    end

    def html_output_for(repo, ref, file, filetype)
      code = download_file repo, ref, file
      url = html_url_for repo, ref, file
      source = "<figure class='code'><figcaption>#{file} <a href='#{url}'>GitHub</a></figcaption>\n"
      source += " #{highlight(code, filetype)}\n"
      source += "</figure>"
      safe_wrap(source)
    end

    def download_file(repo, ref, file)
      raw_uri           = URI.parse raw_url_for repo, ref, file
      proxy             = ENV['http_proxy']
      if proxy
        proxy_uri       = URI.parse(proxy)
        https           = Net::HTTP::Proxy(proxy_uri.host, proxy_uri.port).new raw_uri.host, raw_uri.port
      else
        https           = Net::HTTP.new raw_uri.host, raw_uri.port
      end
      https.use_ssl     = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request           = Net::HTTP::Get.new raw_uri.request_uri
      data              = https.request request
      data.body
    end

    def html_url_for(repo, ref, file)
      "https://github.com/#{repo}/blob/#{ref}/#{file}"
    end

    def raw_url_for(repo, ref, file)
      "https://raw.github.com/#{repo}/#{ref}/#{file}"
    end
  end
end

Liquid::Template.register_tag('github_file', Jekyll::GitHubFileTag)
