From: Tony Lindgren <tony@atomide.com>
Subject: Re: struct dmtimer definition not available in header file
Date: Wed, 10 Mar 2010 14:37:52 -0800
Message-ID: <20100310223752.GV2900@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB6CA@dbde02.ent.ti.com>
 <87lje0glhj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49287 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab0CJWgd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 17:36:33 -0500
Content-Disposition: inline
In-Reply-To: <87lje0glhj.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gurav , Pramod" <pramod.gurav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [100310 09:14]:
> "Gurav , Pramod" <pramod.gurav@ti.com> writes:
> 
> > Hi All,
> > I am using dmtimer in my code. Code looks like this:
> >
> > {
> >         static struct omap_dm_timer *gpt;
> >         void * __iomem gpt10_counter_reg;
> >         unsigned long gpt_phys_base;
> >
> >         omap_dm_timer_init();
> >         gpt = omap_dm_timer_request();
> >         if (!gpt) {
> >                 pr_err("Could not get the gptimer\n");
> >                 return -1;
> >         }
> >         omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> >
> >         gpt_phys_base = gpt->phys_base;
> >
> >         gpt10_counter_reg =
> >                         OMAP2_L4_IO_ADDRESS(gpt_phys_base +
> >                                         OMAP_TIMER_COUNTER_OFFSET);

We should use ioremap for allthings like this nowadays.
There are static mappings in place for that.

> >         gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
> >         omap_dm_timer_set_load_start(gpt, 0, 0);
> > 	
> > 	.
> > 	.
> > 	.
> > }
> >
> > I am not able to reference *gpt as the file does not know about struct omap_dm_timer. I have included plat/dmtimer.h.
> >
> > Why doesn't the dmtimer struct definition appear in plat/dmtimer.h ?
> > Is there any reason for this?
> 
> The declaration appears there, but the definition is hidden.
> 
> In fact, it is is hidden to prevent exactly the type of thing you're
> trying to do, and to provide all access to DM timer details via the DM
> timer API.
> 
> Looking at your example, I'm guessing you're trying to implement one
> of my ideas for the SDRC delay calculation by passing the base address
> to the assembly routine.
> 
> As I suggested in my original patch, the better way to do this would
> be to extend the dmtimer API, and use C instead of assembly.

And if it's generic code, you're better off using Linux hrtimers
instead. Otherwise there's a good chance your timer won't wake up
the system from the idle mode and you miss the timer events.

Regards,

Tony
