---
layout: post
title: "Static websites are more resilient and cost-effective"
date: 2012-07-27 20:04
comments: true
categories: general
---

Dave Cole, from Development Seed, wrote a
[comprehensive article](http://developmentseed.org/blog/2012/07/27/build-cms-free-websites/)
on their journey from developing
sites with heavy-duty CMSs, through dynamic client-side pages, to "devising a process by which we build static sites
dynamically". He explains how they leverage single-purpose web applications, existing or custom-made, to make that
easier.

One of the chief benefits he mentions is:

{% blockquote Dave Cole http://developmentseed.org/blog/2012/07/27/build-cms-free-websites/ How We Build CMS-Free Websites %}
We can deploy our projects on practically any web server and not worry about whether it has the right software to run our application or the technical resources to handle high traffic.
{% endblockquote %}

<!-- more -->

That makes sense to me and I can see this model working for many websites. This reminds me of old-school stuff
like Microsoft Frontpage... But those sites tended to be too static. Combining static content with web services and
weaving all that with client-side JavaScript can be a powerful strategy.

Each component does what it does best, whether it's
serving static files (possibly through a CDN), providing single-purpose dynamic content (such as pictures, video or
comments) or implementing client-side customization and functionality.

This blog follows this approach: it's built with Octopress, it's hosted on GitHub Pages and it uses services like
Google Search, Twitter and Disqus for interactivity.
