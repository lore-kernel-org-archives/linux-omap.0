From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 04/43] CLK: TI: Add DPLL clock support
Date: Thu, 31 Oct 2013 09:19:48 -0500
Message-ID: <52726704.5070300@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47480 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab3JaOUR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Oct 2013 10:20:17 -0400
In-Reply-To: <1382716658-6964-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/25/2013 10:56 AM, Tero Kristo wrote:
[...]

> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> new file mode 100644
> index 0000000..7b87721
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> @@ -0,0 +1,81 @@
> +Binding for Texas Instruments DPLL clock.
> +
> +Binding status: Unstable - ABI compatibility may be broken in the future
> +
> +This binding uses the common clock binding[1].  It assumes a
> +register-mapped DPLL with usually two selectable input clocks
> +(reference clock and bypass clock), with digital phase locked
> +loop logic for multiplying the input clock to a desired output
> +clock. This clock also typically supports different operation
> +modes (locked, low power stop etc.) This binding has several
> +sub-types, which effectively result in slightly different setup
> +for the actual DPLL clock.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be one of:
> +		"ti,omap3-dpll-clock",
> +		"ti,omap3-dpll-core-clock",
> +		"ti,omap3-dpll-per-clock",
> +		"ti,omap3-dpll-per-j-type-clock",
> +		"ti,omap4-dpll-clock",
> +		"ti,omap4-dpll-x2-clock",
> +		"ti,omap4-dpll-core-clock",
> +		"ti,omap4-dpll-m4xen-clock",
> +		"ti,omap4-dpll-j-type-clock",
> +		"ti,am3-dpll-no-gate-clock",
> +		"ti,am3-dpll-j-type-clock",
> +		"ti,am3-dpll-no-gate-j-type-clock",
> +		"ti,am3-dpll-clock",
> +		"ti,am3-dpll-core-clock",
> +		"ti,am3-dpll-x2-clock",
> +
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- clocks : link phandles of parent clocks, first entry lists reference clock
> +  and second entry bypass clock
> +- reg : offsets for the register set for controlling the DPLL.
> +  Registers are listed in following order:
> +	"control" - contains the control register base address
> +	"idlest" - contains the idle status register base address
> +	"autoidle" - contains the autoidle register base address
> +	"mult-div1" - contains the multiplier / divider register base address
If we move mult-div1 above autoidle, indices for control, idlest,
mult-div1 will be constant with DPLLs that dont have autoidle. a
little easier to debug.

> +  ti,am3-* dpll types list the registers in the same order, except "autoidle"
> +  register is left out as this hardware does not have it, e.g.:
> +	reg = <0x40>, <0x50>, <0x60>;
> +  results in following register map:
> +	base + 0x40 - control
> +	base + 0x50 - idlest
> +	base + 0x60 - mult-div1
> +
> +Optional properties:
> +- DPLL mode setting - defining any one or more of the following overrides
> +  default setting.
> +	- ti,low-power-stop : DPLL supports low power stop mode, gating output
> +	- ti,low-power-bypass : DPLL output matches rate of parent bypass clock
> +	- ti,lock : DPLL locks in programmed rate

> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = ((1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
> arch/arm/mach-omap2/dpll3xxx.c: _omap3_dpll_write_clken(clk, DPLL_LOCKED);

There is no if checks for DPLL_LOCKED which is set with ti,lock,
should we just drop it?

[...]
> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> new file mode 100644
> index 0000000..89733c9
> --- /dev/null
> +++ b/drivers/clk/ti/dpll.c

[...]

> +/**
> + * ti_clk_register_dpll() - Registers the DPLL clock
> + * @name:	Name of the clock node
> + * @parent_names: list of parent names
> + * @num_parents: num of parents in parent_names
> + * @flags:	init flags
> + * @dpll_data:	DPLL data
> + * @ops:	ops for DPLL
> + */
> +static struct clk *ti_clk_register_dpll(const char *name,
> +					const char **parent_names,
> +					int num_parents, unsigned long flags,
> +					struct dpll_data *dpll_data,
> +					const struct clk_ops *ops,
> +					struct regmap *regmap)
> +{
> +	struct clk *clk;
> +	struct clk_init_data init = { NULL };
> +	struct clk_hw_omap *clk_hw;
> +
> +	/* allocate the divider */
> +	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
> +	if (!clk_hw) {
> +		pr_err("%s: could not allocate clk_hw_omap\n", __func__);

here and in every other driver - please dont add pr_err for kzalloc
not able to allocate, kzalloc will provide the warning anyways.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	clk_hw->dpll_data = dpll_data;
> +	clk_hw->ops = &clkhwops_omap3_dpll;
> +	clk_hw->hw.init = &init;
> +	clk_hw->regmap = regmap;
> +
> +	init.name = name;
> +	init.ops = ops;
> +	init.flags = flags;
> +	init.parent_names = parent_names;
> +	init.num_parents = num_parents;
> +
> +	/* register the clock */
> +	clk = clk_register(NULL, &clk_hw->hw);
> +
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed clk_register for %s (%ld)\n", __func__, name,
> +		       PTR_ERR(clk));
> +		kfree(clk_hw);
> +	} else {
> +		omap2_init_clk_hw_omap_clocks(clk);
> +	}
> +
> +	return clk;
> +}
> +
> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
> +	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX)
> +/**
> + * ti_clk_register_dpll_x2() -  Registers the DPLLx2 clock
> + * @dev:	device pointer (if any)
> + * @name:	Name of the clock node
> + * @parent_name: parent name (only 1 parent)
> + * @reg:	register address for DPLL
> + * @ops:	ops for DPLL
> + */
> +static struct clk *ti_clk_register_dpll_x2(struct device_node *node,
> +					   const struct clk_ops *ops,
> +					   const struct clk_hw_omap_ops *hw_ops,
> +					   struct regmap *regmap)
> +{
> +	struct clk *clk;
> +	struct clk_init_data init = { NULL };
> +	struct clk_hw_omap *clk_hw;
> +	const char *name = node->name;
> +	const char *parent_name;
> +
> +	of_property_read_string(node, "clock-output-names", &name);
> +
> +	parent_name = of_clk_get_parent_name(node, 0);
> +	if (!parent_name) {
> +		pr_err("%s: dpll_x2 must have parent\n", __func__);

print node->name as well?

> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
> +	if (!clk_hw) {
> +		pr_err("%s: could not allocate clk_hw_omap\n", __func__);

^^ here again.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	clk_hw->ops = hw_ops;
> +	of_property_read_u32(node, "reg", (u32 *)&clk_hw->clksel_reg);
> +	clk_hw->regmap = regmap;
> +	clk_hw->hw.init = &init;
> +
> +	init.name = name;
> +	init.ops = ops;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +
> +	/* register the clock */
> +	clk = clk_register(NULL, &clk_hw->hw);
> +
> +	if (IS_ERR(clk))
> +		kfree(clk_hw);
> +	else
> +		omap2_init_clk_hw_omap_clocks(clk);
> +
> +	return clk;
> +}
> +#endif
[...]
> +
> +#ifdef CONFIG_ARCH_OMAP3

just a mention - I understand we are still in transition and we need
these #ifdefs, but eventually, we should be able to make the dpll.c
independent of SoC variant #ifdefs.
[...]


-- 
Regards,
Nishanth Menon
