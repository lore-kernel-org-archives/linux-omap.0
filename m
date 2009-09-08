From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: Enable and autoidle DPLL5 at boot
Date: Tue, 8 Sep 2009 02:02:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0909080158540.27537@utopia.booyaka.com>
References: <1252061919-24122-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55140 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZIHIC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 04:02:27 -0400
In-Reply-To: <1252061919-24122-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Hi Anand,

looks like a good approach, just a few minor comments.

On Fri, 4 Sep 2009, Anand Gadiyar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> OMAP3: Enable and autoidle DPLL5 at boot
> 
> Enable DPLL5 at bootup and put it into auto-idle.
> This is required for the USBHOST 120MHz f-clock and USBTLL f-clock
> to work.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
> @@ -1056,6 +1056,25 @@ void omap2_clk_prepare_for_reboot(void)
>  #endif
>  }
>  
> +static void omap3_lock_dpll5(void)

Please put "clk" in this function name, like "omap3_clk_lock_dpll5" or 
something similar...

> +{
> +	struct clk *dpll5_clk;
> +	struct clk *dpll5_m2_clk;
> +
> +	dpll5_clk = clk_get(NULL, "dpll5_ck");
> +	clk_set_rate(dpll5_clk, 120000000);

Please move this constant up to a macro at the top of the file and add a 
brief descriptive comment answering the question: "why 120000000" -- e.g., 
needed by USB, etc.

> +	clk_enable(dpll5_clk);
> +
> +	/* Enable autoidle to allow it to enter low power bypass */
> +	omap3_dpll_allow_idle(dpll5_clk);
> +
> +	/* Program dpll5_m2_clk divider for no division */
> +	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
> +	clk_enable(dpll5_m2_clk);
> +	clk_set_rate(dpll5_m2_clk, 120000000);

Shouldn't we clk_disable() dpll5_clk and dpll5_m2_clk here?  The rationale 
is that we should keep these disabled until some driver signals that it 
needs them with a clk_enable().

> +	return;
> +}
> +
>  /* REVISIT: Move this init stuff out into clock.c */
>  
>  /*
> @@ -1148,6 +1167,12 @@ int __init omap2_clk_init(void)
>  	 */
>  	clk_enable_init_clocks();
>  
> +	/*
> +	 * Lock DPLL5 and put it in autoidle.
> +	 */
> +	if (omap_rev() >= OMAP3430_REV_ES2_0)
> +		omap3_lock_dpll5();
> +
>  	/* Avoid sleeping during omap2_clk_prepare_for_reboot() */
>  	/* REVISIT: not yet ready for 343x */
>  #if 0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
