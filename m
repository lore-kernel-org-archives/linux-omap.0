From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv10 31/41] ARM: OMAP2+: clock: add support for regmap
Date: Tue, 26 Nov 2013 09:40:45 -0800
Message-ID: <20131126174045.GE26766@atomide.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-32-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60717 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab3KZRkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 12:40:49 -0500
Content-Disposition: inline
In-Reply-To: <1385453182-24421-32-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131126 00:10]:
> Using regmap is required for isolating the actual memory access from
> the clock code. Now, the driver providing the support for the clock IP
> block can provide a regmap for this purpose.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/clock.c |   27 ++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/clock.h |    3 +++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 238be3f..1ef6df8 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -25,7 +25,7 @@
>  #include <linux/bitops.h>
>  #include <linux/clk-private.h>
>  #include <asm/cpu.h>
> -
> +#include <linux/regmap.h>
>  
>  #include <trace/events/power.h>
>  
> @@ -56,6 +56,31 @@ u16 cpu_mask;
>  static bool clkdm_control = true;
>  
>  static LIST_HEAD(clk_hw_omap_clocks);
> +struct regmap *clk_regmaps[CLK_MAX_REGMAPS];
> +
> +void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
> +{
> +	if (clk->flags & REGMAP_ADDRESSING) {
> +		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
> +		regmap_write(clk_regmaps[r->index], r->offset, val);
> +	} else {
> +		__raw_writel(val, reg);
> +	}
> +}
> +
> +u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
> +{
> +	u32 val;
> +
> +	if (clk->flags & REGMAP_ADDRESSING) {
> +		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
> +		regmap_read(clk_regmaps[r->index], r->offset, &val);
> +	} else {
> +		val = __raw_readl(reg);
> +	}
> +
> +	return val;
> +}
>  
>  /*
>   * Used for clocks that have the same value as the parent clock,

Maybe use read[lw]_relaxed and write[lw]_relaxed here and elsewhere
instead of __raw_read/write to help cut down the changes needed for
the big endian patch set?

Regards,

Tony
