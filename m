From: Greg KH <greg@kroah.com>
Subject: Re: USB driver issue
Date: Thu, 31 Jul 2008 23:19:38 -0700
Message-ID: <20080801061938.GD8634@kroah.com>
References: <20080730164428.GS25065@intune.research.nokia.com> <466200.16933.qm@web53205.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47581 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbYHAGVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2008 02:21:51 -0400
Content-Disposition: inline
In-Reply-To: <466200.16933.qm@web53205.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emanoil Kotsev <deloptes@yahoo.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Thu, Jul 31, 2008 at 08:43:40AM -0700, Emanoil Kotsev wrote:
> 
> hello, again
> 
> I think what we are trying to say is that some of us are working on
> debugging kernels that are meant to run "forever"  and therefor it is
> a good thing to spent some time thinking about a kind of kernel
> release in the 2.6 series that can be considered as stable.

I don't think you really understand exactly how fast, and how rapid
Linux kernel development is.  Here's a short video that tries to explain
a bit of this:
	http://www.youtube.com/watch?v=L2SED6sewRw

At this rapid rate of development, for anyone to call anything "stable"
is laughable, just look at the raw numbers :)

And if you wish to stop and slow down the kernel developers from doing
this, well, are you able to tell someone else to stop doing something?
I'm sure not, and no one else is either.

Look at the numbers posted in that talk and then think about how to
manage such a MAJOR development stream that we are producing here.

It's different than _anything_ you have ever encountered before, and
because of that, needs to be treated differently.

> Besides what you say is correct but you can not provide argument for a
> stable software in the terms of what you are writing. because if you
> have a look at the changes done to the kernel code you'll admit that
> these are not a bug fixes but real changes that should lead the kernel
> to a new version (may be even not minor)

Numbers are just a marketing thing.  We produce 10,000 changes to the
kernel every 3 months.  Is that not somthing "major"?  If not, what is?

thanks,

greg k-h
