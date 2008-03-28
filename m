From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3 clock: convert mask_to_shift() to __ffs()
Date: Fri, 28 Mar 2008 12:15:40 +0200
Message-ID: <20080328101538.GM24896@atomide.com>
References: <alpine.DEB.1.00.0803280025150.13553@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60915 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbYC1KPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:15:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0803280025150.13553@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080328 08:26]:
> 
> In OMAP2/3 clock code, we've used mask_to_shift() to convert bitmasks
> into shift values, via "ffs(mask) - 1".  It turns out that there is
> already a Linux idiom for this in asm/bitops.h: __ffs().  (Not to be
> confused with ffs(), of course.  You wouldn't do that, would you?)
> When in Rome, do as the Romans.

Pushing today & folding this into the omap2-upstream series.

Tony


> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/mach-omap2/clock.c     |   18 +++++++-----------
>  arch/arm/mach-omap2/clock.h     |    1 -
>  arch/arm/mach-omap2/clock24xx.c |    5 +++--
>  arch/arm/mach-omap2/clock34xx.c |    4 ++--
>  4 files changed, 12 insertions(+), 16 deletions(-)
> 
> Index: linux-omap/arch/arm/mach-omap2/clock.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/clock.c	2008-03-27 19:06:55.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/clock.c	2008-03-27 19:11:41.000000000 -0600
> @@ -21,6 +21,7 @@
>  #include <linux/errno.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <asm/bitops.h>
>  
>  #include <asm/io.h>
>  
> @@ -46,11 +47,6 @@
>   * Omap2 specific clock functions
>   *-------------------------------------------------------------------------*/
>  
> -u8 mask_to_shift(u32 mask)
> -{
> -	return ffs(mask) - 1;
> -}
> -
>  /**
>   * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
>   * @clk: OMAP clock struct ptr to use
> @@ -69,7 +65,7 @@
>  		return;
>  
>  	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
> -	r >>= mask_to_shift(clk->clksel_mask);
> +	r >>= __ffs(clk->clksel_mask);
>  
>  	for (clks = clk->clksel; clks->parent && !found; clks++) {
>  		for (clkr = clks->rates; clkr->div && !found; clkr++) {
> @@ -108,9 +104,9 @@
>  
>  	dpll = cm_read_reg(dd->mult_div1_reg);
>  	dpll_mult = dpll & dd->mult_mask;
> -	dpll_mult >>= mask_to_shift(dd->mult_mask);
> +	dpll_mult >>= __ffs(dd->mult_mask);
>  	dpll_div = dpll & dd->div1_mask;
> -	dpll_div >>= mask_to_shift(dd->div1_mask);
> +	dpll_div >>= __ffs(dd->div1_mask);
>  
>  	dpll_clk = (long long)clk->parent->rate * dpll_mult;
>  	do_div(dpll_clk, dpll_div + 1);
> @@ -574,7 +570,7 @@
>  		return 0;
>  
>  	field_val = cm_read_reg(div_addr) & field_mask;
> -	field_val >>= mask_to_shift(field_mask);
> +	field_val >>= __ffs(field_mask);
>  
>  	return omap2_clksel_to_divisor(clk, field_val);
>  }
> @@ -598,7 +594,7 @@
>  
>  	reg_val = cm_read_reg(div_addr);
>  	reg_val &= ~field_mask;
> -	reg_val |= (field_val << mask_to_shift(field_mask));
> +	reg_val |= (field_val << __ffs(field_mask));
>  	cm_write_reg(reg_val, div_addr);
>  	wmb();
>  
> @@ -696,7 +692,7 @@
>  
>  	/* Set new source value (previous dividers if any in effect) */
>  	reg_val = __raw_readl(src_addr) & ~field_mask;
> -	reg_val |= (field_val << mask_to_shift(field_mask));
> +	reg_val |= (field_val << __ffs(field_mask));
>  	__raw_writel(reg_val, src_addr);
>  	wmb();
>  
> Index: linux-omap/arch/arm/mach-omap2/clock.h
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/clock.h	2008-03-27 19:06:55.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/clock.h	2008-03-27 19:10:08.000000000 -0600
> @@ -42,7 +42,6 @@
>  int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
>  u32 omap2_get_dpll_rate(struct clk *clk);
>  int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
> -u8 mask_to_shift(u32 mask);
>  
>  extern u8 cpu_mask;
>  
> Index: linux-omap/arch/arm/mach-omap2/clock24xx.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/clock24xx.c	2008-03-27 19:01:32.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/clock24xx.c	2008-03-27 19:13:29.000000000 -0600
> @@ -31,6 +31,7 @@
>  #include <asm/arch/clock.h>
>  #include <asm/arch/sram.h>
>  #include <asm/div64.h>
> +#include <asm/bitops.h>
>  
>  #include "memory.h"
>  #include "clock.h"
> @@ -224,8 +225,8 @@
>  			mult = (rate / 1000000);
>  			done_rate = CORE_CLK_SRC_DPLL;
>  		}
> -		tmpset.cm_clksel1_pll |= (div << mask_to_shift(dd->mult_mask));
> -		tmpset.cm_clksel1_pll |= (mult << mask_to_shift(dd->div1_mask));
> +		tmpset.cm_clksel1_pll |= (div << __ffs(dd->mult_mask));
> +		tmpset.cm_clksel1_pll |= (mult << __ffs(dd->div1_mask));
>  
>  		/* Worst case */
>  		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
> Index: linux-omap/arch/arm/mach-omap2/clock34xx.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/clock34xx.c	2008-03-27 18:01:36.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/clock34xx.c	2008-03-27 19:13:07.000000000 -0600
> @@ -22,12 +22,12 @@
>  #include <linux/errno.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> -
>  #include <linux/io.h>
>  
>  #include <asm/arch/clock.h>
>  #include <asm/arch/sram.h>
>  #include <asm/div64.h>
> +#include <asm/bitops.h>
>  
>  #include "memory.h"
>  #include "clock.h"
> @@ -79,7 +79,7 @@
>  	WARN_ON(!dd->control_reg || !dd->enable_mask);
>  
>  	v = cm_read_reg(dd->control_reg) & dd->enable_mask;
> -	v >>= mask_to_shift(dd->enable_mask);
> +	v >>= __ffs(dd->enable_mask);
>  	if (v != DPLL_LOCKED)
>  		clk->rate = clk->parent->rate;
>  	else
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
