From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: Correct the use of cpufreq
Date: Thu, 25 Jun 2009 09:48:24 -0700
Message-ID: <87ws70qmxz.fsf@deeprootsystems.com>
References: <12457508091766-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:24787 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbZFYQs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:48:26 -0400
Received: by wf-out-1314.google.com with SMTP id 26so575437wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:48:29 -0700 (PDT)
In-Reply-To: <12457508091766-git-send-email-ext-eero.nurkkala@nokia.com> (ext-eero nurkkala's message of "Tue\, 23 Jun 2009 12\:53\:29 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

ext-eero.nurkkala@nokia.com writes:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
>
> Wrong info was used to feed the cpufreq. It is possible
> now to get below the user defined limit defined at
> "/cpufreq/scaling_min_freq". With this patch, the
> user defined limits are being obeyed instead of
> always using the absolute max and min values supported
> by the device.
>
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Thanks, pushing to current PM branch, and backporting to pm-2.6.29.

Kevin

> ---
>  arch/arm/plat-omap/cpu-omap.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index 843e8af..1868c0d 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -78,10 +78,10 @@ static int omap_target(struct cpufreq_policy *policy,
>  
>  	/* Ensure desired rate is within allowed range.  Some govenors
>  	 * (ondemand) will just pass target_freq=0 to get the minimum. */
> -	if (target_freq < policy->cpuinfo.min_freq)
> -		target_freq = policy->cpuinfo.min_freq;
> -	if (target_freq > policy->cpuinfo.max_freq)
> -		target_freq = policy->cpuinfo.max_freq;
> +	if (target_freq < policy->min)
> +		target_freq = policy->min;
> +	if (target_freq > policy->max)
> +		target_freq = policy->max;
>  
>  	freqs.old = omap_getspeed(0);
>  	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
