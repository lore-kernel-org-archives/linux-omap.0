From: Eduardo Valentin <eduardo.valentin@indt.org.br>
Subject: Re: [PATCH 1/2] CLK: Introduce virtual clock registration
Date: Wed, 20 Aug 2008 15:10:08 -0400
Message-ID: <20080820191008.GB10240@knuth>
References: <1219233879-28701-1-git-send-email-Hiroshi.DOYU@nokia.com>
Reply-To: eduardo.valentin@indt.org.br
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60598 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbYHTTJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 15:09:56 -0400
Content-Disposition: inline
In-Reply-To: <1219233879-28701-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, eduardo.valentin@indt.org.br, felipe.balbi@nokia.com, tony@atomide.com, daniel.stone@nokia.com

Hi Hiroshi,

On Wed, Aug 20, 2008 at 03:04:38PM +0300, Hiroshi DOYU wrote:
> This patch provides the interface to register and unregister a virtual
> clock which groups multiple clocks in it in order to handle this group
> of clocks at once. Presently just clk_enable and clk_disable is
> overwritten and other operation can be done as well.
> 
> This is just a refactor of MCBSP clock registration.

These two patches seams ok to me. I didn't expose it as
a virtual clock API 'cause I didn't find any other place
to use it other than mcbsp code.

Anyway, the code looks more manageble now. I'd just suggest
a refactor of mach-omap1 files to be included into this series as well.

> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Acked-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---
>  arch/arm/plat-omap/clock.c              |   80 +++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/clock.h |   19 +++++++
>  2 files changed, 99 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 23a0705..c35b968 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -374,6 +374,86 @@ EXPORT_SYMBOL(clk_init_cpufreq_table);
>  #endif
>  
>  /*-------------------------------------------------------------------------*/
> +/*
> + *	Virtual clock/Clock aggregation
> + */
> +static int vclk_enable(struct clk *clk)
> +{
> +	int i, err;
> +	struct vclk *vc = container_of(clk, struct vclk, clk);
> +
> +	for (i = 0; i < vc->n_child; i++) {
> +		err = clk_enable(vc->child[i]);
> +		if (err)
> +			goto err_out;
> +	}
> +	return 0;
> +err_out:
> +	while (--i >= 0)
> +		clk_disable(vc->child[i]);
> +	return err;
> +}
> +
> +static void vclk_disable(struct clk *clk)
> +{
> +	int i;
> +	struct vclk *vc = container_of(clk, struct vclk, clk);
> +
> +	for (i = 0; i < vc->n_child; i++)
> +		clk_disable(vc->child[i]);
> +}
> +
> +int vclk_register(struct vclk *vc, struct vclk_cci *cci, int num_child)
> +{
> +	int i, err;
> +
> +	vc->n_child = num_child;
> +	vc->child = kzalloc(num_child * sizeof(struct clk *), GFP_KERNEL);
> +	if (!vc->child)
> +		return -ENOMEM;
> +
> +	vc->clk.enable = vclk_enable;
> +	vc->clk.disable = vclk_disable;
> +
> +	for (i = 0; i < num_child; i++, cci++) {
> +		struct clk *c;
> +		/* fake a platform device to get correct device ID */
> +		struct platform_device pdev;
> +
> +		c = vc->child[i];
> +		pdev.dev.bus = &platform_bus_type;
> +		pdev.id = cci->id;
> +		c = clk_get(&pdev.dev, cci->name);
> +		if (IS_ERR(c)) {
> +			pr_err("Could not get clock %s (%d).\n",
> +			       cci->name, cci->id);
> +			err = PTR_ERR(c);
> +			goto err_out;
> +		}
> +		vc->child[i] = c;
> +	}
> +	err = clk_register(&vc->clk);
> +	if (err)
> +		goto err_out;
> +	return 0;
> +err_out:
> +	while (--i >= 0)
> +		clk_put(vc->child[i]);
> +	kfree(vc->child);
> +	return err;
> +}
> +EXPORT_SYMBOL(vclk_register);
> +
> +void vclk_unregister(struct vclk *vc)
> +{
> +	int i = vc->n_child;
> +
> +	clk_unregister(&vc->clk);
> +	while (--i >= 0)
> +		clk_put(vc->child[i]);
> +	kfree(vc->child);
> +}
> +EXPORT_SYMBOL(vclk_unregister);
>  
>  #ifdef CONFIG_OMAP_RESET_CLOCKS
>  /*
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
> index c6762e9..5483027 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -94,6 +94,25 @@ struct clk {
>  #endif
>  };
>  
> +/*
> + * Virtual Clock which holds multiple clocks in it and does some
> + * operations (enable/disable) against these child clocks at once
> + */
> +struct vclk {
> +	struct clk clk;
> +	struct clk **child;
> +	int n_child;
> +};
> +
> +/* Child Clock Info for virtual clock registration */
> +struct vclk_cci {
> +	const char *name;
> +	int id;
> +};
> +
> +extern int vclk_register(struct vclk *vclk, struct vclk_cci *cci, int n_child);
> +extern void vclk_unregister(struct vclk *vclk);
> +
>  struct cpufreq_frequency_table;
>  
>  struct clk_functions {
> -- 
> 1.5.5.1.357.g1af8b

-- 

BR,

---
Eduardo Bezerra Valentin
+55 92 21261118
