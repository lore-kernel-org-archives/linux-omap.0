From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Thu, 18 Sep 2008 23:02:58 +0300
Message-ID: <20080918200245.GA6617@frodo>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net> <20080918195007.GA14307@flint.arm.linux.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33917 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbYIRUDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 16:03:44 -0400
Content-Disposition: inline
In-Reply-To: <20080918195007.GA14307@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, wim@iguana.be

Hi,

On Thu, Sep 18, 2008 at 08:50:07PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 18, 2008 at 10:03:16AM -0700, David Brownell wrote:
> > On Thursday 18 September 2008, Felipe Balbi wrote:
> > > convert to use ioremap() and __raw_{read/write} friends.
> > 
> > Why is this going to the OMAP list, not to LKML and cc'd
> > the watchdog maintainer?  (I added Wim to the cc list...)
> > 
> > If it's worth having, it's worth having in mainline...
> 
> Indeed, this is definitely something that can go into mainline now and
> trickle back down into the OMAP tree.
> 
> In other words, don't merge this into any OMAP tree, but get it into
> mainline and wait for it to come back.  Same goes for any other fixes.
> That means less work needs to be done by a very small number of
> individuals who don't have enough time to push everything from the OMAP
> tree upstream.

Unfortunately I'll have to disagree here, a diff on omap_wdt.c against
mainline shows quite a few changes since omap3 was introduced. Several
patches never went to mainline. I'll prepare a sync up patch from omap to
mainline and send both, but the omap3 stuff, won't be able to go in.
Maybe i'll try to get rid of all the if (cpu_is_XXX()) stuff in
omap_wdt.c and then send my patch on top of that.

> The only real down side is that there's already a rather large delta
> between the Tony's version and the mainline version:
> 
>  drivers/watchdog/omap_wdt.c |  314 +++++++++++++++++---------------------------
>  1 file changed, 122 insertions(+), 192 deletions(-)

Exactly.

> which needs resolving first.  It's no good sending Wim a patch which can
> only be applied to Tony's version of the driver.  Again, this is probably
> the result of not pushing people hard enough to send their fixes upstream.

Sure it is.

> Now, I could leave this email at that, but I won't, because it'll be
> ineffectual.  Yes yes yes is what everyone's saying.  We want OMAP to
> be more merged with mainline, but, please Tony apply this patch so we
> can have it working while we wait.
> 
> NO.  That's completely the wrong attitude.  As soon as it's in Tony's
> tree, everyone goes on their merry way and forgets about it, leaving
> it entirely up to Tony to sort out the resulting divergence with
> mainline.  That's does not scale, and the fact that OMAP struggles
> to merge with mainline proves it.

totally agree with you here.

> What I say to Tony: do you want OMAP to be merged into mainline, or
> don't you.  If you do, do _not_ accept this patch but get the changes
> already in your tree for omap_wdt.c up to Wim, and then get this patch
> there.  Provide the carrot by getting the driver up to date in mainline,
> and the stick by only accepting patches for this driver once they've
> been acked by Wim.  Explicitly ask Wim to ack them for you.
> 
> Then you have one less driver to worry about constantly being out of
> date with mainline.
> 
> Yes, it's probably radical for this community, but it _needs_ to happen.

Well, what can I say. I'll try to get rid of those cpu conditional code
in the driver and sync omap_wdt.c with mainline. Send all the patches
via Wim, so Tony can get them later.

-- 
balbi
