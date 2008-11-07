From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH v2] OMAP: Fix McBSP spin_lock deadlock.
Date: Fri, 07 Nov 2008 21:52:41 +0800
Message-ID: <1226065961.24669.8.camel@localhost>
References: <1225975475-9300-1-git-send-email-stanley.miao@windriver.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53271 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbYKGNrE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Nov 2008 08:47:04 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mA7Dl4Df024113
	for <linux-omap@vger.kernel.org>; Fri, 7 Nov 2008 05:47:04 -0800 (PST)
In-Reply-To: <1225975475-9300-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This solution keeps the virtual clock in place and enable the child
clocks before enable the virtual clock. So, any comments ?

Stanley.

On Thu, 2008-11-06 at 20:44 +0800, Stanley.Miao wrote:
> A spin_lock deadlock will occur when omap_mcbsp_request() is invoked.
> 
> omap_mcbsp_request()         -->
> clk_enable(mcbsp->clk)       --> clk_enable get clockfw_lock, then call ->
> omap2_clk_enable()           -->
> _omap2_clk_enable()          -->
> omap_mcbsp_clk_enable()      -->
> clk_enable(mcbsp_ick)        --> now clk_enable acquire clockfw_lock again.
> 
> The solution:
> 
> If a alias clock has some relative clocks, enable relative clocks before enable
> the alias clock.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap1/mcbsp.c             |   67 ++++++------------------
>  arch/arm/mach-omap2/mcbsp.c             |   88 +++++++-----------------------
>  arch/arm/plat-omap/clock.c              |    9 +++-
>  arch/arm/plat-omap/include/mach/clock.h |    2 +
>  4 files changed, 47 insertions(+), 119 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
> index 7de7c69..cf220be 100644
> --- a/arch/arm/mach-omap1/mcbsp.c
> +++ b/arch/arm/mach-omap1/mcbsp.c
> @@ -26,80 +26,45 @@
>  #define DPS_RSTCT2_PER_EN	(1 << 0)
>  #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
>  
> -struct mcbsp_internal_clk {
> -	struct clk clk;
> -	struct clk **childs;
> -	int n_childs;
> -};
> -
>  #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
> -static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
> +static void omap_mcbsp_clk_init(struct clk *mclk)
>  {
>  	const char *clk_names[] = { "dsp_ck", "api_ck", "dspxor_ck" };
>  	int i;
>  
> -	mclk->n_childs = ARRAY_SIZE(clk_names);
> -	mclk->childs = kzalloc(mclk->n_childs * sizeof(struct clk *),
> +	mclk->n_relatives = ARRAY_SIZE(clk_names);
> +	mclk->relatives = kzalloc(mclk->n_relatives * sizeof(struct clk *),
>  				GFP_KERNEL);
>  
> -	for (i = 0; i < mclk->n_childs; i++) {
> +	for (i = 0; i < mclk->n_relatives; i++) {
>  		/* We fake a platform device to get correct device id */
>  		struct platform_device pdev;
>  
>  		pdev.dev.bus = &platform_bus_type;
> -		pdev.id = mclk->clk.id;
> -		mclk->childs[i] = clk_get(&pdev.dev, clk_names[i]);
> -		if (IS_ERR(mclk->childs[i]))
> +		pdev.id = mclk->id;
> +		mclk->relatives[i] = clk_get(&pdev.dev, clk_names[i]);
> +		if (IS_ERR(mclk->relatives[i]))
>  			printk(KERN_ERR "Could not get clock %s (%d).\n",
> -				clk_names[i], mclk->clk.id);
> +				clk_names[i], mclk->id);
>  	}
>  }
>  
> -static int omap_mcbsp_clk_enable(struct clk *clk)
> -{
> -	struct mcbsp_internal_clk *mclk = container_of(clk,
> -					struct mcbsp_internal_clk, clk);
> -	int i;
> -
> -	for (i = 0; i < mclk->n_childs; i++)
> -		clk_enable(mclk->childs[i]);
> -	return 0;
> -}
> -
> -static void omap_mcbsp_clk_disable(struct clk *clk)
> -{
> -	struct mcbsp_internal_clk *mclk = container_of(clk,
> -					struct mcbsp_internal_clk, clk);
> -	int i;
> -
> -	for (i = 0; i < mclk->n_childs; i++)
> -		clk_disable(mclk->childs[i]);
> -}
> -
> -static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
> +static struct clk omap_mcbsp_clks[] = {
>  	{
> -		.clk = {
> -			.name 		= "mcbsp_clk",
> -			.id		= 1,
> -			.enable		= omap_mcbsp_clk_enable,
> -			.disable	= omap_mcbsp_clk_disable,
> -		},
> +		.name 		= "mcbsp_clk",
> +		.id		= 1,
>  	},
>  	{
> -		.clk = {
> -			.name 		= "mcbsp_clk",
> -			.id		= 3,
> -			.enable		= omap_mcbsp_clk_enable,
> -			.disable	= omap_mcbsp_clk_disable,
> -		},
> +		.name 		= "mcbsp_clk",
> +		.id		= 3,
>  	},
>  };
>  
>  #define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
>  #else
>  #define omap_mcbsp_clks_size	0
> -static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
> -static inline void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
> +static struct clk __initdata *omap_mcbsp_clks;
> +static inline void omap_mcbsp_clk_init(struct clk *mclk)
>  { }
>  #endif
>  
> @@ -233,7 +198,7 @@ int __init omap1_mcbsp_init(void)
>  	for (i = 0; i < omap_mcbsp_clks_size; i++) {
>  		if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
>  			omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
> -			clk_register(&omap_mcbsp_clks[i].clk);
> +			clk_register(&omap_mcbsp_clks[i]);
>  		}
>  	}
>  
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index cae3ebe..20663e1 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -22,103 +22,57 @@
>  #include <mach/cpu.h>
>  #include <mach/mcbsp.h>
>  
> -struct mcbsp_internal_clk {
> -	struct clk clk;
> -	struct clk **childs;
> -	int n_childs;
> -};
> -
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> -static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
> +static void omap_mcbsp_clk_init(struct clk *mclk)
>  {
>  	const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
>  	int i;
>  
> -	mclk->n_childs = ARRAY_SIZE(clk_names);
> -	mclk->childs = kzalloc(mclk->n_childs * sizeof(struct clk *),
> +	mclk->n_relatives = ARRAY_SIZE(clk_names);
> +	mclk->relatives = kzalloc(mclk->n_relatives * sizeof(struct clk *),
>  				GFP_KERNEL);
>  
> -	for (i = 0; i < mclk->n_childs; i++) {
> +	for (i = 0; i < mclk->n_relatives; i++) {
>  		/* We fake a platform device to get correct device id */
>  		struct platform_device pdev;
>  
>  		pdev.dev.bus = &platform_bus_type;
> -		pdev.id = mclk->clk.id;
> -		mclk->childs[i] = clk_get(&pdev.dev, clk_names[i]);
> -		if (IS_ERR(mclk->childs[i]))
> +		pdev.id = mclk->id;
> +		mclk->relatives[i] = clk_get(&pdev.dev, clk_names[i]);
> +		if (IS_ERR(mclk->relatives[i]))
>  			printk(KERN_ERR "Could not get clock %s (%d).\n",
> -				clk_names[i], mclk->clk.id);
> +				clk_names[i], mclk->id);
>  	}
>  }
>  
> -static int omap_mcbsp_clk_enable(struct clk *clk)
> -{
> -	struct mcbsp_internal_clk *mclk = container_of(clk,
> -					struct mcbsp_internal_clk, clk);
> -	int i;
> -
> -	for (i = 0; i < mclk->n_childs; i++)
> -		clk_enable(mclk->childs[i]);
> -	return 0;
> -}
> -
> -static void omap_mcbsp_clk_disable(struct clk *clk)
> -{
> -	struct mcbsp_internal_clk *mclk = container_of(clk,
> -					struct mcbsp_internal_clk, clk);
> -	int i;
> -
> -	for (i = 0; i < mclk->n_childs; i++)
> -		clk_disable(mclk->childs[i]);
> -}
>  
> -static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
> +static struct clk omap_mcbsp_clks[] = {
>  	{
> -		.clk = {
> -			.name 		= "mcbsp_clk",
> -			.id		= 1,
> -			.enable		= omap_mcbsp_clk_enable,
> -			.disable	= omap_mcbsp_clk_disable,
> -		},
> +		.name 		= "mcbsp_clk",
> +		.id		= 1,
>  	},
>  	{
> -		.clk = {
> -			.name 		= "mcbsp_clk",
> -			.id		= 2,
> -			.enable		= omap_mcbsp_clk_enable,
> -			.disable	= omap_mcbsp_clk_disable,
> -		},
> +		.name 		= "mcbsp_clk",
> +		.id		= 2,
>  	},
>  	{
> -		.clk = {
> -			.name		= "mcbsp_clk",
> -			.id		= 3,
> -			.enable		= omap_mcbsp_clk_enable,
> -			.disable	= omap_mcbsp_clk_disable,
> -		},
> +		.name		= "mcbsp_clk",
> +		.id		= 3,
>  	},
>  	{
> -		.clk = {
> -			.name		= "mcbsp_clk",
> -			.id		= 4,
> -			.enable		= omap_mcbsp_clk_enable,
> -			.disable	= omap_mcbsp_clk_disable,
> -		},
> +		.name		= "mcbsp_clk",
> +		.id		= 4,
>  	},
>  	{
> -		.clk = {
> -			.name		= "mcbsp_clk",
> -			.id		= 5,
> -			.enable		= omap_mcbsp_clk_enable,
> -			.disable	= omap_mcbsp_clk_disable,
> -		},
> +		.name		= "mcbsp_clk",
> +		.id		= 5,
>  	},
>  };
>  
>  #define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
>  #else
>  #define omap_mcbsp_clks_size	0
> -static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
> +static struct clk __initdata *omap_mcbsp_clks;
>  static inline void omap_mcbsp_clk_init(struct clk *clk)
>  { }
>  #endif
> @@ -287,7 +241,7 @@ static int __init omap2_mcbsp_init(void)
>  	for (i = 0; i < omap_mcbsp_clks_size; i++) {
>  		/* Once we call clk_get inside init, we do not register it */
>  		omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
> -		clk_register(&omap_mcbsp_clks[i].clk);
> +		clk_register(&omap_mcbsp_clks[i]);
>  	}
>  
>  	if (cpu_is_omap2420())
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index d13acd2..1c4f877 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -77,11 +77,14 @@ EXPORT_SYMBOL(clk_get);
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
> -	int ret = 0;
> +	int i, ret = 0;
>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return -EINVAL;
>  
> +	for (i = 0; i < clk->n_relatives; i++)
> +		clk_enable(clk->relatives[i]);
> +
>  	spin_lock_irqsave(&clockfw_lock, flags);
>  	if (arch_clock->clk_enable)
>  		ret = arch_clock->clk_enable(clk);
> @@ -94,10 +97,14 @@ EXPORT_SYMBOL(clk_enable);
>  void clk_disable(struct clk *clk)
>  {
>  	unsigned long flags;
> +	int i;
>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return;
>  
> +	for (i = 0; i < clk->n_relatives; i++)
> +		clk_disable(clk->relatives[i]);
> +
>  	spin_lock_irqsave(&clockfw_lock, flags);
>  	if (clk->usecount == 0) {
>  		printk(KERN_ERR "Trying disable clock %s with 0 usecount\n",
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
> index 9088925..2760bcf 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -71,6 +71,8 @@ struct clk {
>  	__u8			enable_bit;
>  	__s8			usecount;
>  	u8			idlest_bit;
> +	struct clk		**relatives;
> +	int 			n_relatives;
>  	void			(*recalc)(struct clk *);
>  	int			(*set_rate)(struct clk *, unsigned long);
>  	long			(*round_rate)(struct clk *, unsigned long);
