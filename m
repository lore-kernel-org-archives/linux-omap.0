From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/12] ARM: OMAP2+: Add support for initializing dm814x
 clocks
Date: Thu, 16 Jul 2015 11:25:06 -0700
Message-ID: <55A7F702.6040408@codeaurora.org>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
 <1433348601-8966-6-git-send-email-tony@atomide.com>
 <20150604184254.GJ490@codeaurora.org> <20150604222823.GC30984@atomide.com>
 <20150716093746.GL17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150716093746.GL17550@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Mike Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/16/2015 02:37 AM, Tony Lindgren wrote:
>
> Here's this patch updated with the above removed.
>

Ok. I fixed up Mike's email in case he wants to look at it. Looks fine 
to me though.

>
> 8< -------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 16 Jul 2015 01:55:57 -0700
> Subject: [PATCH] ARM: OMAP2+: Add support for initializing dm814x clocks
>
> Let's add a minimal clocks for dm814x to get it booted. This is
> mostly a placeholder and relies on the PLLs being on from the
> bootloader.
>
> Note that the divider clocks work the same way as on dm816x and
> am335x.
>
> Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

>
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -558,7 +558,7 @@ void __init ti814x_init_early(void)
>   	ti81xx_hwmod_init();
>   	omap_hwmod_init_postsetup();
>   	if (of_have_populated_dt())
> -		omap_clk_soc_init = ti81xx_dt_clk_init;
> +		omap_clk_soc_init = dm814x_dt_clk_init;
>   }
>   
>   void __init ti816x_init_early(void)
> @@ -575,7 +575,7 @@ void __init ti816x_init_early(void)
>   	ti81xx_hwmod_init();
>   	omap_hwmod_init_postsetup();
>   	if (of_have_populated_dt())
> -		omap_clk_soc_init = ti81xx_dt_clk_init;
> +		omap_clk_soc_init = dm816x_dt_clk_init;
>   }
>   #endif
>   
> --- a/drivers/clk/ti/Makefile
> +++ b/drivers/clk/ti/Makefile
> @@ -2,7 +2,7 @@ obj-y					+= clk.o autoidle.o clockdomain.o
>   clk-common				= dpll.o composite.o divider.o gate.o \
>   					  fixed-factor.o mux.o apll.o
>   obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
> -obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
> +obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-814x.o clk-816x.o
>   obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
>   obj-$(CONFIG_ARCH_OMAP3)		+= $(clk-common) interface.o \
>   					   clk-3xxx.o
> --- /dev/null
> +++ b/drivers/clk/ti/clk-814x.c
> @@ -0,0 +1,31 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk/ti.h>
> +
> +static struct ti_dt_clk dm814_clks[] = {
> +	DT_CLK(NULL, "devosc_ck", "devosc_ck"),
> +	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
> +	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
> +	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
> +	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
> +	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
> +	DT_CLK(NULL, "timer_sys_ck", "devosc_ck"),
> +	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
> +	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
> +	{ .node_name = NULL },
> +};
> +
> +int __init dm814x_dt_clk_init(void)
> +{
> +	ti_dt_clocks_register(dm814_clks);
> +	omap2_clk_disable_autoidle_all();
> +	omap2_clk_enable_init_clocks(NULL, 0);
> +
> +	return 0;
> +}
> --- a/drivers/clk/ti/clk-816x.c
> +++ b/drivers/clk/ti/clk-816x.c
> @@ -42,7 +42,7 @@ static const char *enable_init_clks[] = {
>   	"ddr_pll_clk3",
>   };
>   
> -int __init ti81xx_dt_clk_init(void)
> +int __init dm816x_dt_clk_init(void)
>   {
>   	ti_dt_clocks_register(dm816x_clks);
>   	omap2_clk_disable_autoidle_all();
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -329,7 +329,8 @@ int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
>   int omap3430_dt_clk_init(void);
>   int omap3630_dt_clk_init(void);
>   int am35xx_dt_clk_init(void);
> -int ti81xx_dt_clk_init(void);
> +int dm814x_dt_clk_init(void);
> +int dm816x_dt_clk_init(void);
>   int omap4xxx_dt_clk_init(void);
>   int omap5xxx_dt_clk_init(void);
>   int dra7xx_dt_clk_init(void);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
