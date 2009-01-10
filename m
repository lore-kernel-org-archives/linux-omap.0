From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Sat, 10 Jan 2009 16:20:48 +0000
Message-ID: <20090110162048.GA1327@n2100.arm.linux.org.uk>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090110155612.GA2601@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53657 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZAJQVE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 11:21:04 -0500
Content-Disposition: inline
In-Reply-To: <20090110155612.GA2601@sortiz.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>

On Sat, Jan 10, 2009 at 04:56:12PM +0100, Samuel Ortiz wrote:
> Hi Tony,
> 
> On Wed, Jan 07, 2009 at 01:16:15PM +0200, Tony Lindgren wrote:
> > diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> > index b59c385..18179ac 100644
> > --- a/drivers/mfd/twl4030-core.c
> > +++ b/drivers/mfd/twl4030-core.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/i2c/twl4030.h>
> >  
> > +#include <mach/cpu.h>
> That will break the build on !ARM for this driver.

... which in itself is an argument for making it use the clk API
properly so that these kinds of CPU specific dependencies are kept
out of the driver.

In other words:

        if (cpu_is_omap2430())
                osc = clk_get(NULL, "osc_ck");
        else
                osc = clk_get(NULL, "osc_sys_ck");

becomes:

        osc = clk_get(dev, "hfclk");

since "hfclk" is the name of the input on the device, or it should be
NULL if it is the only input on the device (iow, you don't want to
distinguish it from the 32kHz clock.)

And that eliminates the need for any platform specific includes (which
is the whole point of the clk API - giving drivers a _generic_ way to
get at clock information without resorting to platform specific crap.)
