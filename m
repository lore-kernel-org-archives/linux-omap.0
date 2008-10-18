From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix bootup crash for LDP platform
Date: Sat, 18 Oct 2008 22:43:14 +0300
Message-ID: <20081018194304.GP31842@frodo>
References: <1224284642-13863-1-git-send-email-vikram.pandita@ti.com> <20081017235020.GM31842@frodo> <20081018135642.GP18573@atomide.com> <200810181228.09194.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36676 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYJRTnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 15:43:32 -0400
Content-Disposition: inline
In-Reply-To: <200810181228.09194.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Oct 18, 2008 at 12:28:08PM -0700, David Brownell wrote:
> On Saturday 18 October 2008, Tony Lindgren wrote:
> > Pushed. I hope you have a real fix for this coming from mainline soon :)
> 
> There's a general issue to sort out here too.
> 
> The early development of the MUSB code was on DaVinci, and
> then TUSB6010, which integrate (a) an OTG transceiver, plus
> (b) the OTG hardware.  So musb_hdrc currently presumes it
> always works that way.
> 
> However, OMAP3 (and 2430) split out (a) into the TWL4030
> or TWL5030 chip, leaving (b) integral to the MUSB silicon.
> 
> But the MUSB code only accomodates that through a hack ...
> in musb/omap2430.c is the line which I suspect oopsed:
> 
> 	musb->xceiv = *x;
> 
> So when the twl4030 transceiver support does its thing,
> it does it to the original otg_transceiver struct instead
> of the copy being used by the MUSB core.  Wrong!!!
> 
> Partial fixup patch appended; doesn't resolve $SUBJECT
> issue, I think, but it's in the right direction.

Looks fine. I recall talking to you about this some months ago but my
approach was about introducing a drivers/usb/otg layer to which we would
usb_otg_register_driver() or something similar thus allowing musb (or
any other consumer) just use the otg_tranceiver that is registered now.

The good thing about it is that it would allow us to switch otg
transceivers and not have to add aditional conditional code to handle
it.

Your approach looks good but case we have to change the transceiver (not
twl4030-usb, let's say) it's a bit difficult to handle that.

I'd say your fix is good as a short term, right ? We have already
blackfin support for musb and most likely they won't usb twl4030 chips,
I also got a mail from another company asking about adding their musb
glue to our code so this problem with the otg transceiver might soon be
a big pain.

What do you say ??

-- 
balbi
