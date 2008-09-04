From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] The clockdomain of clkout2_src_ck fixed
Date: Thu, 4 Sep 2008 11:14:16 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809041113110.10597@utopia.booyaka.com>
References: <20080904014448.GP23085@atomide.com> <1220518469-26036-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52367 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbYIDROS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 13:14:18 -0400
In-Reply-To: <1220518469-26036-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Thu, 4 Sep 2008, Tomi Valkeinen wrote:

> The clockdomain of clkout2_src_ck was set to "core_clkdm", which does not
> exist.

This is fine for now.  Technically, clkout2_src_ck is in the CM 
clockdomain, and there are some patches here that will add that; but until 
those are posted, this is good enough.

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  arch/arm/mach-omap2/clock34xx.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index 5d855e9..8da0097 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -1010,7 +1010,7 @@ static struct clk clkout2_src_ck = {
>  	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
>  	.clksel		= clkout2_src_clksel,
>  	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
> -	.clkdm		= { .name = "core_clkdm" },
> +	.clkdm		= { .name = "core_l4_clkdm" },
>  	.recalc		= &omap2_clksel_recalc,
>  };
>  
> -- 
> 1.6.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
