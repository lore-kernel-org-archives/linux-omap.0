From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP display subsystem - does it work?
Date: Thu, 19 Dec 2013 17:56:44 +0000
Message-ID: <20131219175644.GE32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55417 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab3LSR5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 12:57:21 -0500
Content-Disposition: inline
In-Reply-To: <20131218180240.GG27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Dec 18, 2013 at 10:23:54AM -0800, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131218 05:56]:
> > I don't have an LDP board at hand, and I wasn't able to find out anything from
> > the logs.
> > 
> > I think I should change omapfb to print something if it's probed succesfully,
> > as the deferred probing makes finding out if something is probed fine or not
> > quite murky. Without deferred probing, it was simpler: no errors -> the driver
> > must be (most likely) ok.
> > 
> > Although... In an earlier log, where there was no panel driver, the log has
> > these errors:
> > 
> > Error opening /dev/fb0: No such device
> > 
> > There are none in the latest log, which makes me guess the omapfb has been
> > probed, and fb0 is actually there. But the X is still dying for some reason...
> > 
> > I'll look at this more. Maybe someone in our team can find a board to test.
> 
> Hmm I had the framebuffer working with DT on LDP after fixing the twl4030
> gpio regression with 0b2aa8bed3e1 (gpio: twl4030: Fix regression for twl
> gpio output) using this pdata quirks patch:
> 
> [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and make omap3 LDP to use it
> 
> AFAIK the pdata hack above should not be needed now, but I have not tried
> with Tomi's DSS DT patches yet.
> 
> Tomi do you have some sample panel dpi .dts entry somewhere for the LDP I
> could try at some point?
> 
> Russell, maybe all you're missing is just omapfb.vram=0:2M,1:5M or similar
> from your kernel cmdline?

Note that I'm trying to get non-DT stuff working properly here first, in
such a state that it has done in the past with mainline kernels.  This is
quite an old regression, but it's still a regression nevertheless.

I've just built and booted a kernel with the backlight support in.  No
change.
