---
layout: post
title: "Installing rbenv on Ubuntu"
date: 2012-07-26 12:52
comments: true
categories: Ubuntu
---

I chose Octopress to publish this blog. When I was reading on how to install it, I learned that it required Ruby 1.9.2.
Octopress' documentation recommends installing it through a Ruby environment manager: either RVM or rbenv.

The last time I was dabbling with Ruby was a few years ago, before these tools were introduced. So I didn't have a
favorite to pick. To choose one I
searched Google, read a little bit and came to the conclusion that rbenv is lighter and possibly simpler, while RVM
is more complex and more powerful. I'm not developing in Ruby so light and simple suits me. At the same time, RVM
messes with the builtin `cd` command and I'd rather leave it alone. So I picked rbenv.

<!-- more -->

Ubuntu has has a rbenv package, so I went for it first. I quickly had rbenv running but when I tried to install the
ruby-build rbenv plugin I couldn't get it to work. I could have used an alternate route to install ruby-build
but I prefer the path of less resistance. I don't like fighting the tools.

So I uninstalled Ubuntu's rbenv package (which, by the way, was several versions out-of-date) and did a manual install
of rbenv from its project site.

These are the commands I used to install rbenv in Ubuntu 12.04 LTS (Precise Pangolin):

{% gist 3177482 %}

Installing Ruby takes some time, between a large download and setup, but everything went smoothly and worked as
advertised. A great experience.
