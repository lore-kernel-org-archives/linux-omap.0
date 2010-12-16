From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Thu, 16 Dec 2010 10:57:45 -0800
Message-ID: <87tyidczpy.fsf@deeprootsystems.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>
	<1291395818-8639-6-git-send-email-nm@ti.com>
	<2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com>
	<4D0622FE.2070801@ti.com>
	<d5e397dafb68b41ec5d7af591a18b044@mail.gmail.com>
	<4D062806.6090201@ti.com>
	<b7c3a82268b65ae1d9d09f377d9039f1@mail.gmail.com>
	<4D062F81.407@ti.com>
	<96505dfaee73d6785e153ccf5c2856d3@mail.gmail.com>
	<6f507e24d6ae188e265913e85e815f82@mail.gmail.com>
	<4D063344.2010001@ti.com>
	<37de3932d97af8e1882a08dd37242a17@mail.gmail.com>
	<4D063599.9080905@ti.com> <87ei9l10mk.fsf@deeprootsystems.com>
	<4D0933C6.1060404@ti.com> <87wrnaions.fsf@deeprootsystems.com>
	<4D0957C7.4010907@ti.com> <4D096BC4.4040009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38567 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0LPS5u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 13:57:50 -0500
Received: by yxt3 with SMTP id 3so1837415yxt.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 10:57:49 -0800 (PST)
In-Reply-To: <4D096BC4.4040009@ti.com> (Nishanth Menon's message of "Wed, 15
	Dec 2010 19:30:44 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Nishanth Menon had written, on 12/15/2010 06:05 PM, the following:
>> Kevin Hilman had written, on 12/15/2010 05:47 PM, the following:
>>
>>>> I agree that this additional check in sram_idle should be removed, but
>>>> as long as I handle it in omap3_pm_off_mode_enable where the next
>>>> states are configured, is'nt that enough or am I missing something?
>>>
>>> Setting the next states only sets the default states, but CPUidle
>>> changes them.
>>>
>>> Looking closer at omap3_pm_off_mode_enable() though, it already calls
>>> into CPUidle and disables the valid bit for any states that have
>>> *either* MPU or core off.    You'll probably just need to extend this
>>> approach to disable only CORE off state(s).
>> Thx. it is clear now. let me see how to clean this up.
> k. Does the attached look any better now :)? 

Yes, but, I still don't quite like it.  Basically, I'm not crazy about
the errata knowledge being centralized in pm34xx.c.   How about this:

Move the Errata handling core code (pm_errata_* PM_ERRATTA_*) to pm.[ch]
as a single patch.  Then both pm34xx.c and cpuidle34xx.c would be free
to use it.

This would allow CPUidle handle the errata itself in the 'update_states'
function.  Or even better, if CPUidle core can check this errata, it
should probably just never register C7 in the first place, because it is
*never* a valid C-state.

Make sense?

Kevin


