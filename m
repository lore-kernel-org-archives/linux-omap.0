From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 18/49] CLK: TI: add support for clockdomain binding
Date: Fri, 20 Dec 2013 11:46:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312201134410.20802@utopia.booyaka.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-19-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52569 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab3LTLqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 06:46:37 -0500
In-Reply-To: <1387452260-23276-19-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Thu, 19 Dec 2013, Tero Kristo wrote:

> Some OMAP clocks require knowledge about their parent clockdomain for
> book keeping purposes. This patch creates a new DT binding for TI
> clockdomains, which act as a collection of device clocks.

At least on OMAP4 and 5, clockdomains can be either collections of clocks 
or collections of IP blocks.  In other words, "clockdomain" was a horrible 
name: it's really an "idle-domain" or something similar to that.
Benoit might recall the details.  So you might want to add comments to 
that effect so folks don't get the wrong idea that they are specific to 
clocks on all OMAPs.

The clockdomain handling isn't ideal - I guess it should probably be part 
of the low-level PRM/CM IP block drivers that are currently in 
arch/arm/mach-omap2/* - but I think we can move it there later, unless you 
see a problem with that.

Also I guess there's no need for clockdomain compatible strings any more, 
since those can just be registered by iterating through the "clockdomains 
{" node children.  But I guess we can move that later too.

- Paul

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/clock/ti/clockdomain.txt   |   24 +++++++
>  drivers/clk/ti/Makefile                            |    3 +-
>  drivers/clk/ti/clockdomain.c                       |   70 ++++++++++++++++++++
>  include/linux/clk/ti.h                             |    1 +
>  4 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>  create mode 100644 drivers/clk/ti/clockdomain.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> new file mode 100644
> index 0000000..cb76b3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> @@ -0,0 +1,24 @@
> +Binding for Texas Instruments clockdomain.
> +
> +Binding status: Unstable - ABI compatibility may be broken in the future
> +
> +This binding uses the common clock binding[1] in consumer role.
> +Every clock on TI SoC belongs to one clockdomain, but software
> +only needs this information for specific clocks which require
> +their parent clockdomain to be controlled when the clock is
> +enabled/disabled. This binding doesn't define a new clock
> +binding type, it is used to group existing clock nodes under
> +hardware hierarchy.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be "ti,clockdomain"
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- clocks : link phandles of clocks within this domain
> +
> +Examples:
> +	dss_clkdm: dss_clkdm {
> +		compatible = "ti,clockdomain";
> +		clocks = <&dss1_alwon_fck_3430es2>, <&dss_ick_3430es2>;
> +	};
> diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
> index 7cba389..67056fb 100644
> --- a/drivers/clk/ti/Makefile
> +++ b/drivers/clk/ti/Makefile
> @@ -1,4 +1,5 @@
>  ifneq ($(CONFIG_OF),)
>  obj-y					+= clk.o dpll.o autoidle.o divider.o \
> -					   fixed-factor.o gate.o composite.o
> +					   fixed-factor.o gate.o clockdomain.o \
> +					   composite.o
>  endif
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
> new file mode 100644
> index 0000000..f1e0038
> --- /dev/null
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -0,0 +1,70 @@
> +/*
> + * OMAP clockdomain support
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
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/clk/ti.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +static void __init of_ti_clockdomain_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	struct clk_hw *clk_hw;
> +	const char *clkdm_name = node->name;
> +	int i;
> +	int num_clks;
> +
> +	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
> +
> +	for (i = 0; i < num_clks; i++) {
> +		clk = of_clk_get(node, i);
> +		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
> +			pr_warn("can't setup clkdm for basic clk %s\n",
> +				__clk_get_name(clk));
> +			continue;
> +		}
> +		clk_hw = __clk_get_hw(clk);
> +		to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
> +		omap2_init_clk_clkdm(clk_hw);
> +	}
> +}
> +
> +static struct of_device_id ti_clkdm_match_table[] __initdata = {
> +	{ .compatible = "ti,clockdomain" },
> +	{ }
> +};
> +
> +/**
> + * ti_dt_clockdomains_setup - setup device tree clockdomains
> + *
> + * Initializes clockdomain nodes for a SoC. This parses through all the
> + * nodes with compatible = "ti,clockdomain", and add the clockdomain
> + * info for all the clocks listed under these. This function shall be
> + * called after rest of the DT clock init has completed and all
> + * clock nodes have been registered.
> + */
> +void __init ti_dt_clockdomains_setup(void)
> +{
> +	struct device_node *np;
> +	for_each_matching_node(np, ti_clkdm_match_table) {
> +		of_ti_clockdomain_setup(np);
> +	}
> +}
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index a52495d..e8c1b22 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -238,6 +238,7 @@ int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
>  void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
>  void ti_dt_clocks_register(struct ti_dt_clk *oclks);
>  void ti_dt_clk_init_provider(struct device_node *np, int index);
> +void ti_dt_clockdomains_setup(void);
>  void ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
>  		       ti_of_clk_init_cb_t func);
>  int of_ti_clk_autoidle_setup(struct device_node *node);
> -- 
> 1.7.9.5
> 


- Paul
