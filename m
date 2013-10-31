From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 08/43] clk: ti: add composite clock support
Date: Thu, 31 Oct 2013 11:27:08 -0500
Message-ID: <527284DC.2070701@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab3JaQ1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Oct 2013 12:27:34 -0400
In-Reply-To: <1382716658-6964-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/25/2013 10:57 AM, Tero Kristo wrote:
> This is a multipurpose clock node, which contains support for multiple
> sub-clocks. Uses basic composite clock type to implement the actual
> functionality, and TI specific gate, mux and divider clocks.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/clock/ti/composite.txt     |   54 +++++
>  drivers/clk/ti/Makefile                            |    2 +-
>  drivers/clk/ti/composite.c                         |  222 ++++++++++++++++++++
>  include/linux/clk/ti.h                             |    8 +
>  4 files changed, 285 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/composite.txt
>  create mode 100644 drivers/clk/ti/composite.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/composite.txt b/Documentation/devicetree/bindings/clock/ti/composite.txt
> new file mode 100644
> index 0000000..5f43c47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/composite.txt
> @@ -0,0 +1,54 @@
> +Binding for TI composite clock.
> +
> +Binding status: Unstable - ABI compatibility may be broken in the future
> +
> +This binding uses the common clock binding[1]. It assumes a
> +register-mapped composite clock with multiple different sub-types;
> +
> +a multiplexer clock with multiple input clock signals or parents, one
> +of which can be selected as output, this behaves exactly as [2]
> +
> +an adjustable clock rate divider, this behaves exactly as [3]
> +
> +a gating function which can be used to enable and disable the output
> +clock, this behaves exactly as [4]
> +
> +The binding must provide a list of the component clocks that shall be
> +merged to this clock. The component clocks shall be of one of the
> +"ti,*composite*-clock" types.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/clock/ti/mux.txt
> +[3] Documentation/devicetree/bindings/clock/ti/divider.txt
> +[4] Documentation/devicetree/bindings/clock/ti/gate.txt
> +
> +Required properties:
> +- compatible : shall be: "ti,composite-clock"
> +- clocks : link phandles of component clocks
> +- #clock-cells : from common clock binding; shall be set to 0.
> +
> +Examples:
> +
> +usb_l4_gate_ick: usb_l4_gate_ick {
> +	#clock-cells = <0>;
> +	compatible = "ti,composite-interface-clock";
> +	clocks = <&l4_ick>;
> +	ti,bit-shift = <5>;
> +	reg = <0x0a10>;
> +};
> +
> +usb_l4_div_ick: usb_l4_div_ick {
> +	#clock-cells = <0>;
> +	compatible = "ti,composite-divider-clock";
> +	clocks = <&l4_ick>;
> +	ti,bit-shift = <4>;
> +	ti,max-div = <1>;
> +	reg = <0x0a40>;
> +	ti,index-starts-at-one;
> +};
> +
> +usb_l4_ick: usb_l4_ick {
> +	#clock-cells = <0>;
> +	compatible = "ti,composite-clock";
> +	clocks = <&usb_l4_gate_ick>, <&usb_l4_div_ick>;
> +};
> diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
> index 533efb4..a4a7595 100644
> --- a/drivers/clk/ti/Makefile
> +++ b/drivers/clk/ti/Makefile
> @@ -1,3 +1,3 @@
>  ifneq ($(CONFIG_OF),)
> -obj-y					+= clk.o dpll.o autoidle.o
> +obj-y					+= clk.o dpll.o autoidle.o composite.o
>  endif
> diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
> new file mode 100644
> index 0000000..9ce7e54
> --- /dev/null
> +++ b/drivers/clk/ti/composite.c
> @@ -0,0 +1,222 @@
> +/*
> + * TI composite clock support
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
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/clk/ti.h>
> +#include <linux/list.h>
> +
> +#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
> +
> +static unsigned long ti_composite_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	return clk_divider_ops.recalc_rate(hw, parent_rate);
> +}
> +
> +static long ti_composite_round_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long *prate)
> +{
> +	return -EINVAL;
> +}
> +
> +static int ti_composite_set_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{
> +	return -EINVAL;
> +}
> +
> +static const struct clk_ops ti_composite_divider_ops = {
> +	.recalc_rate	= &ti_composite_recalc_rate,
> +	.round_rate	= &ti_composite_round_rate,
> +	.set_rate	= &ti_composite_set_rate,
> +};
> +
> +static const struct clk_ops ti_composite_gate_ops = {
> +	.enable		= &omap2_dflt_clk_enable,
> +	.disable	= &omap2_dflt_clk_disable,
> +	.is_enabled	= &omap2_dflt_clk_is_enabled,
> +};
> +
> +struct component_clk {
> +	int num_parents;
> +	const char **parent_names;
> +	struct device_node *node;
> +	int type;
> +	struct clk_hw *hw;
> +	struct list_head link;
> +};
> +
> +static const char * __initdata component_clk_types[] = {
[CLK_COMPONENT_TYPE_MAX]?

> +	"mux", "gate", "divider",
> +};
> +
> +static LIST_HEAD(component_clks);
> +
> +static struct component_clk *_lookup_component(struct device_node *node, int i)
> +{
> +	int rc;
> +	struct of_phandle_args clkspec;
> +	struct component_clk *comp;
> +
> +	rc = of_parse_phandle_with_args(node, "clocks", "#clock-cells", i,
> +					&clkspec);
> +	if (rc)
> +		return NULL;
> +
> +	list_for_each_entry(comp, &component_clks, link) {
> +		if (comp->node == clkspec.np)
> +			return comp;
> +	}
> +	return NULL;
> +}
> +
> +static inline struct clk_hw *_get_hw(struct component_clk *clk)
> +{
> +	if (clk)
> +		return clk->hw;
> +
> +	return NULL;
> +}
> +
> +static int __init of_ti_composite_clk_setup(struct device_node *node,
> +					    struct regmap *regmap)
> +{
> +	int num_clks;
> +	int i;
> +	struct clk *clk;
> +	struct component_clk *comp;
> +	struct component_clk *clks[3] = { NULL };
sizeof(component_clk_types) or CLK_COMPONENT_TYPE_MAX instead of 3?
> +	const char *name = node->name;
> +	int num_parents = 0;
> +	const char **parent_names = NULL;
> +	int ret = 0;
> +
> +	/* Number of component clocks to be put inside this clock */
> +	num_clks = of_clk_get_parent_count(node);
> +
> +	if (num_clks < 1) {
> +		pr_err("%s: ti composite clk %s must have component(s)\n",
> +		       __func__, name);

using pr_fmt will reduce the pr_err code.

> +		return -EINVAL;
> +	}
> +
> +	/* Check for presence of each component clock */
> +	for (i = 0; i < num_clks; i++) {
> +		comp = _lookup_component(node, i);
> +		if (!comp)
> +			return -EAGAIN;
> +		if (clks[comp->type] != NULL) {
> +			pr_err("%s: duplicate component types for %s (%s)!\n",
> +			       __func__, name, component_clk_types[comp->type]);
> +			return -EINVAL;
would you not want to do a cleanup of the list here?

> +		}
> +		clks[comp->type] = comp;
> +	}
> +
> +	/* All components exists, proceed with registration */
> +	for (i = 0; i < 3; i++) {
CLK_COMPONENT_TYPE_MAX instead
> +		if (!clks[i])
> +			continue;
> +		if (clks[i]->num_parents) {
> +			num_parents = clks[i]->num_parents;
> +			parent_names = clks[i]->parent_names;
> +		}
> +	}
> +
> +	/* Enforce mux parents if exists */
> +	comp = clks[CLK_COMPONENT_TYPE_MUX];
> +	if (comp) {
> +		num_parents = comp->num_parents;
> +		parent_names = comp->parent_names;
> +	}
you could move the for loop in the else case and reduce the loops to
CLK_COMPONENT_TYPE_MUX+1 to CLK_COMPONENT_TYPE_MAX.

