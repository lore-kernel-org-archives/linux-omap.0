From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] OMAP4460: Clock: Adding support for 4460 specific
 clocks
Date: Thu, 22 Sep 2011 23:49:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109222338590.10719@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com> <1316705361-12175-7-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46911 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IWFth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 01:49:37 -0400
In-Reply-To: <1316705361-12175-7-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 22 Sep 2011, Keerthy wrote:

> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> OMAP4460 specific clocks are not getting added as the
> cpu_is_omap44xx is choosing only OMAP4430 specific clock nodes.

> Changing it to add to OMAP4460 specific clocks also.
> This is clocks are required of temperature sensor.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: paul@pwsan.com 
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index c51e513..f72513b 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -1398,9 +1398,9 @@ static struct clk dss_dss_clk = {
>  };
>  
>  static const struct clksel_rate div3_8to32_rates[] = {
> -	{ .div = 8, .val = 0, .flags = RATE_IN_44XX },
> -	{ .div = 16, .val = 1, .flags = RATE_IN_44XX },
> -	{ .div = 32, .val = 2, .flags = RATE_IN_44XX },
> +	{ .div = 8, .val = 0, .flags = RATE_IN_4460 },
> +	{ .div = 16, .val = 1, .flags = RATE_IN_4460 },
> +	{ .div = 32, .val = 2, .flags = RATE_IN_4460 },

Are these rates really 4460-specific?  If so, then it looks like something 
is broken in the clock data generator.  Clearly, I should not have acked 
these patches and they should never have been merged.

>  	{ .div = 0 },
>  };
>  
> @@ -3403,12 +3403,12 @@ int __init omap4xxx_clk_init(void)
>  	struct omap_clk *c;
>  	u32 cpu_clkflg;
>  
> -	if (cpu_is_omap44xx()) {
> +	if (cpu_is_omap443x()) {
>  		cpu_mask = RATE_IN_4430;
>  		cpu_clkflg = CK_443X;
>  	} else if (cpu_is_omap446x()) {
> -		cpu_mask = RATE_IN_4460;
> -		cpu_clkflg = CK_446X;
> +		cpu_mask = RATE_IN_4460 | RATE_IN_4430;
> +		cpu_clkflg = CK_446X | CK_443X;

This isn't right.  Until the clock data files are converted to use per-SoC 
lists, what needs to be done here is to define a RATE_IN_44XX and CK_44XX 
that will match all existing 4430/4460/4470 clocks.  Then for rates and 
clocks that are only specific to one of those SoCs, the appropriate 
SoC-specific flag should be set.

>  	} else {
>  		return 0;
>  	}
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
