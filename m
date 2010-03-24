From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP] [PATCH 1/1] OMAP3: PM: cpu-omap: Check governor
 limits before applying mpu frequency
Date: Wed, 24 Mar 2010 07:40:58 -0500
Message-ID: <4BAA085A.6060100@ti.com>
References: <1269428551-779-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42642 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab0CXMlL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Mar 2010 08:41:11 -0400
In-Reply-To: <1269428551-779-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Eduardo Valentin had written, on 03/24/2010 06:02 AM, the following:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> This patch fix the sequence inside omap_target while setting
> a frequency for OMAP3 devices.
> 
> Previously any frequency was set, even if out of range. Now
> the range set by the governor is also checked for OMAP3.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Good catch. thanks.

Acked-by: Nishanth Menon <nm@ti.com>

> ---
>  arch/arm/plat-omap/cpu-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index a69b557..0674405 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -88,7 +88,7 @@ static int omap_target(struct cpufreq_policy *policy,
>  	struct cpufreq_freqs freqs;
>  #endif
>  #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> -	unsigned long freq = target_freq * 1000;
> +	unsigned long freq;
>  #endif
>  	int ret = 0;
>  
> @@ -114,6 +114,7 @@ static int omap_target(struct cpufreq_policy *policy,
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>  #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> +	freq = target_freq * 1000;
>  	if (opp_find_freq_ceil(OPP_MPU, &freq))
>  		omap_pm_cpu_set_freq(freq);
>  #endif


-- 
Regards,
Nishanth Menon