> +
> +	if (!num_parents) {
> +		pr_err("%s: no parents found for %s!\n", __func__,
> +		       name);
> +		return -EINVAL;

would you not want to do a cleanup of the list here?

> +	}
> +
> +	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> +				     _get_hw(clks[CLK_COMPONENT_TYPE_MUX]),
> +				     &clk_mux_ops,
> +				     _get_hw(clks[CLK_COMPONENT_TYPE_DIVIDER]),
> +				     &ti_composite_divider_ops,
> +				     _get_hw(clks[CLK_COMPONENT_TYPE_GATE]),
> +				     &ti_composite_gate_ops, 0);
> +
> +	if (!IS_ERR(clk)) {
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		goto cleanup;
> +	}
> +
> +	ret = PTR_ERR(clk);
> +cleanup:
> +	/* Free component clock list entries */
> +	for (i = 0; i < 3; i++) {
> +		if (!clks[i])
> +			continue;
> +		list_del(&clks[i]->link);
> +		kfree(clks[i]);
> +	}

could you not just do a kfree(clks[i]) and set the component_clks to NULL?

Further, if there are only 3 clocks that can ever be present and we do
not allow for duplicates types, could we not do those checks in
ti_clk_add_component instead of having a harder recovery in setup of
composite clk?

> +
> +	return ret;
> +}
> +CLK_OF_DECLARE(ti_composite_clock, "ti,composite-clock",
> +	       of_ti_composite_clk_setup);
> +
> +int __init ti_clk_add_component(struct device_node *node, struct clk_hw *hw,
> +				int type)
> +{
> +	int num_parents;
> +	const char **parent_names;
> +	struct component_clk *clk;
> +	int i;
> +
> +	num_parents = of_clk_get_parent_count(node);
> +
> +	if (num_parents < 1) {
> +		pr_err("%s: component-clock %s must have parent(s)\n", __func__,
> +		       node->name);
> +		return -EINVAL;
> +	}
> +
> +	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
> +	if (!parent_names)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_parents; i++)
> +		parent_names[i] = of_clk_get_parent_name(node, i);
> +
> +	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> +	if (!clk) {
> +		kfree(parent_names);
> +		return -ENOMEM;
> +	}
> +
> +	clk->num_parents = num_parents;
> +	clk->parent_names = parent_names;
> +	clk->hw = hw;
> +	clk->node = node;
> +	clk->type = type;
> +	list_add(&clk->link, &component_clks);
> +
> +	return 0;
> +}
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index e45005c..96c9725 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -137,6 +137,13 @@ struct clk_hw_omap {
>  /* DPLL Type and DCO Selection Flags */
>  #define DPLL_J_TYPE		0x1
>  
> +/* Composite clock component types */
> +enum {
> +	CLK_COMPONENT_TYPE_MUX = 0,
> +	CLK_COMPONENT_TYPE_GATE,
> +	CLK_COMPONENT_TYPE_DIVIDER
adding a CLK_COMPONENT_TYPE_MAX will allow a better implementation
> +};
> +
>  /**
>   * struct ti_dt_clk - OMAP DT clock alias declarations
>   * @lk: clock lookup definition
> @@ -179,6 +186,7 @@ int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
>  void ti_dt_clocks_register(struct ti_dt_clk *oclks);
>  void ti_dt_clk_init_provider(struct device_node *np, struct regmap *regmap);
>  int of_ti_autoidle_setup(struct device_node *node, struct regmap *regmap);
> +int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
>  
>  #ifdef CONFIG_OF
>  void of_ti_clk_allow_autoidle_all(void);
> 


-- 
Regards,
Nishanth Menon
