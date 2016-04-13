From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Wed, 13 Apr 2016 08:28:30 -0700
Message-ID: <20160413152829.GQ5995@atomide.com>
References: <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com>
 <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com>
 <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com>
 <20160411212845.GJ5995@atomide.com>
 <570CC54E.6020703@ti.com>
 <20160412163750.GR5995@atomide.com>
 <570E3428.5020804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570E3428.5020804@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160413 04:59]:
> On 04/12/16 19:37, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [160412 02:53]:
> >> Tony,
> >>
> >> On 04/12/16 00:28, Tony Lindgren wrote:
> >>>>> Then for the long term solution using
> >>>>> PM runtime to block gating of the clock while sidetone is active is
> >>>>> the way to go it seems.
> >>>>
> >>>> Hrm, I think one of the main issue is that with pm_runtime we can not block
> >>>> the clock gating, this is why legacy code uses enable_st_clock(), which will
> >>>> call omap2_clk_deny_idle() or omap2_clk_allow_idle().
> >>>
> >>> I see. I think Tero wanted to export omap2_clk_allow_idle() and
> >>> omap2_clk_deny_idle() for drivers to use. That should get discussed in
> >>> the linux-clk list, probably best to use the pdata callbacks until
> >>> the clock idling issue has been discussed.
> >>
> >> It is already exported, used by the arch/arm/mach-omap2/mcbsp.c file.
> > 
> > Oh but not with EXPORT_SYMBOL so not usable except for built-in code.
> > Probably best to keep it that way IMO..
> 
> It is up to Tero if he want to keep omap2_clk_allow/deny_idle() only be usable
> for built in code. It is there just because of OMAP3 McBSP2/3 sidetone support
> on the other hand. It is a fair assumption that it could be used by the driver.

The problem with EXPORT_SYMBOL is that it tends to then suddenly then get
used all over the drivers. And we've seen what that means..

> >> Why not to remove the callback for legacy also and handle it in the driver? It
> >> is less ugly in my opinion.
> >> Going via the pdata callback is just going to cement the current setup.
> > 
> > Sure, maybe you can have a piece of built-in driver code to do that?
> 
> You mean something like:
> int omap3_mcbsp23_ick_for_sidetone_force(struct clk *clk, bool force_on)
> {
> 	if (!clk)
> 		return 0;
> 
> 	if (force_on)
> 		return omap2_clk_deny_idle(clk);
> 	else
> 		return omap2_clk_allow_idle(clk);
> }
> EXPORT_SYMBOL(omap3_mcbsp23_ick_for_sidetone_force);

Yeah that's something I was thinking.

> Looks similarly hackish as with the pdata callback, but if I were to choose,
> the pdata callback might be a bit more polite hack if we do not look at how we
> will have the pdata crafted for DT boot.

Well the pdata solution avoids exporting custom functions to all the
drivers.

> If we were to split the McBSP driver into half - not literally as the ST
> support has small amount of code right now, we would consider all possibility
> to not introduce regression and keep things working along the way. There will
> be a point were the code need to be shuffled..

You could just create the sidetone child device manually on probe in the
driver as needed. That way you'd have two devices to do the PM runtime
on. I think that was Paul's main concern as they are separate modules.

It still leaves the chance of bugs with flush of posted writes. But might
make things easier to deal with in small steps?

> >> I have reasonably clean patches (6 of them) on top of this three which would
> >> remove the arch code for the iclk handling and implements it in the mcbsp
> >> driver w/o changing the architecture of the McBSP driver itself. Both DT and
> >> legacy boot works. The only part I was not happy about the one where I looked
> >> up the mcbsp2/3_ick, but I think I have found much cleaner way to do it
> >> (meaning that the code will not look hackish at all).
> >> If you want to see, I can make this change and I can send the whole thing as
> >> RFC and continue the discussion around that?
> > 
> > Sure, especially if that helps with splitting up the modules too.
> 
> To start with the hwmod data is wrong for mcbsp2/3 mcbsp2/3_sidetone:
> static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
> 	.name		= "mcbsp2",
> 	.class		= &omap3xxx_mcbsp_hwmod_class,
> 	.mpu_irqs	= omap3xxx_mcbsp2_irqs,
> 	.sdma_reqs	= omap2_mcbsp2_sdma_reqs,
> 	.main_clk	= "mcbsp2_fck",
> 	.prcm		= {
> 		.omap2 = {
> 			.prcm_reg_id = 1,
> 			.module_bit = OMAP3430_EN_MCBSP2_SHIFT,
> 			.module_offs = OMAP3430_PER_MOD,
> 			.idlest_reg_id = 1,
> 			.idlest_idle_bit = OMAP3430_ST_MCBSP2_SHIFT,
> 		},
> 	},
> 	.opt_clks	= mcbsp234_opt_clks,
> 	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
> 	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
> };
> 
> static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
> 	.name		= "mcbsp2_sidetone",
> 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
> 	.mpu_irqs	= omap3xxx_mcbsp2_sidetone_irqs,
> 	.main_clk	= "mcbsp2_fck",
> 	.prcm		= {
> 		.omap2 = {
> 			.prcm_reg_id = 1,
> 			 .module_bit = OMAP3430_EN_MCBSP2_SHIFT,
> 			.module_offs = OMAP3430_PER_MOD,
> 			.idlest_reg_id = 1,
> 			.idlest_idle_bit = OMAP3430_ST_MCBSP2_SHIFT,
> 		},
> 	},
> };
> 
> The McBSP2_ST main_clk is mcbsp2_ick, not mcbsp2_fck (ch 21.3.2.2.6 in
> OMAP36xx TRM).
> The sidetone should not have prcm section at all as it does not have control
> over it's clocks in that level. Giving the same PRCM registers and bits for
> both McBSP and it's sidetone is wrong. What should be expected if McBSP is
> enabled and we disable the ST via pm_runtime? Will the hwmod toggle bits in
> PRCM? If it does, the McBSP will looses it's clocks...

I think for omap3 we're just using the clk_get/set. For omap4, the issue
is different as the clkctrl registers are used directly.

> While the McBSP and ST regions are different, the ST is part of the McBSP from
> PRCM point of view so not sure how this could be worked around with separated
> drivers.

Just create the struct device as a child for ST as needed from McBSP?

Regards,

Tony
