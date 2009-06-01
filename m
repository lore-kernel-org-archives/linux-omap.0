From: Tony Lindgren <tony@atomide.com>
Subject: Re: LDP support
Date: Mon, 1 Jun 2009 09:00:33 -0700
Message-ID: <20090601160032.GA4825@atomide.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090531212449.GD25140@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50883 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbZFAQAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 12:00:41 -0400
Content-Disposition: inline
In-Reply-To: <20090531212449.GD25140@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090531 14:25]:
> On Tue, Apr 28, 2009 at 03:42:37PM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090428 15:07]:
> > > Tony, et.al.,
> > > 
> > > Any ideas when more LDP support will be pushed into mainline (such as
> > > the framebuffer support)?
> > 
> > I'll be looking at the board-*.c patches for the next merge window
> > hopefully this week or next week.
> > 
> > Looks like LDP keyboard, touchscreen & RTC are pretty much ready
> > to go. Then the MMC has some regulator updates, but AFAIK the MMC
> > should work OK already.
> > 
> > For the framebuffer, Imre and Tomi know the status the best, so
> > I've added them to Cc.
> > 
> > Imre has been meaning to send a bunch of drivers/video/omap changes
> > to the fbdev list for a while now and LDP framebuffer may depend on
> > those. Imre, any news on the status of sending the fb patches
> > upstream?
> > 
> > Then there are the upcoming DSS patches from Tomi, but those still
> > need some work before they're ready to go.
> 
> Okay, now that I've merged your tree, we've moved a few steps forward but
> a couple of steps backward with LDP support:
> 
> 1. LDP LCD platform device added
> 2. GPIO keyboard platform data added
> 3. TWL4030 keyboard platform data added
> 4. TSC2046 touchscreen platform data added
> 5. MMC has regressed - no sign of the driver initializing, not even an
>    error message from it, so I can't boot to check what the status of
>    these are.

Do you have CONFIG_REGULATOR set in your .config? That seems to be missing
from arch/arm/configs/omap_ldp_defconfig.

> 6. do ___NOT___ (underscored in triplicate and 500ft high letters) enable
>    ARM errata 460075 - it solidly prevents the kernel booting on LDP.
>    (it's taken many hours to debug that.)
> 
> However, things that still seem to be missing:
> 
> 1. GPIO keyboard (presumably) needs to be enabled in omap_ldp_defconfig

Anybody with an LDP care to update the omap_ldp_defconfig? No LDP here.

> 2. No TWL4030 keyboard driver merged (not even in linux-next)
> 3. No LDP LCD driver merged
> 4. No OMAP3 video driver

For 3 & 4, I know Imre has the patches ready to go.. Imre, have they been
posted to the fb list?

> 5. No sound?

This could be pretty easy now with the ASoC driver, anybody seen a driver
fro this?
 
> Any ideas what's happening with these?  Will they make the next merge
> window (which is possibly about a week away) - I guess not. :(

Well sounds like the defconfig fixes, keyboard, and fb updates still have
a chance to get in.

Tony
