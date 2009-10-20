From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/17] OMAP3: PM: Dynamic check for CORE target state
Date: Tue, 20 Oct 2009 09:16:44 -0700
Message-ID: <871vkyniqb.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:52156 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbZJTQQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 12:16:42 -0400
Received: by pzk26 with SMTP id 26so4197819pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:16:46 -0700 (PDT)
In-Reply-To: <1255690150-16853-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 16 Oct 2009 13\:48\:55 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Sleep code will now check if core will actually enter power save state or
> not. This is needed so that PER domain does not enter retention / off while
> core stays on and thus preventing I/O pad wakeups.
>
> This also optimizes core context save and restore logic, it will skip
> saving / restoring core context when this is requested but not needed.

I understand this being useful to save an extra save/restore but not
sure about the wakeup issue.

If CORE stays ON, then yes, IO pad will not be armed so IOpad wakeups
will not work.  But module level wakeups should work fine.  It seems
the bug is actually that module level wakeups are not properly
configured.

There were definitely problems in the PM branch with module level
wakeups.  We now have fixes at least for GPIO and UART3 module level
wakeups which were found to be broken if CORE was left on.

This is easy enough to test/debug by forcing CORE to say on:

   # echo 3 > /debug/pm_debug/core_pwrdm/suspend

going into suspend and testing the various wakeup sources.

Kevin


> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/cm.h     |    1 +
>  arch/arm/mach-omap2/pm34xx.c |   46 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
> index a2fcfcc..715ab14 100644
> --- a/arch/arm/mach-omap2/cm.h
> +++ b/arch/arm/mach-omap2/cm.h
> @@ -76,6 +76,7 @@
>  #define OMAP3430ES2_CM_CLKEN2				0x0004
>  #define OMAP3430ES2_CM_FCLKEN3				0x0008
>  #define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
> +#define OMAP3430_CM_IDLEST3				0x0028
>  #define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
>  #define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
>  #define OMAP3430_CM_CLKSEL1				CM_CLKSEL
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 5e2ef63..e8704a6 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -64,6 +64,28 @@ u32 sleep_while_idle;
>  u32 wakeup_timer_seconds;
>  u32 voltage_off_while_idle;
>  
> +/* IDLEST bitmasks for core status checks */
> +#define CORE_IDLEST1_ALL		(\
> +		OMAP3430ES2_ST_MMC3_MASK|OMAP3430_ST_ICR_MASK|\
> +		OMAP3430_ST_AES2_MASK|OMAP3430_ST_SHA12_MASK|\
> +		OMAP3430_ST_DES2_MASK|OMAP3430_ST_MMC2_MASK|\
> +		OMAP3430_ST_MMC1_MASK|OMAP3430_ST_MSPRO_MASK|\
> +		OMAP3430_ST_HDQ_MASK|OMAP3430_ST_MCSPI4_MASK|\
> +		OMAP3430_ST_MCSPI3_MASK|OMAP3430_ST_MCSPI2_MASK|\
> +		OMAP3430_ST_MCSPI1_MASK|OMAP3430_ST_I2C3_MASK|\
> +		OMAP3430_ST_I2C2_MASK|OMAP3430_ST_I2C1_MASK|\
> +		OMAP3430_ST_GPT11_MASK|OMAP3430_ST_GPT10_MASK|\
> +		OMAP3430_ST_MCBSP5_MASK|OMAP3430_ST_MCBSP1_MASK|\
> +		OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK|\
> +		OMAP3430ES2_ST_SSI_IDLE_MASK|OMAP3430_ST_SDMA_MASK|\
> +		OMAP3430_ST_SSI_STDBY_MASK|OMAP3430_ST_D2D_MASK)
> +#define CORE_IDLEST2_ALL		(\
> +		OMAP3430_ST_PKA_MASK|OMAP3430_ST_AES1_MASK|\
> +		OMAP3430_ST_RNG_MASK|OMAP3430_ST_SHA11_MASK|\
> +		OMAP3430_ST_DES1_MASK)
> +#define CORE_IDLEST3_ALL		(\
> +		OMAP3430ES2_ST_USBTLL_MASK|OMAP3430ES2_ST_CPEFUSE_MASK)
> +
>  struct power_state {
>  	struct powerdomain *pwrdm;
>  	u32 next_state;
> @@ -408,6 +430,7 @@ void omap_sram_idle(void)
>  	int core_prev_state, per_prev_state;
>  	u32 sdrc_pwr = 0;
>  	int per_state_modified = 0;
> +	int core_saved_state = PWRDM_POWER_ON;
>  
>  	if (!_omap_sram_idle)
>  		return;
> @@ -439,9 +462,28 @@ void omap_sram_idle(void)
>  	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
>  		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
>  
> +	/*
> +	 * Check whether core will enter idle or not. This is needed
> +	 * because I/O pad wakeup will fail if core stays on and PER
> +	 * enters off. This will also prevent unnecessary core context
> +	 * save / restore.
> +	 */
> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> +	if (core_next_state < PWRDM_POWER_ON) {
> +		core_saved_state = core_next_state;
> +		if ((cm_read_mod_reg(CORE_MOD, CM_IDLEST1) & CORE_IDLEST1_ALL)
> +				!= CORE_IDLEST1_ALL ||
> +		    (cm_read_mod_reg(CORE_MOD, CM_IDLEST2) & CORE_IDLEST2_ALL)
> +				!= CORE_IDLEST2_ALL ||
> +		    (cm_read_mod_reg(CORE_MOD, OMAP3430_CM_IDLEST3) &
> +				CORE_IDLEST3_ALL) != CORE_IDLEST3_ALL) {
> +			core_next_state = PWRDM_POWER_ON;
> +			pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
> +		}
> +	}
> +
>  	/* PER */
>  	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
> -	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(2);
>  		omap2_gpio_prepare_for_idle(per_next_state);
> @@ -539,6 +581,8 @@ void omap_sram_idle(void)
>  		enable_smartreflex(SR1);
>  		enable_smartreflex(SR2);
>  	}
> +	if (core_saved_state != core_next_state)
> +		pwrdm_set_next_pwrst(core_pwrdm, core_saved_state);
>  
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
