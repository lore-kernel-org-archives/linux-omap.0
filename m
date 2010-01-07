From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip-opp][PATCH] omap3: pm: sr: fix get_vddx_opp to use ceil
Date: Thu, 07 Jan 2010 10:18:20 -0800
Message-ID: <873a2h4w43.fsf@deeprootsystems.com>
References: <[PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp>
	<1262829402-10158-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:53941 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab0AGSSY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 13:18:24 -0500
Received: by pxi4 with SMTP id 4so1444338pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 07 Jan 2010 10:18:23 -0800 (PST)
In-Reply-To: <1262829402-10158-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Wed\,  6 Jan 2010 19\:56\:42 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> commit ad248123 changed the behavior of get_vdd1_opp and get_vdd2_opp
> to use exact frequencies causing a break in rx51. we re-introduce the
> approximate search to maintain consistent behavior.
>
> The DPLL frequencies are expected to be the same as the OPP frequencies,
> inconsistency here should be investigated, this introduces a warning for
> the same.
>
> Discussion: http://marc.info/?t=125800503700009&r=1&w=2
>
> Reported-by: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, this is what I was hoping for.

Folding into original patch and will push new pm-wip-opp.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   23 ++++++++++++++++++++---
>  1 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index d341857..c518f9e 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -150,14 +150,23 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
>  static u8 get_vdd1_opp(void)
>  {
>  	struct omap_opp *opp;
> +	unsigned long freq;
>  
>  	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
>  							mpu_opps == NULL)
>  		return 0;
>  
> -	opp = opp_find_freq_exact(mpu_opps, sr1.vdd_opp_clk->rate, true);
> +	freq = sr1.vdd_opp_clk->rate;
> +	opp = opp_find_freq_ceil(mpu_opps, &freq);
>  	if (IS_ERR(opp))
>  		return 0;
> +	/*
> +	 * Use higher freq voltage even if an exact match is not available
> +	 * we are probably masking a clock framework bug, so warn
> +	 */
> +	if (unlikely(freq != sr1.vdd_opp_clk->rate))
> +		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
> +			   __func__, freq, sr1.vdd_opp_clk->rate);
>  
>  	return opp_get_opp_id(opp);
>  }
> @@ -165,15 +174,23 @@ static u8 get_vdd1_opp(void)
>  static u8 get_vdd2_opp(void)
>  {
>  	struct omap_opp *opp;
> +	unsigned long freq;
>  
>  	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk) ||
>  							l3_opps == NULL)
>  		return 0;
> -
> -	opp = opp_find_freq_exact(l3_opps, sr2.vdd_opp_clk->rate, true);
> +	freq = sr2.vdd_opp_clk->rate;
> +	opp = opp_find_freq_ceil(l3_opps, &freq);
>  	if (IS_ERR(opp))
>  		return 0;
>  
> +	/*
> +	 * Use higher freq voltage even if an exact match is not available
> +	 * we are probably masking a clock framework bug, so warn
> +	 */
> +	if (unlikely(freq != sr2.vdd_opp_clk->rate))
> +		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
> +			   __func__, freq, sr2.vdd_opp_clk->rate);
>  	return opp_get_opp_id(opp);
>  }
>  
> -- 
> 1.6.3.3
