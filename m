From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Thu, 8 Nov 2012 08:20:05 -0800
Message-ID: <20121108162004.GA6801@atomide.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <20121107173343.GF6801@atomide.com>
 <509B5B84.50605@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16017 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756278Ab2KHQUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 11:20:11 -0500
Content-Disposition: inline
In-Reply-To: <509B5B84.50605@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

* Igor Grinberg <grinberg@compulab.co.il> [121107 23:15]:
> On 11/07/12 19:33, Tony Lindgren wrote:
> > 
> > I think this should be the default for the timers as that counter
> > does not stop during deeper idle states.
> 
> Well, it is the default as you can see from the patch.
> The problem is that for boards that for some reason do not have
> the 32k wired and rely on MPU/GP timer source, the default will not work
> and currently there is no way for board to specify which timer source
> it can use.

Yes. I was just wondering if we can avoid patching all the board
files by doing it the other way around by introducing a new
omap_gp_timer rather than renaming all the existing ones?

> We have discussed this in San Diego (remember?) and you actually proposed
> this way as a solution. Well, may be I took it a bit further than you
> thought, but this is because the board code cannot know which timer source
> should be used at runtime and the fall back described below, does not work.

Yes thanks I agree we should get rid of that Kconfig option for sure. 

> >> --- a/arch/arm/mach-omap2/board-2430sdp.c
> >> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> >> @@ -284,6 +284,6 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
> >>  	.handle_irq	= omap2_intc_handle_irq,
> >>  	.init_machine	= omap_2430sdp_init,
> >>  	.init_late	= omap2430_init_late,
> >> -	.timer		= &omap2_timer,
> >> +	.timer		= &omap2_sync32k_timer,
> >>  	.restart	= omap_prcm_restart,
> >>  MACHINE_END
> >> --- a/arch/arm/mach-omap2/board-3430sdp.c
> >> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> >> @@ -596,6 +596,6 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
> >>  	.handle_irq	= omap3_intc_handle_irq,
> >>  	.init_machine	= omap_3430sdp_init,
> >>  	.init_late	= omap3430_init_late,
> >> -	.timer		= &omap3_timer,
> >> +	.timer		= &omap3_sync32k_timer,
> >>  	.restart	= omap_prcm_restart,
> >>  MACHINE_END
> > ...
> > 
> > Can't we assume that the default timer is omap[234]_sync32k_timer to
> > avoid renaming the timer entries in all the board files?
> 
> Hmmm...
> How will this work with the macros defining the sys_timer structure?
> I would also not want to hide the exact timer used under the default name.

Can't you just add a new sys_timer (or a new macro) for GP only setups? 
 
> > Then we just need a new timer entries for the hardware that does
> > not have the sycn32k_timer available?
> 
> Well, I tried to make it small patch just for the hardware that needs it,
> but I always found some corner case where, IMHO, this does not work/look good.

Can you explain a bit further?

I guess what I'm after is just to avoid renaming the existing
timers in the board-*.c files and only rename the ones that
need gp timer only.

Regards,

Tony
