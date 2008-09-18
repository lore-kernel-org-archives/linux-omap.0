From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Thu, 18 Sep 2008 20:50:07 +0100
Message-ID: <20080918195007.GA14307@flint.arm.linux.org.uk>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51411 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbYIRTug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 15:50:36 -0400
Content-Disposition: inline
In-Reply-To: <200809181003.16664.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, wim@iguana.be

On Thu, Sep 18, 2008 at 10:03:16AM -0700, David Brownell wrote:
> On Thursday 18 September 2008, Felipe Balbi wrote:
> > convert to use ioremap() and __raw_{read/write} friends.
> 
> Why is this going to the OMAP list, not to LKML and cc'd
> the watchdog maintainer?  (I added Wim to the cc list...)
> 
> If it's worth having, it's worth having in mainline...

Indeed, this is definitely something that can go into mainline now and
trickle back down into the OMAP tree.

In other words, don't merge this into any OMAP tree, but get it into
mainline and wait for it to come back.  Same goes for any other fixes.
That means less work needs to be done by a very small number of
individuals who don't have enough time to push everything from the OMAP
tree upstream.


However, the omap ioremap changes aren't in mainline yet.  Even so, that
doesn't stop this change going in - the ioremap() changes only make
ioremap() more efficient for those regions that are statically mapped.
The end guarantees as far as the drivers are concerned (== give me a
virtual mapping for the bus address/size I'm requesting) remain true
no matter what.


The only real down side is that there's already a rather large delta
between the Tony's version and the mainline version:

 drivers/watchdog/omap_wdt.c |  314 +++++++++++++++++---------------------------
 1 file changed, 122 insertions(+), 192 deletions(-)

which needs resolving first.  It's no good sending Wim a patch which can
only be applied to Tony's version of the driver.  Again, this is probably
the result of not pushing people hard enough to send their fixes upstream.


Now, I could leave this email at that, but I won't, because it'll be
ineffectual.  Yes yes yes is what everyone's saying.  We want OMAP to
be more merged with mainline, but, please Tony apply this patch so we
can have it working while we wait.

NO.  That's completely the wrong attitude.  As soon as it's in Tony's
tree, everyone goes on their merry way and forgets about it, leaving
it entirely up to Tony to sort out the resulting divergence with
mainline.  That's does not scale, and the fact that OMAP struggles
to merge with mainline proves it.

What I say to Tony: do you want OMAP to be merged into mainline, or
don't you.  If you do, do _not_ accept this patch but get the changes
already in your tree for omap_wdt.c up to Wim, and then get this patch
there.  Provide the carrot by getting the driver up to date in mainline,
and the stick by only accepting patches for this driver once they've
been acked by Wim.  Explicitly ask Wim to ack them for you.

Then you have one less driver to worry about constantly being out of
date with mainline.

Yes, it's probably radical for this community, but it _needs_ to happen.
