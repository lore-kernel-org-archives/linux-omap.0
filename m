From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap3: Check return values for clk_get
Date: Fri, 08 Jan 2010 14:37:58 -0800
Message-ID: <87ljg8ql2x.fsf@deeprootsystems.com>
References: <1262974746-5060-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:42988 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab0AHWiC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 17:38:02 -0500
Received: by ywh6 with SMTP id 6so19932796ywh.4
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 14:38:01 -0800 (PST)
In-Reply-To: <1262974746-5060-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Fri\,  8 Jan 2010 23\:49\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

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
>  
>  	if (!mpurate)
>  		return -EINVAL;
>  
> -	/* XXX test these for success */
>  	dpll1_ck = clk_get(NULL, "dpll1_ck");
> +	if (dpll1_ck == NULL) {

All of these checks should be of the form

        if (IS_ERR(<clk>))       

instead of NULL pointer checks.

You could also do something more compact like this, which takes
care of the error check and warning print:

        if (WARN(IS_ERR(<clk ptr>), "Failed to get <name>\n"))

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

Minor issue...

Do you want to skip the rest of the init in case of any failure?

It seems like the DPLL1 is the only one that would be a real failure,
the others just affect the clock display.


Kevin

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
