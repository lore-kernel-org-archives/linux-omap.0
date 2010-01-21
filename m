From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization
 delay
Date: Wed, 20 Jan 2010 22:35:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202232320.24456@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E2C2@dbde02.ent.ti.com> <87vdfebzqa.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59444 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab0AUFfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 00:35:20 -0500
In-Reply-To: <87vdfebzqa.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Teerth,

any update on Kevin's comments?

This patch shouldn't use a hardcoded value.  Please explain further why
that formula can't be included...

- Paul


On Wed, 6 Jan 2010, Kevin Hilman wrote:

> "Reddy, Teerth" <teerth@ti.com> writes:
> 
> > From e5e82efbf6f736984668cc5e94d62635ed4de05e Mon Sep 17 00:00:00 2001
> > From: Teerth Reddy <teerth@ti.com>
> > Date: Wed, 23 Dec 2009 18:40:34 +0530
> > Subject: [PATCH] Dynamic Calculation of SDRC clock stabilization delay
> 
> Subject prefix should probably be 'OMAP3: SDRC:'.
> 
> > The patch has the changes to calculate the dpll3 clock
> > stabilization delay dynamically. The SRAM delay is
> > calibrated during bootup using the gptimers and used while
> > calculating the stabilization delay. 
> 
> Thanks for the update using the GPtimer.  I think this simplifies
> things quite a bit in terms of upstream code, however there are a
> couple of new snags.  More below...
> 
> > By using the dynamic
> > method the dependency on the type of cache being used is
> > removed. Hence there is no need of loop based calculation.
> >
> > TO DO: However the value of 6us for SDRC to stabilize has
> > been hardcoded currently. The formula used to calculate
> > this value gives a very small number thus causing
> > instability. The right formula will be used which will
> > work across all boards.
> 
> Can you explain which platforms the hard-coded value should work for
> and how that value was determined?
> 
> Also, should we be expecting another patch for this 'TO DO' part.
> To me this is a problem that prevents merging this patch.
> 
> > Signed-off-by: Teerth Reddy <teerth@ti.com>
> > Signed-off-by: Romit Dasgupta <romit@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c        |   21 +++++++++------
> >  arch/arm/mach-omap2/clock34xx.h        |    2 +
> >  arch/arm/mach-omap2/clock34xx_data.c   |    4 +++
> >  arch/arm/mach-omap2/sram34xx.S         |   25 ++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/sram.h |    5 +++
> >  arch/arm/plat-omap/sram.c              |   43 ++++++++++++++++++++++++++++++++
> >  6 files changed, 91 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> > index d9329e2..6d87419 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -56,9 +56,18 @@
> >   */
> >  #define DPLL5_FREQ_FOR_USBHOST		120000000
> >  
> > +/*
> > + * SDRC_TIME_STABILIZE: Time for SDRC to stabilize in us
> > + * TO DO: Use formula to calculate across all platforms
> > + */
> > +#define		SDRC_TIME_STABILIZE	6
> > +
> >  /* needed by omap3_core_dpll_m2_set_rate() */
> >  struct clk *sdrc_ick_p, *arm_fck_p;
> >  
> > +/* SRAM delay required for sdrc clk stab delay calculation */
> > +unsigned int delay_sram;
> > +
> 
> Please get rid of the global variable and get the delay value
> by calling a function that returns the value.  Also, please
> be sure to do this with SMP in mind.
> 
> >  /**
> >   * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
> >   * @clk: struct clk * being enabled
> > @@ -215,16 +224,10 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
> >  		unlock_dll = 1;
> >  	}
> >  
> > -	/*
> > -	 * XXX This only needs to be done when the CPU frequency changes
> > -	 */
> > +	/* Calculate the number of MPU cycles to wait for SDRC to stabilize */
> > +
> >  	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
> > -	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
> > -	c += 1;  /* for safety */
> > -	c *= SDRC_MPURATE_LOOPS;
> > -	c >>= SDRC_MPURATE_SCALE;
> > -	if (c == 0)
> > -		c = 1;
> > +	c = ((SDRC_TIME_STABILIZE * _mpurate) / (delay_sram * 2));
> >  
> >  	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
> >  		 validrate);
> > diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> > index 9a2c07e..1bc5044 100644
> > --- a/arch/arm/mach-omap2/clock34xx.h
> > +++ b/arch/arm/mach-omap2/clock34xx.h
> > @@ -21,4 +21,6 @@ extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
> >  extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
> >  extern const struct clkops clkops_noncore_dpll_ops;
> >  
> > +extern unsigned int delay_sram;
> > +
> >  #endif
> > diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
> > index 8bdcc9c..e5d0941 100644
> > --- a/arch/arm/mach-omap2/clock34xx_data.c
> > +++ b/arch/arm/mach-omap2/clock34xx_data.c
> > @@ -22,6 +22,7 @@
> >  
> >  #include <plat/control.h>
> >  #include <plat/clkdev_omap.h>
> > +#include <plat/sram.h>
> >  
> >  #include "clock.h"
> >  #include "clock34xx.h"
> > @@ -3285,5 +3286,8 @@ int __init omap2_clk_init(void)
> >  	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
> >  	arm_fck_p = clk_get(NULL, "arm_fck");
> >  
> > +	/* Measure sram delay */
> > +	delay_sram = measure_sram_delay(10000);
> > +	pr_debug("SRAM delay: %d\n", delay_sram);
> >  	return 0;
> >  }
> > diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> > index de99ba2..b4fba50 100644
> > --- a/arch/arm/mach-omap2/sram34xx.S
> > +++ b/arch/arm/mach-omap2/sram34xx.S
> > @@ -68,6 +68,10 @@
> >  /* CM_CLKSEL1_PLL bit settings */
> >  #define CORE_DPLL_CLKOUT_DIV_SHIFT	0x1b
> >  
> > +#define	GPTIMER10_TCRR_PHY			0x48086028
> > +
> > +#define	GPTIMER10_TCRR	OMAP2_L4_IO_ADDRESS(GPTIMER10_TCRR_PHY)
> > +
> >  /*
> >   * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
> >   *
> > @@ -313,3 +317,24 @@ core_m2_mask_val:
> >  ENTRY(omap3_sram_configure_core_dpll_sz)
> >  	.word	. - omap3_sram_configure_core_dpll
> >  
> > +ENTRY(__sram_wait_delay)
> > +	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
> > + 	ldr	r2, gptimer10_counter
> > +	ldr	r3, [r2]
> > +
> > +loop1:
> > +	subs 	r0, r0, #1
> > +	bne	loop1
> > +
> > +	isb
> > +	ldr	r4, [r2]
> > +	subs	r5, r4, r3
> > +
> > +	mov 	r0, r5 			@ return value
> > +	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
> > +
> > +gptimer10_counter:
> > +	.word	GPTIMER10_TCRR
> > +
> > +ENTRY(__sram_wait_delay_sz)
> > +	.word	. - __sram_wait_delay
> > diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
> > index 16a1b45..7d0be2a 100644
> > --- a/arch/arm/plat-omap/include/plat/sram.h
> > +++ b/arch/arm/plat-omap/include/plat/sram.h
> > @@ -69,6 +69,11 @@ extern u32 omap3_sram_configure_core_dpll(
> >  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
> >  extern unsigned long omap3_sram_configure_core_dpll_sz;
> >  
> > +extern unsigned int measure_sram_delay(unsigned int);
> > +
> > +extern u32 __sram_wait_delay(unsigned int);
> > +extern unsigned long __sram_wait_delay_sz;
> > +
> >  #ifdef CONFIG_PM
> >  extern void omap_push_sram_idle(void);
> >  #else
> > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > index d8d5094..ddbdaaf 100644
> > --- a/arch/arm/plat-omap/sram.c
> > +++ b/arch/arm/plat-omap/sram.c
> > @@ -30,6 +30,9 @@
> >  #include <plat/cpu.h>
> >  #include <plat/vram.h>
> >  
> > +#include <linux/clk.h>
> > +#include <plat/dmtimer.h>
> > +
> >  #include <plat/control.h>
> >  
> >  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> > @@ -437,11 +440,51 @@ static inline int omap34xx_sram_init(void)
> >  }
> >  #endif
> >  
> > +
> > +#ifdef CONFIG_ARCH_OMAP3
> > +unsigned long (*_omap3_sram_delay)(unsigned long);
> > +unsigned int  measure_sram_delay(unsigned int loop)
> > +{
> > +	static struct omap_dm_timer *gpt;
> > +	unsigned long flags, diff = 0, gt_rate, mpurate;
> > +	unsigned int delay_sram, error_gain;
> > +
> > +	omap_dm_timer_init();
> > +	gpt = omap_dm_timer_request_specific(10);
> 
> While I understand the reasons you used a specific timer, I'm not
> crazy about it.  Among other things, it has also forced you to
> hard-code OMAP3 specific register values where this should be done
> more generically.
> 
> The sram_delay function should take a struct dm_timer as an argument,
> but there's currently no way to get the base address.  So, I see a
> couple options.
> 
> Add a omap_dm_timer_get_phys_base() or similar to the DM timer API and
> then pass that value into the sram delay function and use register
> offsets in the asm function instead of fixed addresses.
> 
> That being said however, by default, the GPtimers are in posted mode,
> so your reads are not taking that into account.
> 
> Ideally, what's needed is extending the DMtimer API to have a delay
> function.  Something like: 
> 
> /* add kerneldoc description here */
> unsigned int omap_dm_timer_delay_loops(struct omap_dm_timer *timer, u32 loops)
> {
> 	unsigned int start, end;
> 
> 	start = omap_dm_timer_read_reg(timer, OMAP_TIMER_COUNTER_REG);
>         while(loops--)
>                 ;                
> 	end = omap_dm_timer_read_reg(timer, OMAP_TIMER_COUNTER_REG);
> 
> 	return start - end;
> }
> 
> which is then copied to SRAM to be executed.  This would possibly lead
> to a few extra cycles counted because the stack variables and the
> calls to the DMtimer API would in SDRAM, but the tightloop would be
> running from SRAM.
> 
> Of course, I've been on vacation for two weeks, so I could be
> forgetting some other basic reason this wouldn't work.  
> 
> > +	if (!gpt)
> > +		pr_err("Could not get the gptimer\n");
> > +	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> > +
> > +	gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
> > +	omap_dm_timer_set_load_start(gpt, 0, 0);
> > +
> > +	local_irq_save(flags);
> > +	diff = _omap3_sram_delay(loop);
> > +	local_irq_restore(flags);
> > +
> > +	omap_dm_timer_stop(gpt);
> > +	omap_dm_timer_free(gpt);
> > +
> > +	mpurate = clk_get_rate(clk_get(NULL, "arm_fck"));
> 
> Please some error checking when using clock API.
> 
> > +	/* calculate the sram delay */
> > +	delay_sram = (((mpurate / gt_rate) * diff) / 20000);
> > +
> > +	error_gain = mpurate / gt_rate;
> > +	delay_sram = delay_sram + error_gain;
> > +
> > +	return delay_sram;
> > +}
> > +#endif
> > +
> >  int __init omap_sram_init(void)
> >  {
> >  	omap_detect_sram();
> >  	omap_map_sram();
> >  
> > +	_omap3_sram_delay = omap_sram_push(__sram_wait_delay,
> > +						__sram_wait_delay_sz);
> > +
> >  	if (!(cpu_class_is_omap2()))
> >  		omap1_sram_init();
> >  	else if (cpu_is_omap242x())
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
