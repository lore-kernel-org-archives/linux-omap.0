From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH take 2] ARM: OMAP3: allow setting cam_mclk rate
Date: Thu, 6 Aug 2009 05:18:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908060514590.22103@utopia.booyaka.com>
References: <200907011427.29318.tuukka.o.toivonen@nokia.com> <200907021156.25044.tuukka.o.toivonen@nokia.com> <200907021159.53071.tuukka.o.toivonen@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45020 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZHFLSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 07:18:11 -0400
In-Reply-To: <200907021159.53071.tuukka.o.toivonen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Cc: "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, sailus@maxwell.research.nokia.com, "Cohen David.A (Nokia-D/Helsinki)" <david.cohen@nokia.com>, "Hurskainen Mikko (Nokia-D/Helsinki)" <mikko.hurskainen@nokia.com>, linux-omap@vger.kernel.org

Hello Tuukka,

sorry for the delay.  A few comments:

On Thu, 2 Jul 2009, Tuukka.O Toivonen wrote:

> This patch allows drivers to modify cam_mclk rate which is
> used for generating external cam_xclka and cam_xclkb for cameras.
> 
> Signed-off-by: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |   18 ++++++++++++++++++
>  arch/arm/mach-omap2/clock34xx.h |    2 ++
>  2 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 045da92..667a608 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -898,6 +898,24 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
>  	return rate;
>  }
>  
> +/* Clock control for OMAP3 camera */
> +
> +static int omap3_cam_mclk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	const unsigned int dpll4_rate = 864000000; /* Hz */

This does not look right; we should be able to get the clock's parent rate 
via the clock framework.

> +	int clksel;
> +
> +	if (rate <= 0)
> +		return -EINVAL;
> +
> +	clksel = (dpll4_rate + (rate>>1)) / rate;
> +	clksel = clamp(clksel, 1, 16);
> +	cm_write_mod_reg(clksel, OMAP3430_CAM_MOD, CM_CLKSEL);
> +	clk->rate = dpll4_rate / clksel;
> +
> +	return 0;
> +}
> +

Can we just use the existing clksel mechanism for this clock, rather than 
using a custom set_rate function?  Or does this do something that cannot 
be handled by the clksel functions?

I think Jouni put together a draft patch for this.


>  /* Common clock code */
>  
>  /*
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index e433aec..cd9a0d3 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -37,6 +37,7 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk);
>  static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
>  static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
>  static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
> +static int omap3_cam_mclk_set_rate(struct clk *clk, unsigned long rate);
>  
>  /* Maximum DPLL multiplier, divider values for OMAP3 */
>  #define OMAP3_MAX_DPLL_MULT		2048
> @@ -2089,6 +2090,7 @@ static struct clk cam_mclk = {
>  	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
>  	.clkdm_name	= "cam_clkdm",
>  	.recalc		= &followparent_recalc,
> +	.set_rate	= &omap3_cam_mclk_set_rate,

This should have a round_rate function also.

>  };
>  
>  static struct clk cam_ick = {
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
