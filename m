From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
Date: Fri, 14 May 2010 10:58:22 -0700
Message-ID: <87hbmajrgh.fsf@deeprootsystems.com>
References: <1273745535-27139-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:56737 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062Ab0ENR60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 13:58:26 -0400
Received: by pxi5 with SMTP id 5so1467677pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 10:58:25 -0700 (PDT)
In-Reply-To: <1273745535-27139-1-git-send-email-shweta.gulati@ti.com> (shweta gulati's message of "Thu\, 13 May 2010 15\:42\:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shweta gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>

shweta gulati <shweta.gulati@ti.com> writes:

> From: Vishwanath Sripathy <vishwanath.bs@ti.com>
>
> OMAP3430/3630 has a Silicon bug because of which SDRC is
> released from IDLE even before Core DPLL has locked. This leads
> to undefined behaviour of SDRC DLL. 
>
> This patch has workaround for the same.
>
> Description of WA for 3430:
> Initialization:
> 	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3 
> 	is always locked.
>
> Before CORE Voltage Domain (VDD2) Sleep Transition to RETENTION or OFF mode:
> 1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP2 Frequency 
> 	(by changing M2 Divider value). This is increasing the period duration of 
> 	one L3 clock cycle.
> 	o	In case of CORE is at OPP3 (166MHz@1.15V):
> 	"	Lower the frequency to 83MHz.
>
> 	o	In case of CORE is at OPP2 (83MHz@1.05V):
> 	"	Keep the frequency as it is (83MHz).
>
> 2.	Increase CORE Voltage to 1.2V. This is reducing the timing duration of the
> 	critical path signal which will now fit to one L3 clock cycle.
>
> 3.	Enable DPLL3 Automatic mode. This will ensure proper transition to 
> 	RETENTION or OFF mode.
>
> After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
> 1.	Disable DPLL3 Automatic mode.
> 2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.
>
> Description of WA for 3630:
> Initialization:
> 	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3 is always locked.
>
> Before CORE Voltage Domain(VDD2) Sleep Transition to RETENTION or OFF mode:
> 1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP50 Frequency 
> 	(by changing M2 Divider value) and set VDD2 Voltage for OPP100. 
> 	This is increasing the period duration of one L3 clock cycle and reducing
> 	the timing duration of the critical path signal which will now fit to one 
> 	L3 clock cycle.
> 	o	In case of CORE is at OPP100 (L3=200MHz, VDD2=1.1375V):
> 		"	Lower the frequency to 100MHz.
> 		"	Keep the voltage as it is (1.1375V).
>
> 	o	In case of CORE is at OPP50 (L3=100MHz, VDD2=0.93V):
> 		"	Keep the frequency as it is (100MHz).
> 		"	Increase the voltage to 1.1375V.
>
> 2.	Enable DPLL3 Automatic mode. This will ensure proper transition to 
> 	RETENTION or OFF mode.
>
> After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
> 1.	Disable DPLL3 Automatic mode.
> 2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.
>
> Also OSWR should not be attempted if DPLL3 has locked. This should be done as part of OSWR patch series.
>
> Patch tested on 3430SDP and 3630 ZOOM3.
>
> Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com> 
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com> 
> ---

This patch appears to depend on Thara's SR series.  Please state
dependencies here.


>
> Index: linux-omap-pm/arch/arm/mach-omap2/pm.h
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm.h
> +++ linux-omap-pm/arch/arm/mach-omap2/pm.h
> @@ -60,6 +60,10 @@ struct prm_setup_vc {
>  
>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
> +extern int program_vdd2_opp_3430(void);
> +extern int reprogram_vdd2_opp_3430(int restore);
> +extern int program_vdd2_opp_3630(void);
> +extern int reprogram_vdd2_opp_3630(int restore);
>  
>  extern u32 wakeup_timer_seconds;
>  extern struct omap_dm_timer *gptimer_wakeup;
> Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
> +++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
> @@ -56,6 +56,7 @@
>  #include "sdrc.h"
>  #include "omap3-opp.h"
>  
> +

stray whitespace change

>  #ifdef CONFIG_SUSPEND
>  static suspend_state_t suspend_state = PM_SUSPEND_ON;
>  static inline bool is_suspending(void)
> @@ -363,6 +364,8 @@ void omap_sram_idle(void)
>  	u32 sdrc_pwr = 0;
>  	int per_state_modified = 0;
>  	unsigned int start =0, end = 0;
> +	u32 fclk_status = 0;
> +	int restore = 1;
>  	if (!_omap_sram_idle)
>  		return;
>  
> @@ -415,15 +418,6 @@ void omap_sram_idle(void)
>  	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
>  		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  
> -	/*
> -	 * Disable smartreflex before entering WFI.
> -	 * Only needed if we are going to enter retention or off.
> -	 */
> -	if (mpu_next_state <= PWRDM_POWER_RET)
> -		omap_smartreflex_disable(VDD1, 1);
> -	if (core_next_state <= PWRDM_POWER_RET)
> -		omap_smartreflex_disable(VDD2, 1);
> -
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(0);
> @@ -447,6 +441,31 @@ void omap_sram_idle(void)
>  		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>  		omap3_enable_io_chain();
>  	}
> +	/*
> +	 * Disable smartreflex before entering WFI.
> +	 * Only needed if we are going to enter retention or off.
> +	 */
> +	if (mpu_next_state <= PWRDM_POWER_RET)
> +		omap_smartreflex_disable(VDD1, 1);
> +	if (core_next_state <= PWRDM_POWER_RET) {
> +		fclk_status = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN) |
> +			cm_read_mod_reg(CORE_MOD, CM_FCLKEN1) |
> +			cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3) |
> +			cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN) |
> +			cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN) |
> +			cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN) |
> +			cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);

Doing this fclk checking here has already been rejected and Tero has
solved it in a different way in the CPUidle logic.  Please see the series
beginning here: https://patchwork.kernel.org/patch/85268/

> +		if (!fclk_status) {
> +			omap_smartreflex_disable(VDD2, 1);
> +			if (cpu_is_omap3630())
> +				program_vdd2_opp_3630();
> +			else if (cpu_is_omap3430())
> +				program_vdd2_opp_3430();

Please don't use cpu_is_* checks for errata.  Use errata flags.

> +			cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
> +					0x1, PLL_MOD, CM_AUTOIDLE);
> +		}
> +	}
> +

All that being said, why is the voltage level being programmed here?

It seems to me that all of this errata handling should be
self-contained in the voltage layer.

Kevin
