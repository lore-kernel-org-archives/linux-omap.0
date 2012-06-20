From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle
 latency in C1 state
Date: Wed, 20 Jun 2012 13:49:52 +0530
Message-ID: <4FE187A8.8060203@ti.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com> <1338563468-31403-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:55499 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753274Ab2FTIUA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 04:20:00 -0400
Received: by obbwc20 with SMTP id wc20so11288294obb.3
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 01:19:58 -0700 (PDT)
In-Reply-To: <1338563468-31403-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi Jean,

On Friday 01 June 2012 08:41 PM, Jean Pihet wrote:
> For a power domain to idle all the clock domains in it must idle.
> This patch implements an optimization of the cpuidle code by
> denying and later allowing only the first registered clock domain
> of a power domain, and so optimizes the latency of the low power code.

How much do we really save doing this? I understand what you are doing
by looking at the patch but the changelog seems very confusing.
What the patch does is get rid of a few function indirection
and assumes there is only *one* clkdm for mpu and core. Is that right?

regards,
Rajendra

>
> The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
> not used anymore and so are removed.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/cpuidle34xx.c |   22 ++++------------------
>   1 files changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 2e2f1c6..e6ae3fe 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -77,20 +77,6 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
>
>   static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
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
>   static int __omap3_enter_idle(struct cpuidle_device *dev,
>   				struct cpuidle_driver *drv,
>   				int index)
> @@ -108,8 +94,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
>
>   	/* Deny idle for C1 */
>   	if (index == 0) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> +		clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
> +		clkdm_deny_idle(core_pd->pwrdm_clkdms[0]);
>   	}
>
>   	/*
> @@ -131,8 +117,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
>
>   	/* Re-allow idle for C1 */
>   	if (index == 0) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> +		clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
> +		clkdm_allow_idle(core_pd->pwrdm_clkdms[0]);
>   	}
>
>   return_sleep_time:

