From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under
 DVFS+SR operation
Date: Tue, 30 Mar 2010 03:29:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1003300309570.14474@utopia.booyaka.com>
References: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45079 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab0C3J3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 05:29:38 -0400
In-Reply-To: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Shweta Gulati <shweta.gulati@ti.com>

On Thu, 11 Mar 2010, Vishwanath BS wrote:

> From: Shweta Gulati <shweta.gulati@ti.com>
> 
> DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM UCs
> running DSP codec was earlier restricted as DSP crashed.
> The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
> The solution is to make sure DPLL1/DPLL2 bypass clock is always less than 
> maximum supported frequency for the specific OPP
> 
> Tested on 3630 ZOOM3.
> 
> changes in V2 : Rebased to new OPP implementation
> 
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++--
>  arch/arm/mach-omap2/pm34xx.c          |   23 +++++++++++++++++++++++
>  arch/arm/mach-omap2/resource34xx.c    |   28 +++++++++++++++++++++++++++-
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index a3a3ca0..ee420ab 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -81,7 +81,7 @@
>  
>  /* CM_CLKSEL1_PLL_IVA2 */
>  #define OMAP3430_IVA2_CLK_SRC_SHIFT			19
> -#define OMAP3430_IVA2_CLK_SRC_MASK			(0x3 << 19)
> +#define OMAP3430_IVA2_CLK_SRC_MASK			(0x7 << 19)

This is an ES2+ only setting, so please change the original value to 
OMAP3430ES1_IVA2_CLK_SRC_MASK and add a new macro here for 
OMAP3430ES2_IVA2_CLK_SRC_MASK.

>  #define OMAP3430_IVA2_DPLL_MULT_SHIFT			8
>  #define OMAP3430_IVA2_DPLL_MULT_MASK			(0x7ff << 8)
>  #define OMAP3430_IVA2_DPLL_DIV_SHIFT			0
> @@ -126,7 +126,7 @@
>  
>  /* CM_CLKSEL1_PLL_MPU */
>  #define OMAP3430_MPU_CLK_SRC_SHIFT			19
> -#define OMAP3430_MPU_CLK_SRC_MASK			(0x3 << 19)
> +#define OMAP3430_MPU_CLK_SRC_MASK			(0x7 << 19)

Presumably this is the same.

>  #define OMAP3430_MPU_DPLL_MULT_SHIFT			8
>  #define OMAP3430_MPU_DPLL_MULT_MASK			(0x7ff << 8)
>  #define OMAP3430_MPU_DPLL_DIV_SHIFT			0
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b51b461..494e5e6
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -828,6 +828,29 @@ static void __init omap3_d2d_idle(void)
>  
>  static void __init prcm_setup_regs(void)
>  {
> +	u32 cm_clksel1_mpu, cm_clksel1_iva2;
> +
> +	/*set Bypass clock dividers for MPU and IVA */
> +	cm_clksel1_mpu = cm_read_mod_reg(MPU_MOD, CM_CLKSEL1);
> +	cm_clksel1_iva2 = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
> +	if (cpu_is_omap3630()) {
> +		cm_clksel1_iva2 = (cm_clksel1_iva2 &
> +					~(OMAP3430_IVA2_CLK_SRC_MASK)) |
> +					(0x2 << OMAP3430_IVA2_CLK_SRC_SHIFT);
> +		cm_clksel1_mpu = (cm_clksel1_mpu &
> +					~(OMAP3430_MPU_CLK_SRC_MASK)) |
> +					(0x1 << OMAP3430_MPU_CLK_SRC_SHIFT);
> +	} else if (cpu_is_omap34xx()) {
> +		cm_clksel1_iva2 = (cm_clksel1_iva2 &
> +					~(OMAP3430_IVA2_CLK_SRC_MASK)) |
> +					(0x4 << OMAP3430_IVA2_CLK_SRC_SHIFT);
> +		cm_clksel1_mpu = (cm_clksel1_mpu &
> +					~(OMAP3430_MPU_CLK_SRC_MASK)) |
> +					(0x2 << OMAP3430_MPU_CLK_SRC_SHIFT);
> +		}
> +	cm_write_mod_reg(cm_clksel1_iva2, OMAP3430_IVA2_MOD, CM_CLKSEL1);

This should use the clock framework.  You should use clk_set_rate() on 
dpll2_fck.

> +	cm_write_mod_reg(cm_clksel1_mpu, MPU_MOD, CM_CLKSEL1);

This should use the clock framework.  You should use clk_set_rate() on 
dpll1_fck.

> +
>  	/* XXX Reset all wkdeps. This should be done when initializing
>  	 * powerdomains */
>  	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index c6cce8b..03d7fce
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -276,12 +276,13 @@ static unsigned long compute_lpj(unsigned long ref, u_int div, u_int mult)
>  
>  static int program_opp_freq(int res, int target_level, int current_level)
>  {
> -	int ret = 0, l3_div;
> +	int ret = 0, l3_div, mpu_div, iva2_div;
>  	int *curr_opp;
>  	unsigned long mpu_freq, dsp_freq, l3_freq;
>  #ifndef CONFIG_CPU_FREQ
>  	unsigned long mpu_cur_freq;
>  #endif
> +	u32 cm_clksel1_mpu, cm_clksel1_iva2, max_core_clk;
>  
>  	/* Check if I can actually switch or not */
>  	if (res == VDD1_OPP) {
> @@ -299,6 +300,31 @@ static int program_opp_freq(int res, int target_level, int current_level)
>  
>  	lock_scratchpad_sem();
>  	if (res == VDD1_OPP) {
> +		/* adjust bypass clock diviers */
> +		max_core_clk = ULONG_MAX;
> +		opp_find_freq_floor(OPP_L3, &max_core_clk);
> +		l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +				OMAP3430_CLKSEL_L3_MASK;
> +
> +		max_core_clk *= l3_div;
> +		mpu_div = 1 << (max_core_clk / mpu_freq);
> +		iva2_div = 1 << (max_core_clk / dsp_freq);
> +
> +		cm_clksel1_mpu = cm_read_mod_reg(MPU_MOD, CM_CLKSEL1);
> +		cm_clksel1_iva2 =
> +				cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
> +
> +		cm_clksel1_iva2 = (cm_clksel1_iva2 &
> +				~(OMAP3430_IVA2_CLK_SRC_MASK)) |
> +				(iva2_div << OMAP3430_IVA2_CLK_SRC_SHIFT);
> +		cm_clksel1_mpu = (cm_clksel1_mpu &
> +				~(OMAP3430_MPU_CLK_SRC_MASK)) |
> +				(mpu_div << OMAP3430_MPU_CLK_SRC_SHIFT);
> +
> +		cm_write_mod_reg(cm_clksel1_iva2,
> +				OMAP3430_IVA2_MOD, CM_CLKSEL1);
> +		cm_write_mod_reg(cm_clksel1_mpu, MPU_MOD, CM_CLKSEL1);
> +

All this needs to use the clock framework (clk_* functions), unless there 
is some good reason why it can't?

>  		curr_opp = &curr_vdd1_opp;
>  		clk_set_rate(dpll1_clk, mpu_freq);
>  		clk_set_rate(dpll2_clk, dsp_freq);


- Paul
