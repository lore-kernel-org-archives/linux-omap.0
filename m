From: ambresh <a0393775@ti.com>
Subject: Re: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Mon, 8 Mar 2010 15:36:10 +0530
Message-ID: <4B94CC12.3000104@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D573@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46133 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab0CHKGS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 05:06:18 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D573@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Reddy, Teerth wrote:
> From: Teerth Reddy <teerth@ti.com>
> 
> Dynamic Calculation of SDRC stall latency during DVFS
> 
> The patch has the changes to calculate the dpll3 clock stabilization delay dynamically. The SRAM delay is calibrated during bootup using the gptimers and used while calculating the stabilization delay. By using the dynamic method the dependency on the type of cache being used is removed. Hence there is no need of loop based calculation.
> 
> The wait time for L3 clock stabilization is calculated using the formula : 4*REFCLK + 8*CLKOUTX2, which uses the M, N and M2 read from the registers.Since this value gives slightly less value, 2us is added as buffer for safety.
> This works fine for omap3. 
> 
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
>  arch/arm/mach-omap2/clkt34xx_dpll3m2.c    |   52 ++++++++++++++++++++++++-----
>  arch/arm/mach-omap2/clock34xx.h           |    2 +
>  arch/arm/mach-omap2/clock34xx_data.c      |   11 ++++++
>  arch/arm/mach-omap2/sram34xx.S            |   17 +++++++++
>  arch/arm/plat-omap/dmtimer.c              |    6 +++
>  arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
>  arch/arm/plat-omap/include/plat/sram.h    |    5 +++
>  arch/arm/plat-omap/sram.c                 |   51 ++++++++++++++++++++++++++++
>  8 files changed, 136 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> index 8716a01..2e6d774 100644
> --- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> +++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> @@ -24,13 +24,22 @@
>  #include <plat/clock.h>
>  #include <plat/sram.h>
>  #include <plat/sdrc.h>
> +#include <plat/prcm.h>
>  
>  #include "clock.h"
>  #include "clock34xx.h"
>  #include "sdrc.h"
> +#include "cm.h"
>  
>  #define CYCLES_PER_MHZ			1000000
>  
> +#define	DPLL_M_MASK	0x7ff
> +#define	DPLL_N_MASK	0x7f
> +#define	DPLL_M2_MASK	0x1f
> +#define	SHIFT_DPLL_M	16
> +#define	SHIFT_DPLL_N	8
> +#define	SHIFT_DPLL_M2	27
> +
>  /*
>   * CORE DPLL (DPLL3) M2 divider rate programming functions
>   *
> @@ -55,6 +64,11 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
>  	struct omap_sdrc_params *sdrc_cs0;
>  	struct omap_sdrc_params *sdrc_cs1;
>  	int ret;
> +	u32 clk_sel_regval;
> +	u32 core_dpll_mul_m, core_dpll_div_n, core_dpll_clkoutdiv_m2;
> +	u32 sys_clk_rate, sdrc_clk_stab;
> +	u32 nr1, nr2, nr, dr;
> +	unsigned int delay_sram;
>  
>  	if (!clk || !rate)
>  		return -EINVAL;
> @@ -78,16 +92,36 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
>  		unlock_dll = 1;
>  	}
>  
> -	/*
> -	 * XXX This only needs to be done when the CPU frequency changes
> -	 */
> +	clk_sel_regval = cm_read_mod_reg(PLL_MOD, CM_CLKSEL);

