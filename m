From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state
Date: Thu, 31 May 2012 09:29:18 -0700
Message-ID: <87pq9k1fhd.fsf@ti.com>
References: <1336560912-26753-1-git-send-email-j-pihet@ti.com>
	<1336560912-26753-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:38445 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752743Ab2EaQ3U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 12:29:20 -0400
Received: by pbbrq13 with SMTP id rq13so1880641pbb.36
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 09:29:19 -0700 (PDT)
In-Reply-To: <1336560912-26753-2-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 9 May 2012 12:55:12 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> It is not needed to iterate through all the clock domains of a
> power domain in order to allow or deny it to idle.

Why?  (I know the answer, but would like it answered here.)

> This patch allows or denies only the first registered clock domain
> of a power domain, and so optimizes the latency of the low power
> code. The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
> not used anymore and so are removed.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Other than the changelog update, it looks good but also needs a rebase
like the previous patch.

After that, I'll add them to my for_3.6/pm/performance branch and queue
for v3.6.

Thanks!

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   22 ++++------------------
>  1 files changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 353dd8d..d44b68a 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -73,20 +73,6 @@ struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
>  
>  struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>  
> -static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
> -				struct clockdomain *clkdm)
> -{
> -	clkdm_allow_idle(clkdm);
> -	return 0;
> -}
> -
> -static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
> -				struct clockdomain *clkdm)
> -{
> -	clkdm_deny_idle(clkdm);
> -	return 0;
> -}
> -
>  static int __omap3_enter_idle(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv,
>  				int index)
> @@ -105,8 +91,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
>  
>  	/* Deny idle for C1 */
>  	if (index == 0) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> +		clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
> +		clkdm_deny_idle(core_pd->pwrdm_clkdms[0]);
>  	}
>  
>  	/*
> @@ -128,8 +114,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
>  
>  	/* Re-allow idle for C1 */
>  	if (index == 0) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> +		clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
> +		clkdm_allow_idle(core_pd->pwrdm_clkdms[0]);
>  	}
>  
>  return_sleep_time:
