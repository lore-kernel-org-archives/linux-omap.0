From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 22:00:00 +0200
Message-ID: <20080320200000.GI4772@kedavra.cpe.vivax.com.br>
References: <87d4pqqmj2.fsf@paris.hilman.org> <200803201230.03729.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49906 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687AbYCTT5z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 15:57:55 -0400
Content-Disposition: inline
In-Reply-To: <200803201230.03729.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

On Thu, Mar 20, 2008 at 12:30:03PM -0700, David Brownell wrote:
> On Wednesday 19 March 2008, Kevin Hilman wrote:
> 
> > However, if I then plug the key back in, nothing happens.  
> > 
> > Forcing a session start via "echo 'F' > /proc/driver/musb_hdrc" causes
> > the device to be (re)detected and things look good again.  It is not
> > until I force the session start that I see the interrupt and the
> > CONNECT event.
> > 
> > Any ideas why this isn't detected on insertion?
> 
> Just for the record ... that's always been a problem.  There's
> some strange side-effect driven magic in the Mentor IP, right
> in that area, which has always been fragile.
> 
> For example, it seems to think something other than the state
> of the ID pin should control whether it's in the A-side state
> machine (default host) or the B-side one (default peripheral),
> and it gets fairly twitchey about VBUS levels too ... as in,
> it doesn't allow the specified 100 msec for it to stabilize,
> and enters a fault/shutdown mode if voltage drops because of,
> say, contact bounce or inrush current, while it stabilizes.
> 
> Needing that "force session start" is a warning flag.  The
> very notion of that kind of "session" is something introduced
> by Mentor, which is not part of the OTG spec (at least, not in
> anything like that form).  Multiple weeks have been wasted
> trying to sort out misbehavior in that area, and there seem
> to be revision-specific issues too.

Looks like code is flakey again after merging usb stuff with mainline
then?

But I tried with n800/n810 and it's working fine, this surely means the
problem resides either in drivers/usb/musb/omap2430.c or
driver/i2c/chips/twl4030-usb.c

I'm more into some flakeyness in omap2430.c as it looks like
twl4030-usb.c generates the cable insertion interrupt. Could it be some
problem in the ULPI support for omap3 that's preventing musb to wake up
and switch to host role ? Maybe we're not getting wakeup events e.g.
cable insertion interrupt is not waking up Mentor IP Core ?

Well, these still some thoughts I still need to debug more in order to
really understand the problem there.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
