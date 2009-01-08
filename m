From: Tony Lindgren <tony@atomide.com>
Subject: Re: About to tag v2.6.28-omap1 on Friday
Date: Thu, 8 Jan 2009 14:16:30 +0200
Message-ID: <20090108121629.GC27566@atomide.com>
References: <1231410153.13843.46.camel@eenurkka-desktop> <20090108111201.GZ27566@atomide.com> <1231416745.13843.50.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53372 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbZAHMQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 07:16:31 -0500
Content-Disposition: inline
In-Reply-To: <1231416745.13843.50.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org

* Eero Nurkkala <ext-eero.nurkkala@nokia.com> [090108 14:14]:
> >From clock34xx.h I find them having parents:
> (but of course I'm possibly talking about something else
>  you're meaning =)

Yeah, the problem is caused by arch/arm/mach-omap2/mcbsp.c
registering custom clocks that have no parent.

Tony

> 
> 
> static struct clk mcbsp2_ick = {
> 	.name		= "mcbsp_ick",
> 	.id		= 2,
> 	.parent		= &per_l4_ick,
> 	.prcm_mod	= OMAP3430_PER_MOD,
> 	.enable_reg	= CM_ICLKEN,
> 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
> 	.idlest_bit	= OMAP3430_ST_MCBSP2_SHIFT,
> 	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
> 	.clkdm		= { .name = "per_clkdm" },
> 	.recalc		= &followparent_recalc,
> };
> 
> static const struct clksel mcbsp_234_clksel[] = {
> 	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
> 	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
> 	{ .parent = NULL }
> };
> 
> static struct clk mcbsp2_src_fck = {
> 	.name		= "mcbsp_src_fck",
> 	.id		= 2,
> 	.prcm_mod	= CLK_REG_IN_SCM,
> 	.init		= &omap2_init_clksel_parent,
> 	.clksel_reg	= OMAP2_CONTROL_DEVCONF0,
> 	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
> 	.clksel		= mcbsp_234_clksel,
> 	.flags		= CLOCK_IN_OMAP343X,
> 	.clkdm		= { .name = "per_clkdm" },
> 	.recalc		= &omap2_clksel_recalc,
> };
> 
> static struct clk mcbsp2_fck = {
> 	.name		= "mcbsp_fck",
> 	.id		= 2,
> 	.parent		= &mcbsp2_src_fck,
> 	.prcm_mod	= OMAP3430_PER_MOD,
> 	.enable_reg	= CM_FCLKEN,
> 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
> 	.idlest_bit	= OMAP3430_ST_MCBSP2_SHIFT,
> 	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
> 	.clkdm		= { .name = "per_clkdm" },
> 	.recalc		= &omap2_clksel_recalc,
> };
> 
> On Thu, 2009-01-08 at 13:12 +0200, ext Tony Lindgren wrote:
> > * Eero Nurkkala <ext-eero.nurkkala@nokia.com> [090108 12:25]:
> > > > Looks like we now have some McBSP clock issue probably related
> > > > to the custom clock:
> > > 
> > > Could you please try:
> > > http://marc.info/?l=linux-omap&m=122597514326263&w=2
> > > 
> > > And possibly ack the patch?
> > 
> > Well this has been on hold as we don't know yet if we should
> > use or not use custom clocks.
> > 
> > Custom clocks allow combining multiple clocks into a single clock,
> > which makes it easy to use in the drivers. However, custom clocks
> > have some problems that Paul has pointed out, like not knowing
> > the parent.
> > 
> > At this point I'd say that if Paul does not like custom clocks,
> > we should stop using them. Up to Paul to decide me thinks unless
> > somebody has better ideas.
> > 
> > > McBSP has a known spin-lock deadlock, why carry it around?
> > 
> > Would be nice to get rid of the spin-lock issue.. But this patch
> > still does not help with the McBSP clocks failing because the
> > parent is not known.
> > 
> > Regards,
> > 
> > Tony
> 