> I have removed the check
> logic from sram_idle path instead made omap3_cpuidle_update_states
> little more generic, updated validity of C state based on errata. This
> now disables just those C states with core OFF on 3630 <ES1.2
>
> in a map, this will now look as follows:
> --------+-------+-------+-------+-------+--------+
>         | MPU   | Core  | OFF   | OFF Enable-36xx|
>         | Dom   | Dom   |       +-------+--------+
> C state | State | State | Dis   | ES1.1 | ES 1.2 |
> --------+-------+-------+-------+-------+--------+
> 1       | ON    | ON    | YES   | YES   | YES    |
> 2       | ON    | ON    | YES   | YES   | YES    |
> 3       | RET   | ON    | YES   | YES   | YES    |
> 4       | OFF   | ON    | NO    | YES   | YES    |
> 5       | RET   | RET   | YES   | YES   | YES    |
> 6       | OFF   | RET   | NO    | YES   | YES    |
> 7       | OFF   | OFF   | NO    | NO    | YES    |
> --------+-------+-------+-------+-------+--------+
>
> -- 
> Regards,
> Nishanth Menon
> From bd3d8decf922d7425b9bc9025c7709a9414ad380 Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Wed, 15 Dec 2010 18:40:29 -0600
> Subject: [PATCH 1/2] OMAP3: PM: make omap3_cpuidle_update_states independent of enable_off_mode
>
> Currently omap3_cpuidle_update_states makes whole sale decision
> on which C states to update based on enable_off_mode variable
> Instead, achieve the same functionality by independently providing
> mpu and core deepest states the system is allowed to achieve and
> update the idle states accordingly.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   19 ++++++++++---------
>  arch/arm/mach-omap2/pm.h          |    3 ++-
>  arch/arm/mach-omap2/pm34xx.c      |    2 +-
>  3 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 0d50b45..f80d3f6 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -293,25 +293,26 @@ select_state:
>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>  
>  /**
> - * omap3_cpuidle_update_states - Update the cpuidle states.
> + * omap3_cpuidle_update_states() - Update the cpuidle states
> + * @mpu_deepest_state:	Enable states upto and including this for mpu domain
> + * @core_deepest_state:	Enable states upto and including this for core domain
>   *
> - * Currently, this function toggles the validity of idle states based upon
> - * the flag 'enable_off_mode'. When the flag is set all states are valid.
> - * Else, states leading to OFF state set to be invalid.
> + * This goes through the list of states available and enables and disables the
> + * validity of C states based on deepest state that can be achieved for the
> + * variable domain
>   */
> -void omap3_cpuidle_update_states(void)
> +void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
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
> index aff39d0..3597591 100644
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
> index 21707c9..84ef71b 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -916,7 +916,7 @@ void omap3_pm_off_mode_enable(int enable)
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
> From e085afb8523ca52e52b7a631c2b63e2bd6d91661 Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> Date: Wed, 17 Nov 2010 21:46:01 -0600
> Subject: [PATCH 2/2] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
>
> Limitation i583: Self_Refresh Exit issue after OFF mode
>
> Issue:
> When device is waking up from OFF mode, then SDRC state machine sends
> inappropriate sequence violating JEDEC standards.
>
> Impact:
> OMAP3630 < ES1.2 is impacted as follows depending on the platform:
> CS0: for 38.4MHz as internal sysclk, DDR content seen to be stable, while
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
> [nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code changed a bit]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   25 ++++++++++++++++++++++---
>  1 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 84ef71b..ad60105 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -56,6 +56,7 @@
>  #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
>  
>  #define RTA_ERRATUM_i608		(1 << 0)
> +#define SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
>  static u16 pm34xx_errata;
>  #define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
>  
> @@ -916,12 +917,28 @@ void omap3_pm_off_mode_enable(int enable)
>  		state = PWRDM_POWER_RET;
>  
>  #ifdef CONFIG_CPU_IDLE
> -	omap3_cpuidle_update_states(state, state);
> +	/*
> +	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
> +	 * enable OFF mode in a stable form for previous revisions, restrict
> +	 * instead to RET
> +	 */
> +	if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583))
> +		omap3_cpuidle_update_states(state, PWRDM_POWER_RET);
> +	else
> +		omap3_cpuidle_update_states(state, state);
>  #endif
>  
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> -		pwrst->next_state = state;
> -		omap_set_pwrdm_state(pwrst->pwrdm, state);
> +		if (IS_PM34XX_ERRATUM(SDRC_WAKEUP_ERRATUM_i583) &&
> +				pwrst->pwrdm == core_pwrdm &&
> +				state == PWRDM_POWER_OFF) {
> +			pwrst->next_state = PWRDM_POWER_RET;
> +			pr_err("%s: Core OFF disabled due to errata i583\n",
> +				__func__);
> +		} else {
> +			pwrst->next_state = state;
> +		}
> +		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>  	}
>  }
>  
> @@ -999,6 +1016,8 @@ static void __init pm_errata_configure(void)
>  		pm34xx_errata |= RTA_ERRATUM_i608;
>  		/* Enable the l2 cache toggling in sleep logic */
>  		enable_omap3630_toggle_l2_on_restore();
> +		if (omap_rev() < OMAP3630_REV_ES1_2)
> +			pm34xx_errata |= SDRC_WAKEUP_ERRATUM_i583;
>  	}
>  }
