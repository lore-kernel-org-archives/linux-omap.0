From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] omap3: Check return values for clk_get()
Date: Thu, 28 Jan 2010 11:08:54 -0800
Message-ID: <87tyu6qc6x.fsf@deeprootsystems.com>
References: <1264691804-29427-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:40591 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab0A1TJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 14:09:01 -0500
Received: by fxm7 with SMTP id 7so1226686fxm.28
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 11:09:00 -0800 (PST)
In-Reply-To: <1264691804-29427-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Thu\, 28 Jan 2010 20\:46\:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> This patch checks if clk_get() returned success for
> the clocks used in function omap2_clk_arch_init().
>
> This version incorporates review comments from
> Kevin Hilman and Paul Walmsley.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/clock34xx.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 1f1b5a6..ad09f04 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -21,6 +21,7 @@
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/err.h>
>  
>  #include <plat/cpu.h>
>  #include <plat/clock.h>
> @@ -184,6 +185,7 @@ static int __init omap3xxx_clk_arch_init(void)
>  {
>  	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
>  	unsigned long osc_sys_rate;
> +	bool err = 0 ;
>  
>  	if (!cpu_is_omap34xx())
>  		return 0;
> @@ -193,9 +195,23 @@ static int __init omap3xxx_clk_arch_init(void)
>  
>  	/* XXX test these for success */
>  	dpll1_ck = clk_get(NULL, "dpll1_ck");
> +	if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
> +		err = 1;
> +
>  	arm_fck = clk_get(NULL, "arm_fck");
> +	if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
> +		err = 1;
> +
>  	core_ck = clk_get(NULL, "core_ck");
> +	if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
> +		err = 1;
> +
>  	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
> +	if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
> +		err = 1;
> +
> +	if (err)
> +		return -ENOENT;
>  
>  	/* REVISIT: not yet ready for 343x */
>  	if (clk_set_rate(dpll1_ck, mpurate))
> -- 
> 1.6.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
