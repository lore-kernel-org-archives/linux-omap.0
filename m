From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] PM : cpuidle - Update statistics for correct state
Date: Sun, 8 Mar 2009 01:14:01 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC0EE0C0@dbde02.ent.ti.com>
References: <1236453240-7939-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815AbZCGToP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Mar 2009 14:44:15 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n27Ji40X012015
	for <linux-omap@vger.kernel.org>; Sat, 7 Mar 2009 13:44:10 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n27Ji311007800
	for <linux-omap@vger.kernel.org>; Sun, 8 Mar 2009 01:14:04 +0530 (IST)
In-Reply-To: <1236453240-7939-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sorry, missed to included a minor change. Sending updated patch in next mail.

Best regards,
Sanjeev

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Sunday, March 08, 2009 12:44 AM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH] PM : cpuidle - Update statistics for correct state
> 
> When 'enable_off_mode' is 0, and (mpu_state < 
> PWRDM_POWER_RET) the local variables mpu_state and core_state 
> are modified; but the usage count for the original state 
> selected by the governor are updated.
> 
> This patch updates the 'last_state' in the cpuidle driver to 
> ensure that statistics for the correct state are updated.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   25 +++++++++++++++++--------
>  1 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index 62fbb2e..5838838 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -76,23 +76,32 @@ static int omap3_enter_idle(struct 
> cpuidle_device *dev,  {
>  	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
>  	struct timespec ts_preidle, ts_postidle, ts_idle;
> -	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
> +	u32 mpu_state, core_state;
>  
>  	current_cx_state = *cx;
>  
>  	/* Used to keep track of the total time in idle */
>  	getnstimeofday(&ts_preidle);
>  
> -	local_irq_disable();
> -	local_fiq_disable();
> -
> +	/*
> +	 * Adjust the idle state (if required).
> +	 * Also, ensure that usage statistics of correct state 
> are updated.
> +	 */
>  	if (!enable_off_mode) {
> -		if (mpu_state < PWRDM_POWER_RET)
> -			mpu_state = PWRDM_POWER_RET;
> -		if (core_state < PWRDM_POWER_RET)
> -			core_state = PWRDM_POWER_RET;
> +		if (cx->type > OMAP3_STATE_C4) {
> +			state = &(dev->states[OMAP3_STATE_C4 - 1]);
> +			dev->last_state = state ;
> +
> +			cx = cpuidle_get_statedata(state);
> +		}
>  	}
>  
> +	mpu_state = cx->mpu_state;
> +	core_state = cx->core_state;
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +
>  	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
>  	pwrdm_set_next_pwrst(core_pd, core_state);
>  
> --
> 1.5.6
> 
> 