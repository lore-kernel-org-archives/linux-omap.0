From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: Do not expect an entry in clkdev to add
 alias for opt_clks
Date: Mon, 31 Jan 2011 16:08:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101311606030.16671@utopia.booyaka.com>
References: <1296213475-23460-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55243 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab1AaXIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 18:08:34 -0500
In-Reply-To: <1296213475-23460-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Rajendra

one brief comment below.  Also, when you post an updated version, could 
you cc the linux-arm-kernel mailing list?  That way I won't have to do 
it...

On Fri, 28 Jan 2011, Rajendra Nayak wrote:

> The _add_optional_clock_alias function expects an entry
> already existing in the clkdev table in the form of
> <dev-id=NULL, con-id=role> which might not be the case
> always.
> 
> Instead, just check if an entry already exists in clkdev
> in the <dev-id=dev_name, con-id=role> form, else go ahead
> and add one.
> 
> Remove any assumption of an entry already existing in clkdev
> table in any form.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c |   25 +++++++++++++++++++------
>  1 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 57adb27..80d4f35 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -83,9 +83,11 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> +#include <linux/clkdev.h>
>  
>  #include <plat/omap_device.h>
>  #include <plat/omap_hwmod.h>
> +#include <plat/clock.h>
>  
>  /* These parameters are passed to _omap_device_{de,}activate() */
>  #define USE_WAKEUP_LAT			0
> @@ -244,7 +246,7 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
>   *
>   * For every optional clock present per hwmod per omap_device, this function
>   * adds an entry in the clocks list of the form <dev-id=dev_name, con-id=role>
> - * if an entry is already present in it with the form <dev-id=NULL, con-id=role>
> + * if it does not exist already.
>   *
>   * The function is called from inside omap_device_build_ss(), after
>   * omap_device_register.
> @@ -258,21 +260,32 @@ static void _add_optional_clock_alias(struct omap_device *od,
>  				      struct omap_hwmod *oh)
>  {
>  	int i;
> +	struct clk_lookup *l;
> +	struct omap_hwmod_opt_clk *oc;
>  
>  	for (i = 0; i < oh->opt_clks_cnt; i++) {
> -		struct omap_hwmod_opt_clk *oc;
> -		int r;
> +		struct clk *r;
>  
>  		oc = &oh->opt_clks[i];
>  
>  		if (!oc->_clk)
>  			continue;
>  
> -		r = clk_add_alias(oc->role, dev_name(&od->pdev.dev),
> -				  (char *)oc->clk, &od->pdev.dev);
> -		if (r)
> +		r = clk_get_sys(dev_name(&od->pdev.dev), oc->role);
> +		if (!IS_ERR(r))
> +			continue; /* clkdev entry exists */
> +
> +		r = omap_clk_get_by_name((char *)oc->clk);
> +		if (IS_ERR(r)) {
>  			pr_err("omap_device: %s: clk_add_alias for %s failed\n",
>  			       dev_name(&od->pdev.dev), oc->role);
> +			continue;
> +		}
> +
> +		l = clkdev_alloc(r, oc->role, dev_name(&od->pdev.dev));
> +		if (!l)
> +			return;

Please add a pr_err() in this case, similar to the above one; that way 
in the unlikely event that this fails, there will be some sign of what is 
happening...  other than that, it looks good to me


> +		clkdev_add(l);
>  	}
>  }
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
