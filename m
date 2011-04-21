From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Thu, 21 Apr 2011 08:42:21 +0300
Message-ID: <20110421054221.GF5918@atomide.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
 <20110419062633.GA15620@atomide.com>
 <87r58w4gq3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16272 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750784Ab1DUFmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 01:42:25 -0400
Content-Disposition: inline
In-Reply-To: <87r58w4gq3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

* Kevin Hilman <khilman@ti.com> [110421 02:56]:
> Hi Tony,
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Varadarajan, Charulatha <charu@ti.com> [110418 18:00]:
> >> From: Charulatha V <charu@ti.com>
> >> 
> >> Use PM runtime framework in OMAP GPIO driver.
> > ...
> >  
> >>  arch/arm/mach-omap2/gpio.c             |    6 +
> >>  arch/arm/mach-omap2/pm34xx.c           |   22 +-
> >>  arch/arm/plat-omap/gpio.c              |  766 ++++++++++++++++++--------------
> >>  arch/arm/plat-omap/include/plat/gpio.h |    3 +-
> >>  4 files changed, 439 insertions(+), 358 deletions(-)
> >
> > Before this series gets merged we first need to do the following:
> > - Pass some registers in platform_data so we can have common
> >   functions in gpio.c instead of having to test for the bank->method
> >   in each function. This allows getting rid of the ifdefs as
> >   discussed in the ARM Linux consolidation thread.
> 
> I have a series that starts this process, will post it shortly.

Saw that, looks good :) Need to post it also to lakml BTW.
 
> > - Move it to drivers/gpio
> >
> > - Further consolidate with whatever common GPIO code might
> >   be coming up.
> 
> Is the above order required?

Yes please. Otherwise we'll have more of the "crazy churn" in
arch/arm/*omap*/ and the runtime PM patches should apply easily
in drivers/gpio too.
 
> IMO, before we move it to drivers/gpio, this code needs to be runtime PM
> converted (using this series from Charu.)  The runtime PM conversion
> removes a bunch of platform-specific hacks that should be moved into
> drivers/*.
> 
> Personally, I think we should go in this order
> 
> - runtime PM conversion

Let's do this after the consolidation and move to drivers/gpio.
This way any additions can be reviewed by the drivers/gpio maintainers.

> - #ifdef cleanup

Looks like you got this already done :)

> - move to drivers/gpio

With this part there may be more comments from the drivers/gpio
maintainers so we need to get to this point ASAP.

> - look at consolidation with other drivers
> 
> I'm willing to queue the GPIO work in my tree while it's under way if
> you like as well.

If so, please put all the consolidation patches into a separate
branch with absolutely zero additional new code. And let's merge
those branches into linux-omap devel-cleanup branch on regular
basis for testing.

Regards,

Tony
