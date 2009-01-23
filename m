From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP1: mcbsp clocks
Date: Fri, 23 Jan 2009 09:54:01 -0800
Message-ID: <20090123175401.GU7172@atomide.com>
References: <20090122235543.GC8137@n2100.arm.linux.org.uk> <20090123011726.GG7172@atomide.com> <20090123174249.GM26184@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58067 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbZAWRyF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 12:54:05 -0500
Content-Disposition: inline
In-Reply-To: <20090123174249.GM26184@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Stanley Miao <stanley.miao@windriver.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090123 09:43]:
> On Thu, Jan 22, 2009 at 05:17:28PM -0800, Tony Lindgren wrote:
> > Basically we currently cannot use virtual clocks because of this
> > and the fact that the parent of the virtual clock may not be known
> > as pointed out by Paul Walmsley.
> 
> One other thing I'd like to confirm is how the kernel treats the OMAP5912.
> OMAP5912 is interesting to me at the moment because it seems that all
> the information on it is freely available.  I don't know about the
> others.
> 
> However, it would be useful to know how the kernel treats this - iow,
> which of the four categories for OMAP1 SoCs - 310, 730, 1510, 1610.

5912 = 1611b = 16xx. Then 1710 is quite similar.

> Of course, if someone knows (or can send me, maybe Richard W?) where
> there's a similar document to spru751a for the clock architecture for
> these other CPUs (and OMAP2420, OMAP2430, OMAP3430, etc) it would be
> most useful.

I have some links on my webpage to the docs:

http://www.muru.com/linux/omap/

Still no public docs for 24xx :(

Tony
