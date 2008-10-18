From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix bootup crash for LDP platform
Date: Sat, 18 Oct 2008 23:36:36 +0300
Message-ID: <20081018203625.GR31842@frodo>
References: <1224284642-13863-1-git-send-email-vikram.pandita@ti.com> <200810181228.09194.david-b@pacbell.net> <20081018194304.GP31842@frodo> <200810181316.51253.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60377 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYJRUg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 16:36:59 -0400
Content-Disposition: inline
In-Reply-To: <200810181316.51253.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Tony Lindgren <tony@atomide.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Oct 18, 2008 at 01:16:50PM -0700, David Brownell wrote:
> Right now all we need is a way to make sure the MUSB code
> isn't assuming an integrated transceiver ... the patch I
> just sent is *only* to git rid of that "use an out-of-date
> copy of the original transceiver" logic.

right

> There are certainly some improvements that can be made in
> the area of OTG transceiver handling.  There are some PXA
> related patches in that area, too.  ISTR one of them was
> just to provide calls to register and unregister the OTG
> transceiver, moving them out of platform code (where they
> live today)...

hmm... that (if we're talking about the same patches) was based in
earlier patches from me and Tony when we wrote the whole otg messaging
stuff for n810.

I recall sending them but the community didn't quite like the approach.
I was hoping to get them in better shape and resend but got too busy
with omap3 stuff, so that task got reniced.

I'm just happy someone took over those patches since they are quite
useful.

> What I recall about your drivers/usb/otg notion (maybe not
> entirely correctly) was that it covered a lot of stuff
> which, it seemed to me, didn't need abstracting.

Yeah, from the original idea we were trying to handle some (maybe most)
of the otg timers in sw. Little later I got back to earth and figured
those timers are handled in hw.

> Maybe once we get the current MUSB stuff to work within
> the current framework -- which splits out otg_transceiver
> as an entity that host and peripheral side controller
> drivers talk to -- we should revisit such stuff.

sounds goods to me.

> I don't follow *that* at all.  If some driver other than
> twl4030-usb registers as the system's OTG transceiver,
> MUSB on OMAP3x should just use that.  All musb should do
> is ask for the transceiver, and then talk to it ... but
> the current code can't do that.

hmm.. true, not that we can have 2 otg transceivers wired at the same
time anyways.

> Let's make sure it doesn't break DaVinci and TUSB first.
> It'd be good to remove the musb->xceiv->state doubled
> indirections in most places too, just as cleanup.
> 
> (Plus cope with the $SUBJECT issue "for real"!)

sure.

> Right.  Does Blackfin have an integrated transceiver like
> DaVinci and TUSB?  Or does it use a discrete one?

I'll revisit the blackfin patches, they're going only for 2.6.29 merge
window.

> I'm thinking this issue needs resolving before twl4030-usb can
> go upstream.  :)

hehe, i'll take a closer look at your patch starting on monday and try to
convert tusb6010 asap. Time to get my nice n810 back to life :-)

> Does mainline work with tusb6010 today?  I see lots of USB
> patches merged yesterday.  And enough ARM/DaVinci patches
> merged (a few days back) that its MUSB might work too.

We don't have any board-support for tusb6010 but all the code is there.

-- 
balbi
