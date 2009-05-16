From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap machine
	specific sources.
Date: Sat, 16 May 2009 08:35:16 -0700
Message-ID: <20090516153515.GL19742@atomide.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com> <20090516101106.GL15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64396 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbZEPPfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 11:35:24 -0400
Content-Disposition: inline
In-Reply-To: <20090516101106.GL15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090516 03:12]:
> On Thu, May 07, 2009 at 11:59:14AM +0530, Santosh Shilimkar wrote:
> > @@ -196,7 +199,10 @@ void __init omap2_check_revision(void)
> >  	 * At this point we have an idea about the processor revision set
> >  	 * earlier with omap2_set_globals_tap().
> >  	 */
> > -	if (cpu_is_omap24xx())
> > +	if (cpu_is_omap44xx()) {
> > +		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
> > +		return;
> > +	} else if (cpu_is_omap24xx())
> 
> Can we keep things here in numeric order?  So leave cpu_is_omap24xx()
> at the top and add the additional omap44xx stuff at the bottoom.
> 
> > @@ -30,7 +32,9 @@
> >  #include <mach/sdrc.h>
> >  #include <mach/gpmc.h>
> >  
> > +#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
> >  #include "clock.h"
> > +#endif
> 
> Hmm.  Tony: we really need to eliminate data inside header files.  It's
> not nice to have data structures created by merely including some header
> file that also contains function prototypes.

Yeh, we should just move the clocks from clock24xx.h to the top of clock24xx.c,
and the same thing for clock34xx.h. I think those are the only remaining
places with data in header files.

Regards,

Tony
