From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: OMAP3: Refreshed DVFS VDD1 control against latest clock fw
Date: Mon, 12 Jan 2009 17:04:45 -0800
Message-ID: <87wsd0m2xe.fsf@deeprootsystems.com>
References: <1231515465-10162-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:34906 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbZAMBEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 20:04:51 -0500
Received: by an-out-0708.google.com with SMTP id d40so3611193and.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Jan 2009 17:04:50 -0800 (PST)
In-Reply-To: <1231515465-10162-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\,  9 Jan 2009 17\:37\:45 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> New clock framework patches from Paul Walmsley broke the DVFS for OMAP3.
> This patch fixes the VDD1 part of it. Applies on top of latest PM branch
> (pm-next) in Kevin's tree.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, pulling into pm-next.

Kevin

> ---
>  arch/arm/mach-omap2/clock34xx.c |   11 +----------
>  arch/arm/mach-omap2/clock34xx.h |    6 ++++--
>  2 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 0434552..55981dd 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -796,11 +796,8 @@ int __init omap2_clk_init(void)
>  	for (clkp = onchip_34xx_clks;
>  	     clkp < onchip_34xx_clks + ARRAY_SIZE(onchip_34xx_clks);
>  	     clkp++) {
> -		if ((*clkp)->flags & cpu_clkflg) {
> +		if ((*clkp)->flags & cpu_clkflg)
>  			clk_register(*clkp);
> -			if (!((*clkp)->flags & VIRTUAL_CLOCK))
> -				omap2_init_clk_clkdm(*clkp);
> -		}
>  	}
>  
>  	/* REVISIT: Not yet ready for OMAP3 */
> @@ -969,10 +966,6 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
>  		clk_set_rate(dpll1_clk, prcm_vdd->rate);
>  		clk_set_rate(dpll2_clk, dsp_opps[index].rate);
>  		curr_vdd1_prcm_set = prcm_vdd;
> -		omap2_clksel_recalc(&mpu_ck);
> -		propagate_rate(&mpu_ck);
> -		omap2_clksel_recalc(&iva2_ck);
> -		propagate_rate(&iva2_ck);
>  #ifndef CONFIG_CPU_FREQ
>  		/*Update loops_per_jiffy if processor speed is being changed*/
>  		loops_per_jiffy = compute_lpj(loops_per_jiffy,
> @@ -981,8 +974,6 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
>  	} else {
>  		clk_set_rate(dpll3_clk, prcm_vdd->rate);
>  		curr_vdd2_prcm_set = prcm_vdd;
> -		omap2_clksel_recalc(&core_ck);
> -		propagate_rate(&core_ck);
>  	}
>  
>  	omap3_save_scratchpad_contents();
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index 8751fa9..8bda785 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -3341,8 +3341,9 @@ static struct clk wdt1_fck = {
>  
>  static struct clk virt_vdd1_prcm_set = {
>  	.name = "virt_vdd1_prcm_set",
> -	.flags = CLOCK_IN_OMAP343X | VIRTUAL_CLOCK | ALWAYS_ENABLED,
> +	.flags = CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
>  	.parent = &mpu_ck, /* Indexed by mpu speed, no parent */
> +	.clkdm = { .name = "virt_opp_clkdm" },
>  	.recalc = &omap3_table_recalc, /*sets are keyed on mpu rate */
>  	.set_rate = &omap3_select_table_rate,
>  	.round_rate = &omap3_round_to_table_rate,
> @@ -3350,8 +3351,9 @@ static struct clk virt_vdd1_prcm_set = {
>  
>  static struct clk virt_vdd2_prcm_set = {
>  	.name = "virt_vdd2_prcm_set",
> -	.flags = CLOCK_IN_OMAP343X | VIRTUAL_CLOCK | ALWAYS_ENABLED,
> +	.flags = CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
>  	.parent = &core_ck,
> +	.clkdm = { .name = "virt_opp_clkdm" },
>  	.recalc = &omap3_table_recalc,
>  	.set_rate = &omap3_select_table_rate,
>  	.round_rate = &omap3_round_to_table_rate,
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
