From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: Check return values for clk_get
Date: Tue, 19 Jan 2010 18:19:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191816330.3977@utopia.booyaka.com>
References: <1262974746-5060-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48084 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755799Ab0ATBTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 20:19:14 -0500
In-Reply-To: <1262974746-5060-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Sanjeev,

some comments.


On Fri, 8 Jan 2010, Sanjeev Premi wrote:

> This patch checks if clk_get() returned success for
> the clocks used in function omap2_clk_arch_init().
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index d4217b9..2c2165b 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -316,17 +316,38 @@ static int __init omap2_clk_arch_init(void)
>  {
>  	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
>  	unsigned long osc_sys_rate;
> +	short err = 0 ;

Why a 'short' here?  Seems like it makes more sense as a bool.

>  
>  	if (!mpurate)
>  		return -EINVAL;
>  
> -	/* XXX test these for success */
>  	dpll1_ck = clk_get(NULL, "dpll1_ck");
> +	if (dpll1_ck == NULL) {
> +		err = 1;
> +		pr_err("*** Failed to get dpll1_ck.\n");
> +	}
> +
>  	arm_fck = clk_get(NULL, "arm_fck");
> +	if (arm_fck == NULL) {
> +		err = 1;
> +		pr_err("*** Failed to get arm_fck.\n");
> +	}
> +
>  	core_ck = clk_get(NULL, "core_ck");
> +	if (core_ck == NULL) {
> +		err = 1;
> +		pr_err("*** Failed to get core_ck.\n");
> +	}
> +
>  	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
> +	if (osc_sys_ck == NULL) {
> +		err = 1;
> +		pr_err("*** Failed to get osc_sys_ck.\n");
> +	}
> +
> +	if (err)
> +		return 1;

This is not a good error value.  This function should return either 0 for 
success or a negative error number on failure.  Maybe ENOENT?

>  
> -	/* REVISIT: not yet ready for 343x */
>  	if (clk_set_rate(dpll1_ck, mpurate))
>  		printk(KERN_ERR "*** Unable to set MPU rate\n");
>  
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
