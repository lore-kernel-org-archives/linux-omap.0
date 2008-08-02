From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 12:17:24 +0300
Message-ID: <20080802091723.GC8213@frodo>
References: <20080802082136.GA8213@frodo> <938190.30101.qm@web53205.mail.re2.yahoo.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53027 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbYHBJRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Aug 2008 05:17:31 -0400
Content-Disposition: inline
In-Reply-To: <938190.30101.qm@web53205.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emanoil Kotsev <deloptes@yahoo.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Sat, Aug 02, 2008 at 02:02:27AM -0700, Emanoil Kotsev wrote:
> Felipe, thank you for answering. I now see what's the problem with you

you should really rephrase this.

> I don't see anywhere the word "production" in your list, and that's my point. I want something that works and if there is a bug to be able to fix it and make it more stable. 

And that will come from the commercial company you said below.
Hopefully that commercial company will also notify the community so that
bug won't happen again in recent kernel versions.

That's exactly what we do when we release a new version of our Maemo SW,
it's not only a theme change, we're fixing bugs all around the thing.

> You debug, test and develop but you DON'T ralay on it. I am willing to have the oposite. NOT developeing, testing and debuging, but just using it - can you understand that?

And this is something you still don't get. I DO relay on it. Of course
we freeze internal development as soon as we release the pieces to
linux-omap, because it doesn't make any sense for us to keep backporting
so many pieces, although I remember backporting some patches to 2.6.18
back in n800 time.

> I want to use a kernel for PRODUCTION purposes, not for playing with it as you obviously do. I don't have time to start over debugging different issues that I did not have with the previous release, especially when it comes to my personal data that's stored out there.

you're wrong here. By the time we release our kernel, we also publish
everything to linux-omap tree. You can get any version of linux-omap and
boot your n8xx up to maemo desktop. That's even not a big deal.
Unfortunately we have a few closed source pieces which we are still
trying to open, believe me, it's not as easy as publishing.

> Even commercial companies support flavour of their OS's for years, so why shouldn't the linux community don't do it. It would bring benefit to all of us. Please refer to the discussion with Greg. I thinkg it makes more sense

But then you can get the support from those commercial companies,
can't you ?

If there is someone else already supporting older versions of the kernel
why should we stop ? The thing is, I just want to be sure the bug
someone is reporting still happens in current code, otherwise I won't
bother looking. If it's fixed, I just don't have enough time to
backport, anyone else can do it for you, or even you if you have the
time/expertise to do so.

-- 
balbi
