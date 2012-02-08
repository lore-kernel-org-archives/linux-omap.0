From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 16/16] ARM: omap: disable cpuidle for OMAP3 platforms
Date: Wed, 8 Feb 2012 22:59:23 +0000
Message-ID: <20120208225923.GB25414@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk> <E1RvAZz-0006Hr-9C@rmk-PC.arm.linux.org.uk> <20120208185905.GP29796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35477 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573Ab2BHW7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 17:59:33 -0500
Content-Disposition: inline
In-Reply-To: <20120208185905.GP29796@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 08, 2012 at 10:59:06AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:10]:
> > Commit 2fd149645eb4 (ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos)
> > has caused a regression on OMAP3 platforms.
> > 
> > When the UART is trying to transmit data, if we enter a low power mode,
> > transmission stops, which makes serial on OMAP3 unusable - a 'dmesg'
> > takes five minutes to be output at 115200 baud, at a rate of around a
> > block of 16 characters every couple of seconds.
> > 
> > Unfortunately, the commit above can't be reverted because of many other
> > changes in this area, so this implements a dirty fix by disabling
> > CPU idle in the places the original commit does, irrespective of the
> > UART state.
> ...
> 
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -421,7 +421,7 @@ static void omap3_pm_idle(void)
> >  	local_irq_disable();
> >  	local_fiq_disable();
> >  
> > -	if (omap_irq_pending() || need_resched())
> > +	if (omap_irq_pending() || need_resched() || 1)
> >  		goto out;
> >  
> >  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> 
> Argh, this is just too ugly. There has got to be a better fix for the
> -rc series.

That I'd agree on - because it is ugly and it's the best I could do
to revert the commit mentioned above short of reverting a whole raft
of other useful looking commits.

There's got to be a better solution.

> Looks like the patches to fix omap-serial.c are queued for v3.4,
> so that won't help.

Well, the fact of the matter is this is a regression, which means it
needs fixing for v3.3.  A simple patch would be preferred over more
complex patches.

So, if there's no other solution but to put the omap-serial patches
in for v3.3, then that's the best solution for v3.3.  First, someone
who understands this code needs to see whether there is a simpler
fix (eg, putting back what was there in a simpler form.)

However, leaving it in its current state for v3.3 is not acceptable.
