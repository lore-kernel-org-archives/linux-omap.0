From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix bootup crash for LDP platform
Date: Sat, 18 Oct 2008 13:16:50 -0700
Message-ID: <200810181316.51253.david-b@pacbell.net>
References: <1224284642-13863-1-git-send-email-vikram.pandita@ti.com> <200810181228.09194.david-b@pacbell.net> <20081018194304.GP31842@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:31112 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750958AbYJRUQx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Oct 2008 16:16:53 -0400
In-Reply-To: <20081018194304.GP31842@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Saturday 18 October 2008, Felipe Balbi wrote:
> > Partial fixup patch appended; doesn't resolve $SUBJECT
> > issue, I think, but it's in the right direction.
> 
> Looks fine. I recall talking to you about this some months ago but my
> approach was about introducing a drivers/usb/otg layer to which we would
> usb_otg_register_driver() or something similar thus allowing musb (or
> any other consumer) just use the otg_tranceiver that is registered now.

Right now all we need is a way to make sure the MUSB code
isn't assuming an integrated transceiver ... the patch I
just sent is *only* to git rid of that "use an out-of-date
copy of the original transceiver" logic.


There are certainly some improvements that can be made in
the area of OTG transceiver handling.  There are some PXA
related patches in that area, too.  ISTR one of them was
just to provide calls to register and unregister the OTG
transceiver, moving them out of platform code (where they
live today)...

What I recall about your drivers/usb/otg notion (maybe not
entirely correctly) was that it covered a lot of stuff
which, it seemed to me, didn't need abstracting.

Maybe once we get the current MUSB stuff to work within
the current framework -- which splits out otg_transceiver
as an entity that host and peripheral side controller
drivers talk to -- we should revisit such stuff.


> The good thing about it is that it would allow us to switch otg
> transceivers and not have to add aditional conditional code to handle
> it.
> 
> Your approach looks good but case we have to change the transceiver (not
> twl4030-usb, let's say) it's a bit difficult to handle that.

I don't follow *that* at all.  If some driver other than
twl4030-usb registers as the system's OTG transceiver,
MUSB on OMAP3x should just use that.  All musb should do
is ask for the transceiver, and then talk to it ... but
the current code can't do that.


> I'd say your fix is good as a short term, right ?

Let's make sure it doesn't break DaVinci and TUSB first.
It'd be good to remove the musb->xceiv->state doubled
indirections in most places too, just as cleanup.

(Plus cope with the $SUBJECT issue "for real"!)


> We have already 
> blackfin support for musb and most likely they won't usb twl4030 chips,

Right.  Does Blackfin have an integrated transceiver like
DaVinci and TUSB?  Or does it use a discrete one?


> I also got a mail from another company asking about adding their musb
> glue to our code so this problem with the otg transceiver might soon be
> a big pain.
> 
> What do you say ??

I'm thinking this issue needs resolving before twl4030-usb can
go upstream.  :)

Does mainline work with tusb6010 today?  I see lots of USB
patches merged yesterday.  And enough ARM/DaVinci patches
merged (a few days back) that its MUSB might work too.

- Dave


> 
> -- 
> balbi
> 
> 


