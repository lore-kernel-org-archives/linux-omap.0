From: Tony Lindgren <tony@atomide.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Thu, 3 Dec 2009 11:52:44 -0800
Message-ID: <20091203195243.GA4348@atomide.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
 <1259599010.4649.51.camel@thunk>
 <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
 <20091130194031.GV4348@atomide.com>
 <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
 <20091203010051.GP4348@atomide.com>
 <20091203065651.GH17675@esdhcp04058.research.nokia.com>
 <1259830011.10805.60.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49236 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938AbZLCTwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 14:52:49 -0500
Content-Disposition: inline
In-Reply-To: <1259830011.10805.60.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, Grant Likely <grant.likely@secretlab.ca>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@deeprootsystems.com>

* Artem Bityutskiy <dedekind1@gmail.com> [091203 00:46]:
> On Thu, 2009-12-03 at 08:56 +0200, Mika Westerberg wrote:
> > On Thu, Dec 03, 2009 at 02:00:52AM +0100, ext Tony Lindgren wrote:
> > > * Grant Likely <grant.likely@secretlab.ca> [091202 07:06]:
> > > > On Mon, Nov 30, 2009 at 12:40 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > > > * Grant Likely <grant.likely@secretlab.ca> [091130 09:01]:
> > > 
> > > <snip>
> > > 
> > > > >
> > > > > maybe you've already thought through all this.. But would it be
> > > > > possible to do lightweight device tree that we just use to populate
> > > > > the platform data?
> > > > 
> > > > This is completely possible.  Just having the device tree available
> > > > doesn't force the kernel to use it for everything.  I've found it
> > > > useful to start small and add things as I need them.  Most important
> > > > thing to remember is to follow the documented & established device
> > > > tree conventions so that common code can understand it.
> > > 
> > > OK, sounds good to me.
> > 
> > Hi,
> > 
> > This device tree stuff sounds like very cool way of doing things. Hope
> > it is ready soon :)
> > 
> > Meanwhile, would it be OK to implement something to get the serial driver
> > taking control of the all the UARTs? Any comments on adding new function
> > to mach-omap2/serial.c: omap_serial_init_port(int port) that could be
> > used from board files instead of omap_serial_init()?
> 
> Device tree is really promising, but we do need an alternative method
> anyway, because not everyone will use the device tree. IOW, device tree
> does not exist yet, and will not be mandatory, so an alternative is
> required.

Right, it sounds like the device tree won't solve all the issues.

But before we change anything with the mach-omap2/serial.c, let's wait
until we hear comments from Kevin.

Regards,

Tony
