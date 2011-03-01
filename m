From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] OMAP3 PM: Deny clock gating only for safe state
Date: Tue, 01 Mar 2011 13:01:41 -0800
Message-ID: <87mxleimh6.fsf@ti.com>
References: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com>
	<1297846874-18286-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56895 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757226Ab1CAVBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 16:01:45 -0500
Received: by mail-yw0-f49.google.com with SMTP id 8so2005679ywa.8
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 13:01:44 -0800 (PST)
In-Reply-To: <1297846874-18286-2-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 16 Feb 2011 14:31:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Currently clock gating for MPU and core are denied whenever C1 state is
> selected. 

Yes, that is the definition of C1.

> It should be denied only when safe state is selected.

Why?

This changes the definition and behavior of C1 depending on how it is
entered.  Not a good idea IMO.

Kevin


> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index f8e35b3..1e4ec7f 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -139,19 +139,9 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	if (omap_irq_pending() || need_resched())
>  		goto return_sleep_time;
>  
> -	if (cx->type == OMAP3_STATE_C1) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> -	}
> -
>  	/* Execute ARM wfi */
>  	omap_sram_idle();
>  
> -	if (cx->type == OMAP3_STATE_C1) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> -	}
> -
>  return_sleep_time:
>  	getnstimeofday(&ts_postidle);
>  	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> @@ -315,8 +305,18 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  
>  select_state:
>  	dev->last_state = new_state;
> +
> +	if (new_state == dev->safe_state) {
> +		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> +		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> +	}
>  	ret = omap3_enter_idle(dev, new_state);
>  
> +	if (new_state == dev->safe_state) {
> +		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> +		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> +	}
> +
>  	/* Restore original PER state if it was modified */
>  	if (per_next_state != per_saved_state)
>  		pwrdm_set_next_pwrst(per_pd, per_saved_state);
