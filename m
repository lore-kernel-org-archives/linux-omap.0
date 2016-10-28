From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
Date: Thu, 27 Oct 2016 17:50:47 -0700
Message-ID: <20161028005047.GQ26139@codeaurora.org>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <1476805568-19264-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476805568-19264-12-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/18, Tero Kristo wrote:
> Clockdomains can now be used as clock providers in the system. This
> patch initializes the provider data during init, and parses the clocks
> while they are being registered. An xlate function for the provider
> is also given.
> 
> Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>

Please Cc dt reviewers on binding updates. I suppose a PRCM is
like an MFD that has clocks and resets under it? On other
platforms we've combined that all into one node and just had
#clock-cells and #reset-cells in that node. Is there any reason
we can't do that here?

> ---
>  .../devicetree/bindings/arm/omap/prcm.txt          |  13 ++
>  .../devicetree/bindings/clock/ti/clockdomain.txt   |  12 +-
>  arch/arm/mach-omap2/io.c                           |   2 +
>  drivers/clk/ti/clock.h                             |   1 +
>  drivers/clk/ti/clockdomain.c                       | 147 +++++++++++++++++++++
>  include/linux/clk/ti.h                             |   3 +
>  6 files changed, 177 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
> index 3eb6d7a..301f576 100644
> --- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
> @@ -47,6 +47,19 @@ cm: cm@48004000 {
>  	};
>  }
>  
> +cm2: cm2@8000 {
> +	compatible = "ti,omap4-cm2";
> +	reg = <0x8000 0x3000>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0 0x8000 0x3000>;
> +
> +	l4_per_clkdm: l4_per_clkdm {
> +		compatible = "ti,clockdomain";
> +		reg = <0x1400 0x200>;

Should there be #clock-cells = <1> here? Also node name should
have an @1400 after it?

> +	};
> +};
> +
>  &cm_clocks {
>  	omap2_32k_fck: omap_32k_fck {
>  		#clock-cells = <0>;
> diff --git a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> index cb76b3f..5d8ca61 100644
> --- a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> @@ -14,11 +14,21 @@ hardware hierarchy.
>  
>  Required properties:
>  - compatible : shall be "ti,clockdomain"
> -- #clock-cells : from common clock binding; shall be set to 0.
> +- #clock-cells : from common clock binding; shall be set to 1 if this
> +		 clockdomain acts as a clock provider.
> +
> +Optional properties:
>  - clocks : link phandles of clocks within this domain
> +- reg : address for the clockdomain
>  
>  Examples:
>  	dss_clkdm: dss_clkdm {
>  		compatible = "ti,clockdomain";
>  		clocks = <&dss1_alwon_fck_3430es2>, <&dss_ick_3430es2>;
>  	};
> +
> +	l4_per_clkdm: l4_per_clkdm {

add an @1400?

> +		compatible = "ti,clockdomain";
> +		#clock-cells = <1>;
> +		reg = <0x1400 0x200>;
> +	};
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 0e9acdd..c1a5cfb 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -794,6 +794,8 @@ int __init omap_clk_init(void)
>  		if (ret)
>  			return ret;
>  
> +		ti_dt_clockdomains_early_setup();
> +
>  		of_clk_init(NULL);
>  
>  		ti_dt_clk_init_retry_clks();
> diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
> index 9b8a5f2..f6383ab 100644
> --- a/drivers/clk/ti/clock.h
> +++ b/drivers/clk/ti/clock.h
> @@ -205,6 +205,7 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
>  
>  int ti_clk_get_memmap_index(struct device_node *node);
>  void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
> +void __iomem *ti_clk_get_reg_addr_clkdm(const char *clkdm_name, u16 offset);
>  void ti_dt_clocks_register(struct ti_dt_clk *oclks);
>  int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
>  		      ti_of_clk_init_cb_t func);
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
> index 704157d..7b0a6c3 100644
> --- a/drivers/clk/ti/clockdomain.c
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -28,6 +28,23 @@
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
>  /**
> + * struct ti_clkdm - TI clockdomain data structure
> + * @name: name of the clockdomain
> + * @index: index of the clk_iomap struct for this clkdm
> + * @offset: clockdomain offset from the beginning of the iomap
> + * @link: link to the list
> + */
> +struct ti_clkdm {
> +	const char *name;
> +	int index;
> +	u32 offset;
> +	struct list_head link;
> +	struct list_head clocks;
> +};
> +
> +static LIST_HEAD(clkdms);
> +
> +/**
>   * omap2_clkops_enable_clkdm - increment usecount on clkdm of @hw
>   * @hw: struct clk_hw * of the clock being enabled
>   *
> @@ -116,6 +133,8 @@ void omap2_init_clk_clkdm(struct clk_hw *hw)
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	struct clockdomain *clkdm;
>  	const char *clk_name;
> +	struct ti_clkdm *ti_clkdm;
> +	bool match = false;
>  
>  	if (!clk->clkdm_name)
>  		return;
> @@ -130,7 +149,21 @@ void omap2_init_clk_clkdm(struct clk_hw *hw)
>  	} else {
>  		pr_debug("clock: could not associate clk %s to clkdm %s\n",
>  			 clk_name, clk->clkdm_name);
> +		return;
>  	}
> +
> +	list_for_each_entry(ti_clkdm, &clkdms, link) {
> +		if (!strcmp(ti_clkdm->name, clk->clkdm_name)) {
> +			match = true;
> +			break;

Or just goto found and then drop the match bool thing.

> +		}
> +	}
> +
> +	if (!match)
> +		return;
> +
> +	/* Add clock to the list of provided clocks */
> +	list_add(&clk->clkdm_link, &ti_clkdm->clocks);
>  }
>  
>  static void __init of_ti_clockdomain_setup(struct device_node *node)
> @@ -161,11 +194,125 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
>  	}
>  }
>  
> +static struct clk_hw *clkdm_clk_xlate(struct of_phandle_args *clkspec,
> +				      void *data)
> +{
> +	struct ti_clkdm *clkdm = data;
> +	struct clk_hw_omap *clk;
> +	u16 offset = clkspec->args[0];
> +
> +	list_for_each_entry(clk, &clkdm->clocks, clkdm_link)
> +		if (((u32)clk->enable_reg & 0xffff) - clkdm->offset == offset)

This looks scary.

> +			return &clk->hw;
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static int ti_clk_register_clkdm(struct device_node *node)
> +{
> +	u64 clkdm_addr;
> +	u64 inst_addr;
> +	const __be32 *reg;
> +	u32 offset;
> +	int idx;
> +	struct ti_clkdm *clkdm;
> +	int ret;
> +
> +	reg = of_get_address(node, 0, NULL, NULL);
> +	if (!reg)
> +		return -ENOENT;
> +
> +	clkdm_addr = of_translate_address(node, reg);
> +
> +	reg = of_get_address(node->parent, 0, NULL, NULL);
> +	if (!reg)
> +		return -EINVAL;
> +
> +	inst_addr = of_translate_address(node->parent, reg);
> +
> +	offset = clkdm_addr - inst_addr;
> +

I guess the usual offset tricks are still going on in the TI clk
driver? Is there a plan to stop doing that at some point?

> +	idx = ti_clk_get_memmap_index(node->parent);
> +
> +	if (idx < 0) {
> +		pr_err("bad memmap index for %s\n", node->name);
> +		return idx;
> +	}
> +
> +	clkdm = kzalloc(sizeof(*clkdm), GFP_KERNEL);
> +	if (!clkdm)
> +		return -ENOMEM;
> +
> +	clkdm->name = node->name;
> +	clkdm->index = idx;
> +	clkdm->offset = offset;
> +
> +	INIT_LIST_HEAD(&clkdm->clocks);
> +
> +	list_add(&clkdm->link, &clkdms);
> +
> +	ret = of_clk_add_hw_provider(node, clkdm_clk_xlate, clkdm);
> +	if (ret) {
> +		list_del(&clkdm->link);
> +		kfree(clkdm);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ti_clk_get_reg_addr_clkdm - get register address relative to clockdomain
> + * @clkdm_name: parent clockdomain
> + * @offset: offset from the clockdomain
> + *
> + * Gets a register address relative to parent clockdomain. Searches the
> + * list of available clockdomain, and if match is found, calculates the
> + * register address from the iomap relative to the clockdomain.
> + * Returns the register address, or NULL if not found.
> + */
> +void __iomem *ti_clk_get_reg_addr_clkdm(const char *clkdm_name, u16 offset)
> +{
> +	u32 reg;
> +	struct clk_omap_reg *reg_setup;
> +	struct ti_clkdm *clkdm;
> +	bool match = false;
> +
> +	reg_setup = (struct clk_omap_reg *)&reg;
> +
> +	/* XXX: get offset from clkdm, get base for instance */
> +	list_for_each_entry(clkdm, &clkdms, link) {
> +		if (!strcmp(clkdm->name, clkdm_name)) {
> +			match = true;
> +			break;
> +		}
> +	}
> +
> +	if (!match) {
> +		pr_err("%s: no entry for %s\n", __func__, clkdm_name);
> +		return NULL;
> +	}
> +
> +	reg_setup->offset = clkdm->offset + offset;
> +	reg_setup->index = clkdm->index;
> +
> +	return (void __iomem *)reg;
> +}
> +
>  static const struct of_device_id ti_clkdm_match_table[] __initconst = {
>  	{ .compatible = "ti,clockdomain" },
>  	{ }
>  };
>  
> +void __init ti_dt_clockdomains_early_setup(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_matching_node(np, ti_clkdm_match_table) {
> +		ti_clk_register_clkdm(np);
> +	}

Nitpick: drop braces please.

> +}
> +
>  /**
>   * ti_dt_clockdomains_setup - setup device tree clockdomains
>   *
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index 626ae94..afccb48 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -125,6 +125,7 @@ struct clk_hw_omap_ops {
>  /**
>   * struct clk_hw_omap - OMAP struct clk
>   * @node: list_head connecting this clock into the full clock list
> + * @clkdm_link: list_head connecting this clock into the clockdomain
>   * @enable_reg: register to write to enable the clock (see @enable_bit)
>   * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
>   * @flags: see "struct clk.flags possibilities" above
> @@ -137,6 +138,7 @@ struct clk_hw_omap_ops {
>  struct clk_hw_omap {
>  	struct clk_hw		hw;
>  	struct list_head	node;
> +	struct list_head	clkdm_link;
>  	unsigned long		fixed_rate;
>  	u8			fixed_div;
>  	void __iomem		*enable_reg;
> @@ -251,6 +253,7 @@ int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
>  unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
>  
>  void ti_dt_clk_init_retry_clks(void);
> +void ti_dt_clockdomains_early_setup(void);
>  void ti_dt_clockdomains_setup(void);
>  int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops);
>  
> -- 
> 1.9.1
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
