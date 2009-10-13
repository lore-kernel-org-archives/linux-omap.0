From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] OMAP3: PM: SmartReflex: Fix scheduled while atomic problem
Date: Tue, 13 Oct 2009 07:49:07 -0700
Message-ID: <87ljjfnycc.fsf@deeprootsystems.com>
References: <1255423185-30568-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:37652 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759579AbZJMOuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 10:50:22 -0400
Received: by pxi10 with SMTP id 10so93920pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 07:49:10 -0700 (PDT)
In-Reply-To: <1255423185-30568-1-git-send-email-eduardo.valentin@nokia.com> (Eduardo Valentin's message of "Tue\, 13 Oct 2009 11\:39\:45 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>, Nishanth Menon <nm@ti.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Quadros Roger <ext-roger.quadros@nokia.com>

Eduardo Valentin <eduardo.valentin@nokia.com> writes:

> This patch moves clock lookup from get_vdd[1,2]_opp to
> initialization procedure. Also adds a field in omap_sr
> structure to store these clocks for later usage.
>
> Calling clk_get inside get_vdd[1,2]_opp would cause
> a scheduled while atomic problem while entering in idle
> state (interrupts disabled).
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>

Thanks, will pull into next PM branch.  Note that SR is in the middle
of a complete rewrite, so Nishanth, please ensure this fix is included
or verify that it is not needed in your rewrite.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   19 +++++++++----------
>  1 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 8660863..8946e7c 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -43,6 +43,7 @@ struct omap_sr {
>  	int		is_sr_reset;
>  	int		is_autocomp_active;
>  	struct clk	*clk;
> +	struct clk	*vdd_opp_clk;
>  	u32		clk_length;
>  	u32		req_opp_no;
>  	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
> @@ -170,28 +171,24 @@ static u16 get_opp(struct omap_opp *opp_freq_table,
>  static u16 get_vdd1_opp(void)
>  {
>  	u16 opp;
> -	struct clk *clk;
>  
> -	clk = clk_get(NULL, "dpll1_ck");
> -
> -	if (clk == NULL || IS_ERR(clk) || mpu_opps == NULL)
> +	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
> +							mpu_opps == NULL)
>  		return 0;
>  
> -	opp = get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
> +	opp = get_opp(mpu_opps + MAX_VDD1_OPP, sr1.vdd_opp_clk->rate);
>  	return opp;
>  }
>  
>  static u16 get_vdd2_opp(void)
>  {
>  	u16 opp;
> -	struct clk *clk;
> -
> -	clk = clk_get(NULL, "l3_ick");
>  
> -	if (clk == NULL || IS_ERR(clk) || l3_opps == NULL)
> +	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk) ||
> +							l3_opps == NULL)
>  		return 0;
>  
> -	opp = get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);
> +	opp = get_opp(l3_opps + MAX_VDD2_OPP, sr2.vdd_opp_clk->rate);
>  	return opp;
>  }
>  
> @@ -999,6 +996,8 @@ static int __init omap3_sr_init(void)
>  		sr1.clk = clk_get(NULL, "sr1_fck");
>  		sr2.clk = clk_get(NULL, "sr2_fck");
>  	}
> +	sr1.vdd_opp_clk = clk_get(NULL, "dpll1_ck");
> +	sr2.vdd_opp_clk = clk_get(NULL, "l3_ick");
>  	sr_set_clk_length(&sr1);
>  	sr_set_clk_length(&sr2);
>  
> -- 
> 1.6.4.183.g04423
