From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 7/7] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Mon, 20 Dec 2010 12:21:33 +0530
Message-ID: <7a43d84df0170f80e31c3e3f3eb8b249@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-8-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:57746 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753510Ab0LTGve (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 01:51:34 -0500
Received: by mail-gx0-f171.google.com with SMTP id 8so1301418gxk.2
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 22:51:34 -0800 (PST)
In-Reply-To: <1292712817-24999-8-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Sunday, December 19, 2010 4:24 AM
> To: linux-omap; linux-arm
> Cc: Jean Pihet; Kevin; Tony
> Subject: [PATCH v4 7/7] OMAP3630: PM: Erratum i583: disable coreoff if <
> ES1.2
>
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
> Limitation i583: Self_Refresh Exit issue after OFF mode
>
> Issue:
> When device is waking up from OFF mode, then SDRC state machine sends
> inappropriate sequence violating JEDEC standards.
>
> Impact:
> OMAP3630 < ES1.2 is impacted as follows depending on the platform:
> CS0: for 38.4MHz as internal sysclk, DDR content seen to be stable,
while
> 	for all other sysclk frequencies, varied levels of instability
> 	seen based on varied parameters.
> CS1: impacted
>
> This patch takes option #3 as recommended by the Silicon erratum:
> Avoid core power domain transitioning to OFF mode. Power consumption
> impact is expected in this case.
> To do this, we route core OFF requests to RET request on the impacted
> revisions of silicon.
>
> [nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code changed a
> bit]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
> v4: idle state control changed a bit -we wont register or enable
>     the states which cannot be enabled.
> v3: http://marc.info/?t=129140247800027&r=1&w=2
>     no functional change in erratum wa implementation, just registration
> of
>  	erratum is collated to a single cpu detection and version check
> v2: https://patchwork.kernel.org/patch/365262/
>     rebased to this patch series instead of depending on hs changes
>     fix typo for macro definition
> v1: http://marc.info/?l=linux-omap&m=129013173425266&w=2
>  arch/arm/mach-omap2/cpuidle34xx.c |   10 ++++++++++
>  arch/arm/mach-omap2/pm.h          |    1 +
>  arch/arm/mach-omap2/pm34xx.c      |   24 +++++++++++++++++++++---
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-
> omap2/cpuidle34xx.c
> index f80d3f6..1b32e98 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -453,6 +453,16 @@ void omap_init_power_states(void)
>  	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
>  	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID
|
>  				CPUIDLE_FLAG_CHECK_BM;
> +
> +	/*
> +	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We
> cannot
> +	 * enable OFF mode in a stable form for previous revisions.
> +	 * we disable C7 state as a result.
> +	 */
> +	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
> +		omap3_power_states[OMAP3_STATE_C7].valid = 0;
> +		cpuidle_params_table[OMAP3_STATE_C7].valid = 0;
WARN_ONCE in IDLE also would be good.
> +	}
>  }
>
>  struct cpuidle_driver omap3_idle_driver = {
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 92ef400..9032d09 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -87,6 +87,7 @@ extern unsigned int omap24xx_cpu_suspend_sz;
>  extern unsigned int omap34xx_cpu_suspend_sz;
>
>  #define PM_RTA_ERRATUM_i608		(1 << 0)
> +#define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
>
>  #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>  extern u16 pm34xx_errata;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 21cd36e..7faea55 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -928,12 +928,28 @@ void omap3_pm_off_mode_enable(int enable)
>  		state = PWRDM_POWER_RET;
>
>  #ifdef CONFIG_CPU_IDLE
> -	omap3_cpuidle_update_states(state, state);
> +	/*
> +	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We
> cannot
> +	 * enable OFF mode in a stable form for previous revisions,
restrict
> +	 * instead to RET
> +	 */
> +	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
> +		omap3_cpuidle_update_states(state, PWRDM_POWER_RET);
> +	else
> +		omap3_cpuidle_update_states(state, state);
>  #endif
>
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> -		pwrst->next_state = state;
> -		omap_set_pwrdm_state(pwrst->pwrdm, state);
> +		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
> +				pwrst->pwrdm == core_pwrdm &&
> +				state == PWRDM_POWER_OFF) {
> +			pwrst->next_state = PWRDM_POWER_RET;
> +			pr_err("%s: Core OFF disabled due to errata
i583\n",
Shoud we do this in every iteration or just WARN_ONCE do ??
> +				__func__);
> +		} else {
> +			pwrst->next_state = state;
> +		}
> +		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>  	}
>  }
>
> @@ -1011,6 +1027,8 @@ static void __init pm_errata_configure(void)
>  		pm34xx_errata |= PM_RTA_ERRATUM_i608;
>  		/* Enable the l2 cache toggling in sleep logic */
>  		enable_omap3630_toggle_l2_on_restore();
> +		if (omap_rev() < OMAP3630_REV_ES1_2)
> +			pm34xx_errata |= PM_SDRC_WAKEUP_ERRATUM_i583;
>  	}
>  }
>
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
