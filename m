From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Wed, 23 May 2012 08:51:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205230843260.3085@utopia.booyaka.com>
References: <cover.1335941443.git.afzal@ti.com> <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com> <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205080915220.9984@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A93E98A2F3@DBDE01.ent.ti.com> <alpine.DEB.2.00.1205212344460.1275@utopia.booyaka.com> <20120522164215.GE16308@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57687 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab2EWOvK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 May 2012 10:51:10 -0400
In-Reply-To: <20120522164215.GE16308@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, khilman@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 22 May 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120521 23:51]:
> > 
> > Next, I'd suggest implementing the code to allow GPMC timing configuration 
> > from raw register data (the second method above).  This is hackish but for 
> > some boards, this is all we'll have.  This will also presumably require 
> > some extra DT bindings for the register data.  If this method is used, 
> > this code should also call a PM function to block clock rate changes on 
> > the GPMC clock, and an explanatory warning should be logged to the 
> > console.
> 
> Also something to note here is that generating dynamic timings from the
> fixed GPMC register values won't work for other frequencies.
> 
> As far as I remember, the main problem trying to convert fixed value
> GPMC timings into dynamic timings is the fact that some GPMC values
> calculated depend on clock cycles, while other values depend on time.
> 
> So the cycle values remain unknown trying to upsample from fixed timings.

Yep indeed.  That's why clock rate changes have to be blocked on the GPMC 
clock.  If we don't have GPMC clock rate-independent timing data, then 
I think we'll have to keep the GPMC clock rate fixed.

> > For boards that we don't have access to, and all someone would have are 
> > the register values set by the bootloader, I'd propose a phased approach:
> > 
> > 1. The kernel should log the bootloader-provided GPMC timing registers to 
> > the console during boot, along with a warning message that indicates that 
> > GPMC for these boards will cease to function in the near future unless 
> > patches are provided to update the kernel board file and/or DT data with 
> > the GPMC register contents.  This should allow people who have those 
> > boards and who care about them to submit kernel patches to allow the 
> > GPMC-attached devices to continue to function.
> 
> Unfortunately for many of the older boards these values will probably
> remain unknown.
> 
> So the better approach here is to just disable frequency scaling
> for these cases. Otherwise we'll be breaking old boards with smsc911x
> where the timings for the FPGA controlling smsc911x are unknown.
> 
> If we somehow manage to get those values without breaking support for
> these boards, then yes I agree we should deprecate hardcoded and
> bootloader values.

I was thinking that if we log the register values supplied by the 
bootloader to the console, then someone can write a patch to the board 
file or DT data to set those register values explicitly in the kernel, 
once they're known.  Or at least just report them to the l-o list.

So then that should reduce the problem cases down to boards which no one 
reports the data to the mailing list within a few mainline kernel releases 
-- i.e., boards which are unmaintained.  For those boards, I'd suggest 
that we just drop GPMC support until someone shows up who has a board and 
can test-boot it.  Or just drop the board completely ;-)


- Paul
