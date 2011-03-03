From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] OMAP3: CPUIdle: prevent CORE from going off if doing
 so would reset an active clockdomain
Date: Thu, 03 Mar 2011 15:48:36 -0800
Message-ID: <1299196116.3989.423.camel@vence>
References: <1295606225-11834-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54869 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759055Ab1CCXsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 18:48:42 -0500
Received: by vws12 with SMTP id 12so1533419vws.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 15:48:41 -0800 (PST)
In-Reply-To: <1295606225-11834-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Hi Tero,

On Fri, 2011-01-21 at 12:37 +0200, Tero Kristo wrote:
> On OMAP3 SoCs, if the CORE powerdomain enters off-mode, many other
> parts of the chip will be reset.  If those parts of the chip are busy,
> the reset will disrupt them, causing unpredictable and generally
> undesirable results. This reset is caused by the core domain wakeup
> (COREDOMAINWKUP_RST), and it can occur for example in a case where
> some peripheral domain is in retention or inactive state and core
> enters off. This will result in the peripheral domain being reset.

Found a minor bug here...

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   40 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index f3e043f..d31b858 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -61,7 +61,7 @@ struct omap3_processor_cx {
>  struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
>  struct omap3_processor_cx current_cx_state;
>  struct powerdomain *mpu_pd, *core_pd, *per_pd;
> -struct powerdomain *cam_pd;
> +struct powerdomain *cam_pd, *dss_pd, *iva2_pd, *sgx_pd, *usb_pd;
>  
>  /*
>   * The latencies/thresholds for various C states have
> @@ -235,7 +235,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  {
>  	struct cpuidle_state *new_state = next_valid_state(dev, state);
>  	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
> -	u32 cam_state;
> +	u32 cam_state, dss_state, iva2_state, sgx_state, usb_state;
>  	struct omap3_processor_cx *cx;
>  	int ret;
>  
> @@ -256,6 +256,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  	 *        its own code.
>  	 */
>  
> +	/* XXX Add CORE-active check here */
> +
>  	/*
>  	 * Prevent idle completely if CAM is active.
>  	 * CAM does not have wakeup capability in OMAP3.
> @@ -275,6 +277,36 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  	    (core_next_state > PWRDM_POWER_RET))
>  		per_next_state = PWRDM_POWER_RET;
>  
> +	/* XXX Add prevent-PER-off check here */
> +
> +	/*
> +	 * If we are attempting CORE off, check if any other powerdomains
> +	 * are at retention or higher. CORE off causes chipwide reset which
> +	 * would reset these domains also.
> +	 */
> +	if (core_next_state == PWRDM_POWER_OFF) {
> +		iva2_state = pwrdm_read_pwrst(iva2_pd);
> +		sgx_state = pwrdm_read_pwrst(sgx_pd);
> +		usb_state = pwrdm_read_pwrst(usb_pd);
> +		dss_state = pwrdm_read_pwrst(dss_pd);
> +
> +		if (cam_state > PWRDM_POWER_OFF ||
> +		    dss_state > PWRDM_POWER_OFF ||
> +		    iva2_state > PWRDM_POWER_OFF ||
> +		    per_next_state > PWRDM_POWER_OFF ||
> +		    sgx_state > PWRDM_POWER_OFF ||
> +		    usb_state > PWRDM_POWER_OFF)
> +			core_next_state = PWRDM_POWER_RET;
> +	}
> +
> +	/* Fallback to new target core/mpu state */
> +	while (cx->core_state < core_next_state) {
> +		state--;

This can potentially pick a state that has its 'valid' flag set to zero,
for example, a state with MPU/CORE set to off-mode, but
enable_off_mode=0.

The fix is to also add a check for cx->valid in the while test.  Will
fold that fix into original patch and queue for 2.6.39.

Kevin

> +		cx = cpuidle_get_statedata(state);
> +	}
> +
> +	new_state = state;
> +
>  	/* Are we changing PER target state? */
>  	if (per_next_state != per_saved_state)
>  		pwrdm_set_next_pwrst(per_pd, per_next_state);
> @@ -489,6 +521,10 @@ int __init omap3_idle_init(void)
>  	core_pd = pwrdm_lookup("core_pwrdm");
>  	per_pd = pwrdm_lookup("per_pwrdm");
>  	cam_pd = pwrdm_lookup("cam_pwrdm");
> +	dss_pd = pwrdm_lookup("dss_pwrdm");
> +	iva2_pd = pwrdm_lookup("iva2_pwrdm");
> +	sgx_pd = pwrdm_lookup("sgx_pwrdm");
> +	usb_pd = pwrdm_lookup("usbhost_pwrdm");
>  
>  	omap_init_power_states();
>  	cpuidle_register_driver(&omap3_idle_driver);


