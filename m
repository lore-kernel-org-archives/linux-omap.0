From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clk: ti: change clock init to use generic of_clk_init
Date: Thu, 18 Sep 2014 10:17:26 -0700
Message-ID: <20140918171725.GL14505@atomide.com>
References: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12903 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbaIRRRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 13:17:43 -0400
Content-Disposition: inline
In-Reply-To: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Mark Rutland <mark.rutland@arm.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Stefan Assmann <sassmann@kpanic.de>

* Tero Kristo <t-kristo@ti.com> [140821 06:52]:
> Previously, the TI clock driver initialized all the clocks hierarchically
> under each separate clock provider node. Now, each clock that requires
> IO access will instead check their parent node to find out which IO range
> to use.
> 
> This patch allows the TI clock driver to use a few new features provided
> by the generic of_clk_init, and also allows registration of clock nodes
> outside the clock hierarchy (for example, any external clocks.)

Paul, any comments on this one?

Regards,

Tony
 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Stefan Assmann <sassmann@kpanic.de>
> ---
>  arch/arm/mach-omap2/io.c         |   10 ++++++++--
>  arch/arm/mach-omap2/prm_common.c |    2 --
>  drivers/clk/ti/clk.c             |   31 ++++++++++++++++---------------
>  3 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 5d0667c..3325df6 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -734,8 +734,14 @@ int __init omap_clk_init(void)
>  	ti_clk_init_features();
>  
>  	ret = of_prcm_init();
> -	if (!ret)
> -		ret = omap_clk_soc_init();
> +	if (ret)
> +		return ret;
> +
> +	of_clk_init(NULL);
> +
> +	ti_dt_clockdomains_setup();
> +
> +	ret = omap_clk_soc_init();
>  
>  	return ret;
>  }
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index 76ca320..3b89080 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -525,8 +525,6 @@ int __init of_prcm_init(void)
>  		memmap_index++;
>  	}
>  
> -	ti_dt_clockdomains_setup();
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
> index b1a6f71..f7201d0 100644
> --- a/drivers/clk/ti/clk.c
> +++ b/drivers/clk/ti/clk.c
> @@ -25,8 +25,8 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
> -static int ti_dt_clk_memmap_index;
>  struct ti_clk_ll_ops *ti_clk_ll_ops;
> +static struct device_node *clocks_node_ptr[CLK_MAX_MEMMAPS];
>  
>  /**
>   * ti_dt_clocks_register - register DT alias clocks during boot
> @@ -108,9 +108,21 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
>  	struct clk_omap_reg *reg;
>  	u32 val;
>  	u32 tmp;
> +	int i;
>  
>  	reg = (struct clk_omap_reg *)&tmp;
> -	reg->index = ti_dt_clk_memmap_index;
> +
> +	for (i = 0; i < CLK_MAX_MEMMAPS; i++) {
> +		if (clocks_node_ptr[i] == node->parent)
> +			break;
> +	}
> +
> +	if (i == CLK_MAX_MEMMAPS) {
> +		pr_err("clk-provider not found for %s!\n", node->name);
> +		return NULL;
> +	}
> +
> +	reg->index = i;
>  
>  	if (of_property_read_u32_index(node, "reg", index, &val)) {
>  		pr_err("%s must have reg[%d]!\n", node->name, index);
> @@ -133,15 +145,10 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
>   */
>  void ti_dt_clk_init_provider(struct device_node *parent, int index)
>  {
> -	const struct of_device_id *match;
> -	struct device_node *np;
>  	struct device_node *clocks;
> -	of_clk_init_cb_t clk_init_cb;
>  	struct clk_init_item *retry;
>  	struct clk_init_item *tmp;
>  
> -	ti_dt_clk_memmap_index = index;
> -
>  	/* get clocks for this parent */
>  	clocks = of_get_child_by_name(parent, "clocks");
>  	if (!clocks) {
> @@ -149,14 +156,8 @@ void ti_dt_clk_init_provider(struct device_node *parent, int index)
>  		return;
>  	}
>  
> -	for_each_child_of_node(clocks, np) {
> -		match = of_match_node(&__clk_of_table, np);
> -		if (!match)
> -			continue;
> -		clk_init_cb = (of_clk_init_cb_t)match->data;
> -		pr_debug("%s: initializing: %s\n", __func__, np->name);
> -		clk_init_cb(np);
> -	}
> +	/* add clocks node info */
> +	clocks_node_ptr[index] = clocks;
>  
>  	list_for_each_entry_safe(retry, tmp, &retry_list, link) {
>  		pr_debug("retry-init: %s\n", retry->node->name);
> -- 
> 1.7.9.5
> 
