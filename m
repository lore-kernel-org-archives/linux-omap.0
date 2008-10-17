From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix whitespaces in smartreflex.c
Date: Fri, 17 Oct 2008 15:31:27 -0700
Message-ID: <20081017223127.GJ18573@atomide.com>
References: <1223647528-23054-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65390 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbYJQWb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:31:28 -0400
Content-Disposition: inline
In-Reply-To: <1223647528-23054-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [081010 07:06]:
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Pushing.

Tony

> ---
>  arch/arm/mach-omap2/smartreflex.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 33f604d..453569a 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -43,10 +43,10 @@ struct omap_sr {
>  	int		srid;
>  	int		is_sr_reset;
>  	int		is_autocomp_active;
> -	struct clk 	*clk;
> -	u32 		clk_length;
> -	u32 		req_opp_no;
> -	u32 		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
> +	struct clk	*clk;
> +	u32		clk_length;
> +	u32		req_opp_no;
> +	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
>  	u32		opp5_nvalue;
>  	u32		senp_mod, senn_mod;
>  	void __iomem	*srbase_addr;
> @@ -55,9 +55,9 @@ struct omap_sr {
>  
>  /* Custom clocks to enable SR specific enable/disable functions. */
>  struct sr_custom_clk {
> -	struct clk 	clk;  /* meta-clock with custom enable/disable calls */
> -	struct clk 	*fck; /* actual functional clock */
> -	struct omap_sr 	*sr;
> +	struct clk	clk;  /* meta-clock with custom enable/disable calls */
> +	struct clk	*fck; /* actual functional clock */
> +	struct omap_sr	*sr;
>  };
>  
>  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
> @@ -136,7 +136,7 @@ static struct omap_sr sr2 = {
>  
>  static struct sr_custom_clk sr1_custom_clk = {
>  	.clk = {
> -			.name 		= "sr1_custom_clk",
> +			.name		= "sr1_custom_clk",
>  			.enable		= sr_clk_enable,
>  			.disable	= sr_clk_disable,
>  	},
> @@ -145,7 +145,7 @@ static struct sr_custom_clk sr1_custom_clk = {
>  
>  static struct sr_custom_clk sr2_custom_clk = {
>  	.clk = {
> -			.name 		= "sr2_custom_clk",
> +			.name		= "sr2_custom_clk",
>  			.enable		= sr_clk_enable,
>  			.disable	= sr_clk_disable,
>  	},
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
