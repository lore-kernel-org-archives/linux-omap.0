From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the
 display options
Date: Thu, 28 Mar 2013 14:28:38 -0700
Message-ID: <20130328212837.GY10155@atomide.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
 <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com>
 <51546B2C.2030101@compulab.co.il>
 <20130328165336.GW10155@atomide.com>
 <515479F6.9090005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44866 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753543Ab3C1V2l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 17:28:41 -0400
Content-Disposition: inline
In-Reply-To: <515479F6.9090005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130328 10:16]:
> On 2013-03-28 18:53, Tony Lindgren wrote:
> > 
> > Yes that's not nice from usability point of view. Can we still switch
> > between LCD and DVI during the runtime? I thought the issue was registering
> > multiple LCD panels where only one can exist at a time?
> 
> I guess I could've been more verbose in my descriptions. And I agree
> this is not a nice change.
> 
> No, we can't switch between the LCD and DVI. But that's not strictly DSS
> issue. The selection between LCD and DVI (or any other displays on the
> same bus) are board specific things, sometimes requiring board specific
> gpios or even things like i2c commands to muxes.
> 
> It works now because we have custom callbacks in the board files to do
> those things, but it'll break with DT.

Well people are already used to changing between LCD and DVI.. So we
need some way of doing it with DT also.

How do you plan to change between LCD and DVI with DT? By using some
custom driver modules?

There's the capebus coming that can be used for that too, but in most
cases all the hardware is permanently connected with LCD and DVI. So
sounds like capebus should only be needed for the add on boards.
 
> >> I bet there must be a much better solution for DT support.
> > 
> > Well the best legacy support option would be some fbdev/panel generic cmdline
> > option to specify which one to use. Maybe there is already something like
> > that available that the board-*.c files can parse and can be used also
> > later on with DT support to specify the preferred output?
> > 
> > What we don't want to do is add a board specific cmdline option as the
> > board-*.c files will be going away as soon as DT is usable for us and we
> > don't want to support a board specific cmdline after that. But if it's
> > a generic option then parsing it in the board-*.c file or the driver later
> > on can be supported.
> > 
> > Of course for some cases it might be possible to detect the configured
> > panel based on what's plugged in over i2c.
> 
> I could look at using omapdss's module parameter for this. It has
> default display parameter. Perhaps the board files could parse this, and
> use it to decide which display to register. Perhaps that'd cause less
> inconvenience.
> 
> It's still quite hacky, as you can only select one display. If there's a
> board with two video outputs, and, say, 2 displays connected to each.
> You can only select the display for one of the busses. Anyway, we don't
> have that kind of board in the mainline, so it's not an issue.

If we can use omapdss cmdline params for initializing the selected display,
that allows leaving out the kconfig selection, so that's much nicer for
distros etc.