*clk already as reference to CM_CLKSEL:

  static struct clk dpll3_m2_ck = {
[...]
         .clksel_reg     = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
         .clksel_mask    = OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
[...]

so please use .clksel_reg to read the register content.

> +
> +	/* Get the M, N and M2 values required for getting sdrc clk stab */
> +	core_dpll_mul_m = (clk_sel_regval >> SHIFT_DPLL_M) & DPLL_M_MASK;
> +	core_dpll_div_n = (clk_sel_regval >> SHIFT_DPLL_N) & DPLL_N_MASK;
> +	core_dpll_clkoutdiv_m2 = (clk_sel_regval >> SHIFT_DPLL_M2) &
> +								DPLL_M2_MASK;
> +	sys_clk_rate = clk_get_rate(clk_get(NULL, "osc_sys_ck"));

Should it be "sys_ck" instead of "osc_sys_ck"?

According to my understanding from trm, I guess CLKINP represents DPLL3 
reference clock (DPLL3_ALWON_FCLK) which is nothing but "sys_ck".

Should not make a difference when the sys_clk divisor is 1, but if it is 
2, then sys_ck=osc_sys_ck/2.


> +
> +	sys_clk_rate = sys_clk_rate / 1000000;

Use the macro CYCLES_PER_MHZ instead of magic number.	

> +
> +	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
> +	nr1 = (4 * (core_dpll_div_n + 1) * 2 * core_dpll_clkoutdiv_m2 *
> +							 core_dpll_mul_m);
> +	nr2 = 8 * (core_dpll_div_n + 1);
> +	nr = nr1 + nr2;
> +
> +	dr = 2 * sys_clk_rate * core_dpll_mul_m * core_dpll_clkoutdiv_m2;
> +

I am not able to understand the calculations completely for
(nr1 + nr2) / dr. and I guess you could simplify the calculation a bit 
by removing the redundant multiplications and divisions.
And also may be you can use m, n & m2 instead of core_dpll_xxx_xx, to 
make code more readable.


Regards,
Ambresh

> +	sdrc_clk_stab = nr / dr;
> +
> +	/* Adding 2us to sdrc clk stab */
> +	sdrc_clk_stab = sdrc_clk_stab + 2;
> +
> +	delay_sram = delay_sram_val();
> +
> +	/* Calculate the number of MPU cycles to wait for SDRC to stabilize */
>  	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
> -	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
> -	c += 1;  /* for safety */
> -	c *= SDRC_MPURATE_LOOPS;
> -	c >>= SDRC_MPURATE_SCALE;
> -	if (c == 0)
> -		c = 1;
> +
> +	c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
>  
>  	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
>  		 validrate);
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h index 313efc0..97afe34 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -22,4 +22,6 @@ extern const struct clkops clkops_omap3430es2_hsotgusb_wait;  extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
>  extern const struct clkops omap3_clkops_noncore_dpll_ops;
>  
> +unsigned int delay_sram_val(void);
> +
>  #endif
> diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
> index 8728f1f..cf7384b 100644
> --- a/arch/arm/mach-omap2/clock34xx_data.c
> +++ b/arch/arm/mach-omap2/clock34xx_data.c
> @@ -22,6 +22,7 @@
>  
>  #include <plat/control.h>
>  #include <plat/clkdev_omap.h>
> +#include <plat/sram.h>
>  
>  #include "clock.h"
>  #include "clock34xx.h"
> @@ -52,6 +53,8 @@
>  static struct clk dpll1_fck;
>  static struct clk dpll2_fck;
>  
> +unsigned int delay_sram;
> +
>  /* PRM CLOCKS */
>  
>  /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */ @@ -3275,5 +3278,13 @@ int __init omap3xxx_clk_init(void)
>  	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
>  	arm_fck_p = clk_get(NULL, "arm_fck");
>  
> +	/* Measure sram delay */
> +	delay_sram = measure_sram_delay(10000);
> +	pr_debug("SRAM delay: %d\n", delay_sram);
>  	return 0;
>  }
> +
> +unsigned int delay_sram_val(void)
> +{
> +	return delay_sram;
> +}
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S index de99ba2..bbeef26 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -313,3 +313,20 @@ core_m2_mask_val:
>  ENTRY(omap3_sram_configure_core_dpll_sz)
>  	.word	. - omap3_sram_configure_core_dpll
>  
> +ENTRY(__sram_wait_delay)
> +	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
> +	ldr	r2, [r0]
> +
> +loop1:
> +	subs 	r1, r1, #1
> +	bne	loop1
> +
> +	isb
> +	ldr	r3, [r0]
> +	subs	r4, r3, r2
> +
> +	mov 	r0, r4 			@ return value
> +	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
> +
> +ENTRY(__sram_wait_delay_sz)
> +	.word	. - __sram_wait_delay
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c index 24bf692..d00a44a 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -712,6 +712,12 @@ void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value  }  EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
>  
> +unsigned int omap_dm_timer_get_phys_base(unsigned int gptimer) {
> +	return dm_timers[gptimer - 1].phys_base; } 
> +EXPORT_SYMBOL_GPL(omap_dm_timer_get_phys_base);
> +
>  int omap_dm_timers_active(void)
>  {
>  	int i;
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 20f1054..f75d43e 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -55,6 +55,7 @@ void omap_dm_timer_free(struct omap_dm_timer *timer);  void omap_dm_timer_enable(struct omap_dm_timer *timer);  void omap_dm_timer_disable(struct omap_dm_timer *timer);
>  
> +unsigned int omap_dm_timer_get_phys_base(unsigned int gptimer);
>  int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
>  
>  u32 omap_dm_timer_modify_idlect_mask(u32 inputmask); diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
> index 16a1b45..3ee366c 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -69,6 +69,11 @@ extern u32 omap3_sram_configure_core_dpll(
>  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);  extern unsigned long omap3_sram_configure_core_dpll_sz;
>  
> +extern unsigned int measure_sram_delay(unsigned int);
> +
> +extern u32 __sram_wait_delay(unsigned int, unsigned int); extern 
> +unsigned long __sram_wait_delay_sz;
> +
>  #ifdef CONFIG_PM
>  extern void omap_push_sram_idle(void);
>  #else
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c index 51f4dfb..e541e8f 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -30,6 +30,9 @@
>  #include <plat/cpu.h>
>  #include <plat/vram.h>
>  
> +#include <linux/clk.h>
> +#include <plat/dmtimer.h>
> +#include <plat/io.h>
>  #include <plat/control.h>
>  
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) @@ -74,6 +77,9 @@
>  
>  #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
>  
> +/* GPT10 TCRR register offset */
> +#define OMAP_TIMER_COUNTER_OFFSET	0x28
> +
>  static unsigned long omap_sram_start;
>  static unsigned long omap_sram_base;
>  static unsigned long omap_sram_size;
> @@ -437,11 +443,56 @@ static inline int omap34xx_sram_init(void)  }  #endif
>  
> +
> +#ifdef CONFIG_ARCH_OMAP3
> +unsigned long (*_omap3_sram_delay)(void * __iomem, unsigned int); 
> +unsigned int  measure_sram_delay(unsigned int loop) {
> +	static struct omap_dm_timer *gpt;
> +	unsigned long flags, diff = 0, gt_rate, mpurate;
> +	unsigned int delay_sram, error_gain;
> +	void * __iomem gpt10_counter_reg;
> +
> +	omap_dm_timer_init();
> +	gpt = omap_dm_timer_request_specific(10);
> +	if (!gpt)
> +		pr_err("Could not get the gptimer\n");
> +	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> +
> +	gpt10_counter_reg =
> +			OMAP2_L4_IO_ADDRESS(omap_dm_timer_get_phys_base(10) +
> +					OMAP_TIMER_COUNTER_OFFSET);
> +
> +	gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
> +	omap_dm_timer_set_load_start(gpt, 0, 0);
> +
> +	local_irq_save(flags);
> +	diff = _omap3_sram_delay(gpt10_counter_reg, loop);
> +	local_irq_restore(flags);
> +
> +	omap_dm_timer_stop(gpt);
> +	omap_dm_timer_free(gpt);
> +
> +	mpurate = clk_get_rate(clk_get(NULL, "arm_fck"));
> +
> +	/* calculate the sram delay */
> +	delay_sram = (((mpurate / gt_rate) * diff) / (loop * 2));
> +
> +	error_gain = mpurate / gt_rate;
> +	delay_sram = delay_sram + error_gain;
> +
> +	return delay_sram;
> +}
> +#endif
> +
>  int __init omap_sram_init(void)
>  {
>  	omap_detect_sram();
>  	omap_map_sram();
>  
> +	_omap3_sram_delay = omap_sram_push(__sram_wait_delay,
> +						__sram_wait_delay_sz);
> +
>  	if (!(cpu_class_is_omap2()))
>  		omap1_sram_init();
>  	else if (cpu_is_omap242x())
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

