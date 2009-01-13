From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] Fix omap_getspeed.
Date: Mon, 12 Jan 2009 20:38:10 -0800
Message-ID: <874p03n7m5.fsf@deeprootsystems.com>
References: <1228231877-18114-1-git-send-email-peter.de-schrijver@nokia.com>
	<1228231877-18114-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f13.google.com ([209.85.217.13]:56014 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZAMEiP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 23:38:15 -0500
Received: by gxk6 with SMTP id 6so79561gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 12 Jan 2009 20:38:14 -0800 (PST)
In-Reply-To: <1228231877-18114-2-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Tue\,  2 Dec 2008 17\:31\:16 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Peter,

Can you resend this against pm-next[1] with an updated description.

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |    1 +
>  arch/arm/plat-omap/cpu-omap.c   |    6 ++++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index f771b56..da27e49 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -938,6 +938,7 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
>  
>  	if (clk == &virt_vdd1_prcm_set) {
>  		curr_mpu_speed = curr_vdd1_prcm_set->rate;
> +		clk->rate = prcm_vdd->rate;
>  		clk_set_rate(dpll1_clk, prcm_vdd->rate);
>  		clk_set_rate(dpll2_clk, dsp_opps[index].rate);
>  		curr_vdd1_prcm_set = prcm_vdd;
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index ae0817d..0a7ce46 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -146,6 +146,12 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
>  							VERY_HI_RATE) / 1000;
>  	}
>  
> +	clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +	policy->cur = omap_getspeed(0);
> +
>  	/* FIXME: what's the actual transition time? */
>  	policy->cpuinfo.transition_latency = 10 * 1000 * 1000;
>  	return 0;
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
