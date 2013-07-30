From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 06/33] CLK: omap: add autoidle support
Date: Tue, 30 Jul 2013 13:56:55 -0500
Message-ID: <51F80C77.9020109@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374564028-11352-7-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> OMAP clk driver now routes some of the basic clocks through own
> registration routine to allow autoidle support. This routine just
> checks a couple of device node properties and adds autoidle support
> if required, and just passes the registration forward to basic clocks.

why not extend standard framework to support autoidle capable clocks OR 
introduce our own clk node which depends on basic clocks?
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/clock.c |    6 ++
>   drivers/clk/omap/Makefile   |    2 +-
>   drivers/clk/omap/autoidle.c |  130 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/omap/clk.c      |    4 +-
>   include/linux/clk/omap.h    |    4 ++
>   5 files changed, 143 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/clk/omap/autoidle.c

I know it is getting a little stale, but anyways, device tree binding 
missing.

>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 0c38ca9..669d4c4 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
Not sure why, at this point in time we are going to calling drivers/clk 
code.

> @@ -520,6 +520,9 @@ int omap2_clk_enable_autoidle_all(void)
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
>   		if (c->ops && c->ops->allow_idle)
>   			c->ops->allow_idle(c);
> +
> +	of_omap_clk_allow_autoidle_all();
> +
>   	return 0;
>   }
>
> @@ -539,6 +542,9 @@ int omap2_clk_disable_autoidle_all(void)
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
>   		if (c->ops && c->ops->deny_idle)
>   			c->ops->deny_idle(c);
> +
> +	of_omap_clk_deny_autoidle_all();
> +

these are defined for CONFIG_OF.. anyways, without dt nodes (OMAP3 is 
supposed to support non-DT boot even now), this would not work, would it?


