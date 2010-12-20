From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 6/7] OMAP3: PM: make omap3_cpuidle_update_states
 independent of enable_off_mode
Date: Mon, 20 Dec 2010 12:46:22 +0530
Message-ID: <21f9d2f64e7fbcdb4134e04393d42e40@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37298 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753641Ab0LTHQX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 02:16:23 -0500
Received: by mail-gx0-f170.google.com with SMTP id 20so1524036gxk.1
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 23:16:23 -0800 (PST)
In-Reply-To: <1292712817-24999-7-git-send-email-nm@ti.com>
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
> Subject: [PATCH v4 6/7] OMAP3: PM: make omap3_cpuidle_update_states
> independent of enable_off_mode
>
> Currently omap3_cpuidle_update_states makes whole sale decision
> on which C states to update based on enable_off_mode variable
> Instead, achieve the same functionality by independently providing
> mpu and core deepest states the system is allowed to achieve and
> update the idle states accordingly.
>
Thanks Nishant for this change. Indeed it's better than using the debug
related flag.

> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   19 ++++++++++---------
>  arch/arm/mach-omap2/pm.h          |    3 ++-
>  arch/arm/mach-omap2/pm34xx.c      |    2 +-
>  3 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-
> omap2/cpuidle34xx.c
> index 0d50b45..f80d3f6 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -293,25 +293,26 @@ select_state:
>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>
>  /**
> - * omap3_cpuidle_update_states - Update the cpuidle states.
> + * omap3_cpuidle_update_states() - Update the cpuidle states
> + * @mpu_deepest_state:	Enable states upto and including this for
mpu
> domain
> + * @core_deepest_state:	Enable states upto and including this for
> core domain
>   *
> - * Currently, this function toggles the validity of idle states based
> upon
> - * the flag 'enable_off_mode'. When the flag is set all states are
valid.
> - * Else, states leading to OFF state set to be invalid.
> + * This goes through the list of states available and enables and
> disables the
> + * validity of C states based on deepest state that can be achieved for
> the
> + * variable domain
>   */
> -void omap3_cpuidle_update_states(void)
> +void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32
> core_deepest_state)
>  {
>  	int i;
>
>  	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
>  		struct omap3_processor_cx *cx = &omap3_power_states[i];
>
> -		if (enable_off_mode) {
> +		if ((cx->mpu_state >= mpu_deepest_state) &&
> +		    (cx->core_state >= core_deepest_state)) {
>  			cx->valid = 1;
>  		} else {
> -			if ((cx->mpu_state == PWRDM_POWER_OFF) ||
> -				(cx->core_state	== PWRDM_POWER_OFF))
> -				cx->valid = 0;
> +			cx->valid = 0;
>  		}
>  	}
>  }
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 5e0bee9..92ef400 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -58,7 +58,8 @@ extern u32 sleep_while_idle;
>  #endif
>
>  #if defined(CONFIG_CPU_IDLE)
> -extern void omap3_cpuidle_update_states(void);
> +extern void omap3_cpuidle_update_states(u32 core_deepest_state,
> +		u32 core_deepest_state);
>  #endif
>
>  #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 4ba7a06..21cd36e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -928,7 +928,7 @@ void omap3_pm_off_mode_enable(int enable)
>  		state = PWRDM_POWER_RET;
>
>  #ifdef CONFIG_CPU_IDLE
> -	omap3_cpuidle_update_states();
> +	omap3_cpuidle_update_states(state, state);
>  #endif
>
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
