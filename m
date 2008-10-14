From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Tue, 14 Oct 2008 11:08:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <1223333252-25687-2-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42297 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbYJNRIu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 13:08:50 -0400
In-Reply-To: <1223333252-25687-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

Hi Felipe,

so I'll put most of my comments here.

On Tue, 7 Oct 2008, Felipe Balbi wrote:

> Introduce a new mechanism to omap's clk implementation to
> associate the device with its clock during platform_device
> registration. Also gives the clock a function name (like
> mmc_fck, uart_fck, ehci_fck, etc) so drivers won't have to
> care about clk names any longer.

Let's make the function names shorter, like "fclk" and "iclk".  That 
should make them even easier to use in situations where the device name 
itself changes, e.g., "mmc"/"hsmmc" etc.  Plus the linker will be able to 
merge many them together into single constant strings.  For a device with 
multiple fclks like DSS, we can use "tv_fclk" also, etc.

> With this mechanism we can also be sure drivers won't be able
> to clk_get the wrong clk (only true when we move all drivers
> to this new mechanism and drop the old ones).
> 
> Clk's function names will be defined as they come necessary
> but let's try to keep it as simple as possible.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/plat-omap/clock.c              |   38 +++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/mach/clock.h |    6 +++++
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 7bbfba2..c090f23 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -43,7 +43,7 @@ static struct clk_functions *arch_clock;
>   */
>  struct clk * clk_get(struct device *dev, const char *id)
>  {
> -	struct clk *p, *clk = ERR_PTR(-ENOENT);
> +	struct clk *p, *clk;
>  	int idno;
>  
>  	if (dev == NULL || dev->bus != &platform_bus_type)
> @@ -53,6 +53,15 @@ struct clk * clk_get(struct device *dev, const char *id)
>  
>  	mutex_lock(&clocks_mutex);
>  
> +	list_for_each_entry(clk, &clocks, node) {
> +		if (clk->function && (dev == clk->dev) &&
> +				strcmp(id, clk->function) == 0)
> +			goto found;

Please avoid the gotos and use the previously-used form for returning 
success, e.g., iterate on p; if found, then assign to clk, and break.

Also, is there some reason why there are two list_for_each_entry() blocks?  
Those should be merged into one.

> +
> +		if (strcmp(id, clk->name) == 0)
> +			goto found;

Doesn't the following code already handle the above case?

> +	}
> +
>  	list_for_each_entry(p, &clocks, node) {
>  		if (p->id == idno &&
>  		    strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
> @@ -64,10 +73,14 @@ struct clk * clk_get(struct device *dev, const char *id)
>  	list_for_each_entry(p, &clocks, node) {
>  		if (strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
>  			clk = p;
> -			break;
> +			goto found;
>  		}
>  	}
>  
> +	mutex_unlock(&clocks_mutex);
> +
> +	return ERR_PTR(-ENOENT);

the above two lines will then become unnecessary.

> +
>  found:
>  	mutex_unlock(&clocks_mutex);
>  
> @@ -75,6 +88,27 @@ found:
>  }
>  EXPORT_SYMBOL(clk_get);
>  
> +/**

First, thank you for using kerneldoc.  But ...

> + * omap_clk_associate - associates a user to a clock so device drivers don't
> + * have to care about clock names

... Documentation/kernel-doc-nano-HOWTO.txt requires the short function 
description to fit on one line.  If you need more room, please put the 
larger description after a blank line after the last argument 
documentation line (e.g., line beginning with '@').

> + *

This blank line needs to be removed per kerneldoc - "The @argument 
descriptions must begin on the very next line ..."

> + * @id: clock id as defined in arch/arm/mach-omapX/clkxxxx.h
> + * @dev: device pointer for the clock user
> + * @f: a function for the clock (uart_[if]ck, musb_ick, ehci_[if]ck, etc)
> + */
> +void __init omap_clk_associate(const char *id, struct device *dev, const char *f)
> +{
> +	struct clk *clk = clk_get(NULL, id);
> +
> +	if (!dev || !clk || !IS_ERR(clk_get(dev, f)))
> +		return;

Please break the clk_get() test above out into its own statement, and 
clk_put() it before returning.

> +
> +	clk->function = f;
> +	clk->dev = dev;

There needs to be a test before these lines to ensure that some driver has 
not already associated a function with this clock, or a device with this 
clock, and to WARN_ON(1) if it has.

But there seems to be a deeper problem.  What happens when multiple device 
drivers want to associate to the same clock?  osc_ck is the pathological 
case.  Seems like you'll need a different data structure, like a list, to 
store in the struct clk.

> +
> +	clk_put(clk);
> +};
> +
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
> index 9088925..21f18ca 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -13,6 +13,8 @@
>  #ifndef __ARCH_ARM_OMAP_CLOCK_H
>  #define __ARCH_ARM_OMAP_CLOCK_H
>  
> +#include <linux/device.h>
> +
>  struct module;
>  struct clk;
>  struct clockdomain;
> @@ -61,8 +63,10 @@ struct dpll_data {
>  
>  struct clk {
>  	struct list_head	node;
> +	struct device		*dev;
>  	struct module		*owner;
>  	const char		*name;
> +	const char		*function;
>  	int			id;
>  	struct clk		*parent;
>  	unsigned long		rate;
> @@ -116,6 +120,8 @@ struct clk_functions {
>  
>  extern unsigned int mpurate;
>  
> +extern void omap_clk_associate(const char *id,
> +		struct device *dev, const char *func);
>  extern int clk_init(struct clk_functions *custom_clocks);
>  extern int clk_register(struct clk *clk);
>  extern void clk_unregister(struct clk *clk);
> -- 
> 1.6.0.1.196.g01914
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
