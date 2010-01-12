From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 6/6] OMAP3: CPUidle: Added peripheral pwrdm checks into bm check
Date: Tue, 12 Jan 2010 10:50:06 -0800
Message-ID: <87vdf7b1k1.fsf@deeprootsystems.com>
References: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-2-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-3-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-4-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-5-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-6-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-7-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:44315 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0ALSuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 13:50:10 -0500
Received: by iwn35 with SMTP id 35so15794284iwn.4
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 10:50:09 -0800 (PST)
In-Reply-To: <1259916781-2741-7-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\,  4 Dec 2009 10\:53\:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Following checks are made (and their reasoning):
>
> - If CAM domain is active, prevent idle completely
>   * CAM pwrdm does not have HW wakeup capability
> - If PER is likely to remain on, prevent PER off
>   * Saves on unnecessary context save/restore
> - If CORE domain is active, prevent PER off-mode
>   * PER off in this case would prevent wakeups from PER completely
> - Only allow CORE off, if all peripheral domains are off
>   * CORE off will cause a chipwide reset
>
> Also, enabled CHECK_BM flag for C2, as this is needed for the camera case.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Looks good, will queue when dependencies are ready.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |  118 ++++++++++++++++++++++++++++++++++--
>  1 files changed, 111 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4a81ef1..dad64a9 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -58,7 +58,8 @@ struct omap3_processor_cx {
>  
>  struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
>  struct omap3_processor_cx current_cx_state;
> -struct powerdomain *mpu_pd, *core_pd;
> +struct powerdomain *mpu_pd, *core_pd, *per_pd, *iva2_pd;
> +struct powerdomain *sgx_pd, *usb_pd, *cam_pd, *dss_pd;
>  
>  /*
>   * The latencies/thresholds for various C states have
> @@ -92,6 +93,22 @@ static int omap3_idle_bm_check(void)
>  }
>  
>  /**
> + * pwrdm_get_idle_state - Get the power state a pwrdm will enter during idle
> + * @pwrdm: powerdomain to check state for
> + *
> + * Checks if the powerdomain can enter idle or not, if yes, will return
> + * the programmed target state for the domain. Otherwise will indicate
> + * that the domain will stay on.
> + * Returns the power state the pwrdm will enter.
> + */
> +static int pwrdm_get_idle_state(struct powerdomain *pwrdm)
> +{
> +	if (pwrdm_can_idle(pwrdm))
> +		return pwrdm_read_next_pwrst(pwrdm);
> +	return PWRDM_POWER_ON;
> +}
> +
> +/**
>   * omap3_enter_idle - Programs OMAP3 to enter the specified state
>   * @dev: cpuidle device
>   * @state: The target state to be programmed
> @@ -153,14 +170,94 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  			       struct cpuidle_state *state)
>  {
>  	struct cpuidle_state *new_state = state;
> -
> -	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
> -		BUG_ON(!dev->safe_state);
> -		new_state = dev->safe_state;
> +	u32 per_state = 0, saved_per_state = 0, cam_state, usb_state;
> +	u32 iva2_state, sgx_state, dss_state, new_core_state;
> +	struct omap3_processor_cx *cx;
> +	int ret;
> +
> +	if (state->flags & CPUIDLE_FLAG_CHECK_BM) {
> +		if (omap3_idle_bm_check()) {
> +			BUG_ON(!dev->safe_state);
> +			new_state = dev->safe_state;
> +			goto select_state;
> +		}
> +		cx = cpuidle_get_statedata(state);
> +		new_core_state = cx->core_state;
> +
> +		/* Check if CORE is active, if yes, fallback to inactive */
> +		if (!pwrdm_can_idle(core_pd))
> +			new_core_state = PWRDM_POWER_INACTIVE;
> +
> +		/*
> +		 * Prevent idle completely if CAM is active.
> +		 * CAM does not have wakeup capability in OMAP3.
> +		 */
> +		cam_state = pwrdm_get_idle_state(cam_pd);
> +		if (cam_state == PWRDM_POWER_ON) {
> +			new_state = dev->safe_state;
> +			goto select_state;
> +		}
> +
> +		/*
> +		 * Check if PER can idle or not. If we are not likely
> +		 * to idle, deny PER off. This prevents unnecessary
> +		 * context save/restore.
> +		 */
> +		saved_per_state = pwrdm_read_next_pwrst(per_pd);
> +		if (pwrdm_can_idle(per_pd)) {
> +			per_state = saved_per_state;
> +			/*
> +			 * Prevent PER off if CORE is active as this
> +			 * would disable PER wakeups completely
> +			 */
> +			if (per_state == PWRDM_POWER_OFF &&
> +			    new_core_state > PWRDM_POWER_RET)
> +				per_state = PWRDM_POWER_RET;
> +
> +		} else if (saved_per_state == PWRDM_POWER_OFF)
> +			per_state = PWRDM_POWER_RET;
> +
> +		/*
> +		 * If we are attempting CORE off, check if any other
> +		 * powerdomains are at retention or higher. CORE off causes
> +		 * chipwide reset which would reset these domains also.
> +		 */
> +		if (new_core_state == PWRDM_POWER_OFF) {
> +			dss_state = pwrdm_get_idle_state(dss_pd);
> +			iva2_state = pwrdm_get_idle_state(iva2_pd);
> +			sgx_state = pwrdm_get_idle_state(sgx_pd);
> +			usb_state = pwrdm_get_idle_state(usb_pd);
> +
> +			if (cam_state > PWRDM_POWER_OFF ||
> +			    dss_state > PWRDM_POWER_OFF ||
> +			    iva2_state > PWRDM_POWER_OFF ||
> +			    per_state > PWRDM_POWER_OFF ||
> +			    sgx_state > PWRDM_POWER_OFF ||
> +			    usb_state > PWRDM_POWER_OFF)
> +				new_core_state = PWRDM_POWER_RET;
> +		}
> +
> +		/* Fallback to new target core state */
> +		while (cx->core_state > new_core_state) {
> +			state--;
> +			cx = cpuidle_get_statedata(state);
> +		}
> +		new_state = state;
> +
> +		/* Are we changing PER target state? */
> +		if (per_state != saved_per_state)
> +			pwrdm_set_next_pwrst(per_pd, per_state);
>  	}
>  
> +select_state:
>  	dev->last_state = new_state;
> -	return omap3_enter_idle(dev, new_state);
> +	ret = omap3_enter_idle(dev, new_state);
> +
> +	/* Restore potentially tampered PER state */
> +	if (per_state != saved_per_state)
> +		pwrdm_set_next_pwrst(per_pd, saved_per_state);
> +
> +	return ret;
>  }
>  
>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> @@ -224,7 +321,8 @@ void omap_init_power_states(void)
>  			cpuidle_params_table[OMAP3_STATE_C2].threshold;
>  	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_INACTIVE;
>  	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_INACTIVE;
> -	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
> +				CPUIDLE_FLAG_CHECK_BM;
>  
>  	/* C3 . MPU CSWR + Core inactive */
>  	omap3_power_states[OMAP3_STATE_C3].valid =
> @@ -322,6 +420,12 @@ int __init omap3_idle_init(void)
>  
>  	mpu_pd = pwrdm_lookup("mpu_pwrdm");
>  	core_pd = pwrdm_lookup("core_pwrdm");
> +	per_pd = pwrdm_lookup("per_pwrdm");
> +	iva2_pd = pwrdm_lookup("iva2_pwrdm");
> +	sgx_pd = pwrdm_lookup("sgx_pwrdm");
> +	usb_pd = pwrdm_lookup("usbhost_pwrdm");
> +	cam_pd = pwrdm_lookup("cam_pwrdm");
> +	dss_pd = pwrdm_lookup("dss_pwrdm");
>  
>  	omap_init_power_states();
>  	cpuidle_register_driver(&omap3_idle_driver);
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
