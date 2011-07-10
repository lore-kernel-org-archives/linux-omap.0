From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Use MMIO clocksource for 32kHz counter
Date: Sun, 10 Jul 2011 15:15:37 +0100
Message-ID: <20110710141537.GB4957@n2100.arm.linux.org.uk>
References: <20110627123315.GB1777@n2100.arm.linux.org.uk> <20110627123754.GQ23145@atomide.com> <20110627191102.GV23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42501 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab1GJOP7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 10:15:59 -0400
Content-Disposition: inline
In-Reply-To: <20110627191102.GV23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 27, 2011 at 12:11:02PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [110627 05:33]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110627 05:28]:
> > > --- a/arch/arm/plat-omap/counter_32k.c
> > > +++ b/arch/arm/plat-omap/counter_32k.c
> > > +#ifdef CONFIG_ARCH_OMAP16XX
> > > +		else if (cpu_is_omap16xx())
> > > +			base = OMAP2_L4_IO_ADDRESS(OMAP16XX_TIMER_32K_SYNCHRONIZED);
> 
> BTW, the above should have been OMAP1_IO_ADDRESS instead..
>   
> > You should be able to replace the above with just ioremap as we now
> > have the static mappings.
> 
> ..here's a patch to use ioremap with comment added about the static
> mapping requirements.
> 
> Thanks for getting rid of hopefully the last remaining omap_readl
> for omap2+ BTW :)

What're we doing with this patch and your follow-up patch?
