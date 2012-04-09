From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 10/17][V2] ARM: OMAP3: cpuidle - remove the 'valid' field
Date: Mon, 09 Apr 2012 16:13:46 -0700
Message-ID: <874nss8pn9.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
	<1333570371-1389-11-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:35304 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753137Ab2DIXNl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Apr 2012 19:13:41 -0400
Received: by dadz9 with SMTP id z9so5474332dad.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 16:13:40 -0700 (PDT)
In-Reply-To: <1333570371-1389-11-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:44 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> With the previous changes all the states are valid, except
> the last state which can be handled by decreasing the number
> of states.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 11a2c23..3f46e45 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -67,7 +67,6 @@ static struct cpuidle_params cpuidle_params_table[] = {
>  struct omap3_idle_statedata {
>  	u32 mpu_state;
>  	u32 core_state;
> -	u8 valid;
>  };
>  struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
>  
> @@ -191,8 +190,7 @@ static int next_valid_state(struct cpuidle_device *dev,
>  	}
>  
>  	/* Check if current state is valid */
> -	if ((cx->valid) &&
> -	    (cx->mpu_state >= mpu_deepest_state) &&
> +	if ((cx->mpu_state >= mpu_deepest_state) &&
>  	    (cx->core_state >= core_deepest_state)) {
>  		return index;
>  	} else {
> @@ -216,8 +214,7 @@ static int next_valid_state(struct cpuidle_device *dev,
>  		idx--;
>  		for (; idx >= 0; idx--) {
>  			cx = cpuidle_get_statedata(&dev->states_usage[idx]);
> -			if ((cx->valid) &&
> -			    (cx->mpu_state >= mpu_deepest_state) &&
> +			if ((cx->mpu_state >= mpu_deepest_state) &&
>  			    (cx->core_state >= core_deepest_state)) {
>  				next_index = idx;
>  				break;
> @@ -371,7 +368,6 @@ static inline struct omap3_idle_statedata *_fill_cstate_usage(
>  	struct omap3_idle_statedata *cx = &omap3_idle_data[idx];
>  	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
>  
> -	cx->valid		= cpuidle_params_table[idx].valid;
>  	cpuidle_set_statedata(state_usage, cx);
>  
>  	return cx;
> @@ -399,7 +395,6 @@ int __init omap3_idle_init(void)
>  
>  	/* C1 . MPU WFI + Core active */
>  	cx = _fill_cstate_usage(dev, 0);
> -	cx->valid = 1;	/* C1 is always valid */
>  	cx->mpu_state = PWRDM_POWER_ON;
>  	cx->core_state = PWRDM_POWER_ON;
>  
> @@ -436,14 +431,13 @@ int __init omap3_idle_init(void)
>  	 * We disable C7 state as a result.
>  	 */
>  	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
> -		cx->valid = 0;
> +		drv->state_count = OMAP3_NUM_STATES - 1;
>  		pr_warn("%s: core off state C7 disabled due to i583\n",
>  			__func__);

I'm not too particular about this one, but it might be cleaner to just
remove this check all together.  This errata already has a check in
next_valid_state() so strictly speaking, it's not needed here.

Kevin

>  	}
>  	cx->mpu_state = PWRDM_POWER_OFF;
>  	cx->core_state = PWRDM_POWER_OFF;
>  
> -	drv->state_count = OMAP3_NUM_STATES;
>  	cpuidle_register_driver(&omap3_idle_driver);
>  
>  	if (cpuidle_register_device(dev)) {
