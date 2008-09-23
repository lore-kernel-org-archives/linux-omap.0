From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Tue, 23 Sep 2008 14:00:02 +0300
Message-ID: <20080923110001.GL5102@atomide.com>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com> <200809201022.49350.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52122 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYIWLAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 07:00:16 -0400
Content-Disposition: inline
In-Reply-To: <200809201022.49350.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: arun c <arunedarath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [080920 20:23]:
> On Friday 19 September 2008, arun c wrote:
> > without this the below error messages were coming continuously
> > 
> > TWL4030 module irq 369 is disabled but can't be masked!
> 
> I can see how it would fix that.  :)
> 
> But this is also a good illustration of why this keypad device
> should be initialized differently ... this particular data is
> not board-specific, and the root cause of the problem was that
> the device wasn't set up as part of twl4030 setup.
> 
> The clean fix requires twl4030 to be a "new style" driver.
> Fix not yet available. :(

Pushing until we have a better fix.

Tony

> 
> - Dave
> 
> 
> > Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> > b/arch/arm/mach-omap2/board-omap3evm.c
> > index 92f70ce..f9fd06b 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/input.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/spi/ads7846.h>
> > +#include <linux/i2c/twl4030.h>
> > 
> >  #include <mach/hardware.h>
> >  #include <asm/mach-types.h>
> > @@ -176,6 +177,7 @@ static struct omap_kp_platform_data omap3evm_kp_data = {
> >  	.keymap 	= omap3evm_keymap,
> >  	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
> >  	.rep		= 1,
> > +	.irq		= TWL4030_MODIRQ_KEYPAD,
> >  };
> > 
> >  static struct platform_device omap3evm_kp_device = {
> > -- 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
