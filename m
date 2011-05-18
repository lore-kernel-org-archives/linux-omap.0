From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 3/6 v2] OMAP2+: cpufreq: minor comment
 cleanup
Date: Wed, 18 May 2011 13:08:56 -0700
Message-ID: <20110518200856.GA8149@google.com>
References: <1305704266-17623-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:20482 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab1ERUJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 16:09:04 -0400
Content-Disposition: inline
In-Reply-To: <1305704266-17623-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: kevin <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 02:37:43AM -0500, Nishanth Menon wrote:
> this should probably get squashed in..
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/omap2plus-cpufreq.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 6e3666a..45f1e9e 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -84,8 +84,10 @@ static int omap_target(struct cpufreq_policy *policy,
>  	if (is_smp() && (num_online_cpus() < NR_CPUS))
>  		return ret;
>  
> -	/* Ensure desired rate is within allowed range.  Some govenors
> -	 * (ondemand) will just pass target_freq=0 to get the minimum. */
> +	/*
> +	 * Ensure desired rate is within allowed range.  Some govenors
> +	 * (ondemand) will just pass target_freq=0 to get the minimum.

So long as the comment is being touched up, could fixup the typo for
"governor" (and also copied to a new block of code in another patch
in the series).

> +	 */
>  	if (target_freq < policy->min)
>  		target_freq = policy->min;
>  	if (target_freq > policy->max)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
