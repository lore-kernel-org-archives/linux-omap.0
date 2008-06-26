From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 clock: DPLL{1,2}_FCLK clksel can divide by 4
Date: Thu, 26 Jun 2008 16:50:54 +0300
Message-ID: <20080626135053.GM12992@atomide.com>
References: <alpine.DEB.1.00.0806240111320.9741@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49302 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbYFZNu5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:50:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806240111320.9741@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080624 10:12]:
> 
> OMAP34xx ES2 TRM Delta G to H states that the divider for DPLL1_FCLK and 
> DPLL2_FCLK can divide by 4 in addition to dividing by 1 and 2. Encode this 
> into the OMAP3 clock framework.

Pushing today.

Tony

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> 
>  arch/arm/mach-omap2/clock34xx.h |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index b4dceea..9605744 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -1029,8 +1029,15 @@ static struct clk corex2_fck = {
>  
>  /* DPLL power domain clock controls */
>  
> -static const struct clksel div2_core_clksel[] = {
> -	{ .parent = &core_ck, .rates = div2_rates },
> +static const struct clksel_rate div4_rates[] = {
> +	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
> +	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
> +	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
> +	{ .div = 0 }
> +};
> +
> +static const struct clksel div4_core_clksel[] = {
> +	{ .parent = &core_ck, .rates = div4_rates },
>  	{ .parent = NULL }
>  };
>  
> @@ -1044,7 +1051,7 @@ static struct clk dpll1_fck = {
>  	.init		= &omap2_init_clksel_parent,
>  	.clksel_reg	= _OMAP34XX_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
>  	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
> -	.clksel		= div2_core_clksel,
> +	.clksel		= div4_core_clksel,
>  	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
>  				PARENT_CONTROLS_CLOCK,
>  	.recalc		= &omap2_clksel_recalc,
> @@ -1119,7 +1126,7 @@ static struct clk dpll2_fck = {
>  	.init		= &omap2_init_clksel_parent,
>  	.clksel_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
>  	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
> -	.clksel		= div2_core_clksel,
> +	.clksel		= div4_core_clksel,
>  	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
>  				PARENT_CONTROLS_CLOCK,
>  	.recalc		= &omap2_clksel_recalc,
> @@ -1155,6 +1162,11 @@ static struct clk iva2_ck = {
>  
>  /* Common interface clocks */
>  
> +static const struct clksel div2_core_clksel[] = {
> +	{ .parent = &core_ck, .rates = div2_rates },
> +	{ .parent = NULL }
> +};
> +
>  static struct clk l3_ick = {
>  	.name		= "l3_ick",
>  	.parent		= &core_ck,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
