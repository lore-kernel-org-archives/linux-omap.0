From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 16/17] omap4: cpuidle: Allow debugfs control through enable_off_mode
Date: Wed, 02 Mar 2011 15:43:03 -0800
Message-ID: <8739n5ytq0.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-17-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:39058 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab1CBXnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 18:43:08 -0500
Received: by gyd10 with SMTP id 10so323755gyd.40
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 15:43:06 -0800 (PST)
In-Reply-To: <1298112158-28469-17-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Only MPU OFF and RET is controllable. CORE state is blocked
> at ON state till the CORE RET support is added.

-ECONFUSED

None of the C-states currently have CORE != ON:  

./cpuidle44xx.c:219:	omap4_power_states[OMAP4_STATE_C1].core_state = PWRDM_POWER_ON;
./cpuidle44xx.c:240:	omap4_power_states[OMAP4_STATE_C2].core_state = PWRDM_POWER_ON;
./cpuidle44xx.c:262:	omap4_power_states[OMAP4_STATE_C3].core_state = PWRDM_POWER_ON;
./cpuidle44xx.c:284:	omap4_power_states[OMAP4_STATE_C4].core_state = PWRDM_POWER_ON;

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   30 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h          |    1 +
>  arch/arm/mach-omap2/pm44xx.c      |    4 ++++
>  3 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index e887eb5..4207862 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -170,6 +170,31 @@ static int omap4_enter_idle_bm(struct cpuidle_device *dev,
>  }
>  
>  /**
> + * omap4_cpuidle_update_states() - Update the cpuidle states
> + * @mpu_deepest_state: Enable states upto and including this for mpu domain
> + * @core_deepest_state: Enable states upto and including this for core domain
> + *
> + * This goes through the list of states available and enables and disables the
> + * validity of C states based on deepest state that can be achieved for the
> + * variable domain
> + */
> +void omap4_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
> +{
> +	int i;
> +
> +	for (i = OMAP4_STATE_C1; i < OMAP4_MAX_STATES; i++) {
> +		struct omap4_processor_cx *cx = &omap4_power_states[i];
> +
> +		if ((cx->mpu_state >= mpu_deepest_state) &&
> +		    (cx->core_state >= core_deepest_state)) {
> +			cx->valid = 1;
> +		} else {
> +			cx->valid = 0;
> +		}
> +	}
> +}

Also, as mentioned in a previous patch,  for OMAP4 I'd like to move away
from this approach to updating the states and rather use the ->prepare
hook along with the ignore flag.

> +/**
>   * omap4_init_power_states - Initialises the OMAP4 specific C states.
>   *
>   */
> @@ -325,6 +350,11 @@ int __init omap4_idle_init(void)
>  		}
>  	}
>  
> +	if (enable_off_mode)
> +		omap4_cpuidle_update_states(PWRDM_POWER_OFF, PWRDM_POWER_OFF);
> +	else
> +		omap4_cpuidle_update_states(PWRDM_POWER_RET, PWRDM_POWER_RET);
> +
>  	return 0;
>  }
>  #else
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index ce848b0..4df89d1 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -77,6 +77,7 @@ extern u32 sleep_while_idle;
>  
>  #if defined(CONFIG_CPU_IDLE)
>  extern void omap3_cpuidle_update_states(u32, u32);
> +extern void omap4_cpuidle_update_states(u32, u32);
>  #endif
>  
>  #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 628242d..6244ab2 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -183,6 +183,10 @@ void omap4_pm_off_mode_enable(int enable)
>  	else
>  		state = PWRDM_POWER_RET;
>  
> +#ifdef CONFIG_CPU_IDLE
> +	omap4_cpuidle_update_states(state, PWRDM_POWER_ON);
> +#endif
> +
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>  		/* FIXME: Remove this check when core retention is supported */
>  		if (!strcmp(pwrst->pwrdm->name, "mpu_pwrdm")) {
