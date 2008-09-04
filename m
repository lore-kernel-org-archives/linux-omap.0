From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver
Date: Wed, 3 Sep 2008 18:02:19 -0700
Message-ID: <20080904010218.GM23085@atomide.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <200808311406.14234.david-b@pacbell.net> <20080831213105.GG9887@frodo> <200808311451.18565.david-b@pacbell.net> <20080831220229.GN9887@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57985 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIDBC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 21:02:26 -0400
Content-Disposition: inline
In-Reply-To: <20080831220229.GN9887@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Felipe Balbi <me@felipebalbi.com> [080831 15:03]:
> On Sun, Aug 31, 2008 at 02:51:18PM -0700, David Brownell wrote:
> > Fixable, I'd expect.  :)
> 
> I'm sure it is :-)
> 
> > > so even if we 
> > > have all the drivers there. Mainline has support up to omap2430, if i'm
> > > not wrong. So looks like beagleboard users will have to wait a bit
> > > longer.
> > 
> > Well, it's not a 2.6.27 goal.  But I'd think it should be very
> > possible for 2.6.28 merging.
> 
> Should be possible, but Tony can say for sure.

Sorry I'm still behind with my emails.. I think we have a fair chance of
getting minimal omap3 board configurations booting with mainline kernel.
Most core stuff is starting to be somewhat in sync for mach-omap2, and
then we just need the board-*.c files. PM stuff is still under construction
of course.

> > However, I'll re-emphasize that doing that means submitting the
> > patches for real, not to the OMAP list.  And since mainline is
> > now at RC5, there's not a lot of time yet to get this new code
> > reviewed and entered into the MMC queue...
> 
> I think it's not a must to merge it for 2.6.27 time, but 2.6.28 would be
> good enough. As long as we merge them upstream and avoid merge conflicts
> on l-o, I'd be happy. Besides the fact that drivers should be discussed
> on the proper mainling list for facts that you already said in another
> comment, right ? :-)

Yes, drivers should be discussed on the appropriate mailing lists.

Tony