>   	return 0;
>   }
>
> diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
> index 4cad480..ca56700 100644
> --- a/drivers/clk/omap/Makefile
> +++ b/drivers/clk/omap/Makefile
> @@ -1 +1 @@
> -obj-y					+= clk.o dpll.o
> +obj-y					+= clk.o dpll.o autoidle.o
> diff --git a/drivers/clk/omap/autoidle.c b/drivers/clk/omap/autoidle.c
> new file mode 100644
> index 0000000..6424cb2
> --- /dev/null
> +++ b/drivers/clk/omap/autoidle.c
> @@ -0,0 +1,130 @@
> +/*
> + * OMAP clock autoidle support
> + *
> + * Copyright (C) 2013 Texas Instruments, Inc.
> + *
> + * Tero Kristo <t-kristo@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include <linux/log2.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
at all of these required?

> +
> +#ifdef CONFIG_OF
> +struct clk_omap_autoidle {
> +	void __iomem		*reg;
> +	u8			shift;
> +	u8			flags;
> +	const char		*name;
> +	struct list_head	node;
> +};
> +
> +#define AUTOIDLE_LOW		0x1
> +
> +static LIST_HEAD(autoidle_clks);
> +
> +static void omap_allow_autoidle(struct clk_omap_autoidle *clk)
> +{
> +	u32 val;
> +
> +	val = readl(clk->reg);
> +
> +	if (clk->flags & AUTOIDLE_LOW)
> +		val &= ~(1 << clk->shift);
> +	else
> +		val |= (1 << clk->shift);
> +
> +	writel(val, clk->reg);
> +}
> +
> +static void omap_deny_autoidle(struct clk_omap_autoidle *clk)
> +{
> +	u32 val;
> +
> +	val = readl(clk->reg);
> +
> +	if (clk->flags & AUTOIDLE_LOW)
> +		val |= (1 << clk->shift);
> +	else
> +		val &= ~(1 << clk->shift);
> +
> +	writel(val, clk->reg);
> +}
> +
> +void of_omap_clk_allow_autoidle_all(void)
> +{
> +	struct clk_omap_autoidle *c;
> +
> +	list_for_each_entry(c, &autoidle_clks, node)
> +		omap_allow_autoidle(c);
> +}
> +
> +void of_omap_clk_deny_autoidle_all(void)
> +{
> +	struct clk_omap_autoidle *c;
> +
> +	list_for_each_entry(c, &autoidle_clks, node)
> +		omap_deny_autoidle(c);
> +}
> +
> +static __init void of_omap_autoidle_setup(struct device_node *node)
> +{
> +	u32 shift;
> +	void __iomem *reg;
> +	struct clk_omap_autoidle *clk;
> +
> +	if (of_property_read_u32(node, "ti,autoidle-shift", &shift))
> +		return;
> +
> +	reg = of_iomap(node, 0);
> +
> +	clk = kzalloc(sizeof(struct clk_omap_autoidle), GFP_KERNEL);
> +
> +	if (!clk) {
> +		pr_err("%s: kzalloc failed\n", __func__);
> +		return;
> +	}
> +
> +	clk->shift = shift;
> +	clk->name = node->name;
> +	clk->reg = reg;
> +
> +	if (of_property_read_bool(node, "ti,autoidle-low"))
> +		clk->flags |= AUTOIDLE_LOW;
> +
> +	list_add(&clk->node, &autoidle_clks);
> +}
> +
> +void __init of_omap_divider_setup(struct device_node *node)
> +{
> +	of_divider_clk_setup(node);
> +	of_omap_autoidle_setup(node);
> +}
> +EXPORT_SYMBOL_GPL(of_omap_divider_setup);
> +CLK_OF_DECLARE(omap_autoidle_clock, "divider-clock", of_omap_divider_setup);

This is overriding drivers/clk/clk-divider.c ?
> +
> +void __init of_omap_fixed_factor_setup(struct device_node *node)
> +{
> +	of_fixed_factor_clk_setup(node);
> +	of_omap_autoidle_setup(node);
> +}
> +EXPORT_SYMBOL_GPL(of_omap_fixed_factor_setup);
> +CLK_OF_DECLARE(omap_fixed_factor_clock, "fixed-factor-clock",
> +	of_omap_fixed_factor_setup);

This is overriding drivers/clk/clk-fixed-factor.c ?
> +
> +#endif
> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
> index cd31a81..c149097 100644
> --- a/drivers/clk/omap/clk.c
> +++ b/drivers/clk/omap/clk.c
> @@ -25,8 +25,8 @@ static const struct of_device_id clk_match[] = {
>   	{.compatible = "fixed-clock", .data = of_fixed_clk_setup, },
>   	{.compatible = "mux-clock", .data = of_mux_clk_setup, },
>   	{.compatible = "fixed-factor-clock",
> -		.data = of_fixed_factor_clk_setup, },
> -	{.compatible = "divider-clock", .data = of_divider_clk_setup, },
> +		.data = of_omap_fixed_factor_setup, },
> +	{.compatible = "divider-clock", .data = of_omap_divider_setup, },
>   	{.compatible = "gate-clock", .data = of_gate_clk_setup, },
>   	{.compatible = "ti,omap4-dpll-clock", .data = of_omap4_dpll_setup, },
>   	{},
> diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
> index c39e775..904bdad 100644
> --- a/include/linux/clk/omap.h
> +++ b/include/linux/clk/omap.h
> @@ -192,5 +192,9 @@ extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
>   int dt_omap_clk_init(void);
>   extern void omap_dt_clocks_register(struct omap_dt_clk *oclks, int cnt);
>   void of_omap4_dpll_setup(struct device_node *node);
> +void of_omap_fixed_factor_setup(struct device_node *node);
> +void of_omap_divider_setup(struct device_node *node);
> +void of_omap_clk_allow_autoidle_all(void);
> +void of_omap_clk_deny_autoidle_all(void);
>
>   #endif
>

I personally dont prefer the fact that divider-clock and 
fixed-rate-clock now has double meaning - building a multi-arch kernel 
for example, this can wreak havoc. standard definitions should not be 
monkeyed around with thus if avoidable, and in this case, very much 
avoidable.

just my 2 cents.
-- 
Regards,
Nishanth Menon
