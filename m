From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3.9-stable] ARM: omap3: clock: fix wrong container_of in
 clock36xx.c
Date: Mon, 17 Jun 2013 04:56:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306170454330.4477@utopia.booyaka.com>
References: <008d01ce6aea$96291790$c27b46b0$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <008d01ce6aea$96291790$c27b46b0$%choi@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Jonghwan Choi <jhbird.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, neilb@suse.de, linux-omap@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 'Jean-Philippe Francois' <jp.francois@cynove.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 17 Jun 2013, Jonghwan Choi wrote:

> This patch looks like it should be in the 3.9-stable tree, should we apply
> it?

Please do.


- Paul

> 
> ------------------
> 
> From: "Jean-Philippe Francois <jp.francois@cynove.com>"
> 
> commit a93d8a1cea0899982993e9a93404c6f78b123697 upstream
> 
> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of
> the clock to be a clk_hw_omap. However, looking at cclock3xxx_data.c,
> all concerned clock have parent defined as clk_divider.  Fix the
> function to use clk_divider.  Tested with 3.9 on dm3730.
> 
> Signed-off-by: Jean-Philippe Francois <jp.francois@cynove.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  arch/arm/mach-omap2/clock36xx.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock36xx.c
> b/arch/arm/mach-omap2/clock36xx.c
> index 8f3bf4e..bbd6a3f 100644
> --- a/arch/arm/mach-omap2/clock36xx.c
> +++ b/arch/arm/mach-omap2/clock36xx.c
> @@ -20,11 +20,12 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/io.h>
>  
>  #include "clock.h"
>  #include "clock36xx.h"
> -
> +#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
>  
>  /**
>   * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
> @@ -39,29 +40,28 @@
>   */
>  int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
>  {
> -	struct clk_hw_omap *parent;
> +	struct clk_divider *parent;
>  	struct clk_hw *parent_hw;
> -	u32 dummy_v, orig_v, clksel_shift;
> +	u32 dummy_v, orig_v;
>  	int ret;
>  
>  	/* Clear PWRDN bit of HSDIVIDER */
>  	ret = omap2_dflt_clk_enable(clk);
>  
>  	parent_hw = __clk_get_hw(__clk_get_parent(clk->clk));
> -	parent = to_clk_hw_omap(parent_hw);
> +	parent = to_clk_divider(parent_hw);
>  
>  	/* Restore the dividers */
>  	if (!ret) {
> -		clksel_shift = __ffs(parent->clksel_mask);
> -		orig_v = __raw_readl(parent->clksel_reg);
> +		orig_v = __raw_readl(parent->reg);
>  		dummy_v = orig_v;
>  
>  		/* Write any other value different from the Read value */
> -		dummy_v ^= (1 << clksel_shift);
> -		__raw_writel(dummy_v, parent->clksel_reg);
> +		dummy_v ^= (1 << parent->shift);
> +		__raw_writel(dummy_v, parent->reg);
>  
>  		/* Write the original divider */
> -		__raw_writel(orig_v, parent->clksel_reg);
> +		__raw_writel(orig_v, parent->reg);
>  	}
>  
>  	return ret;
> -- 
> 1.7.9.5
> 


- Paul
