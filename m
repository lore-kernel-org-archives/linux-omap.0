From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Move clk_add_alias() to arch/arm/common/clkdev.c
	(Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work)
Date: Wed, 3 Jun 2009 09:44:33 -0700
Message-ID: <20090603164432.GE5026@atomide.com>
References: <20090519232905.12760.15490.stgit@localhost> <20090519233732.12760.34595.stgit@localhost> <20090525092911.GC28195@n2100.arm.linux.org.uk> <20090525142128.17675cl0tvdr0y1k@lidskialf.net> <20090525174055.127744136qxu9vk0@lidskialf.net> <20090528182047.GF32453@atomide.com> <20090528195320.GX20736@n2100.arm.linux.org.uk> <20090528210205.GH32453@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59367 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbZFCQot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 12:44:49 -0400
Content-Disposition: inline
In-Reply-To: <20090528210205.GH32453@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

* Tony Lindgren <tony@atomide.com> [090528 14:05]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090528 12:53]:
> > On Thu, May 28, 2009 at 11:20:48AM -0700, Tony Lindgren wrote:
> > > > +int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
> > > > +	struct device *dev)
> > > > +{
> > > > +	struct clk *r = clk_get(dev, id);
> > > > +	struct clk_lookup *l;
> > > > +
> > > > +	if (!r)
> > > > +		return -ENODEV;
> > > > +
> > > > +	l = clkdev_alloc(r, alias, alias_dev_name);
> > > > +	clk_put(r);
> > > > +	if (!l)
> > > > +		return -ENODEV;
> > > > +	clkdev_add(l);
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(clk_add_alias);
> > 
> > Oh, and a really good thing to do would be to fix the error checking and
> > returning in there (why did I miss it in the original PXA version...)
> 
> How about this? The prototype is in clk.h now, is that OK?

Added to patch tracking as 5536/1.
 
> Tony

> From e4e651822967b0530a9d092894c04149e28efe39 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 28 May 2009 13:24:12 -0700
> Subject: [PATCH] ARM: Move clk_add_alias() to arch/arm/common/clkdev.c
> 
> This can be used for other arm platforms too as discussed
> on the linux-arm-kernel list.
> 
> Also check the return value with IS_ERR and return PTR_ERR
> as suggested by Russell King.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
> index 5589444..f37afd9 100644
> --- a/arch/arm/common/clkdev.c
> +++ b/arch/arm/common/clkdev.c
> @@ -135,6 +135,24 @@ struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
>  }
>  EXPORT_SYMBOL(clkdev_alloc);
>  
> +int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
> +	struct device *dev)
> +{
> +	struct clk *r = clk_get(dev, id);
> +	struct clk_lookup *l;
> +
> +	if (IS_ERR(r))
> +		return PTR_ERR(r);
> +
> +	l = clkdev_alloc(r, alias, alias_dev_name);
> +	clk_put(r);
> +	if (!l)
> +		return -ENODEV;
> +	clkdev_add(l);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_add_alias);
> +
>  /*
>   * clkdev_drop - remove a clock dynamically allocated
>   */
> diff --git a/arch/arm/mach-pxa/clock.c b/arch/arm/mach-pxa/clock.c
> index db52d2c..49ae382 100644
> --- a/arch/arm/mach-pxa/clock.c
> +++ b/arch/arm/mach-pxa/clock.c
> @@ -86,20 +86,3 @@ void clks_register(struct clk_lookup *clks, size_t num)
>  	for (i = 0; i < num; i++)
>  		clkdev_add(&clks[i]);
>  }
> -
> -int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
> -	struct device *dev)
> -{
> -	struct clk *r = clk_get(dev, id);
> -	struct clk_lookup *l;
> -
> -	if (!r)
> -		return -ENODEV;
> -
> -	l = clkdev_alloc(r, alias, alias_dev_name);
> -	clk_put(r);
> -	if (!l)
> -		return -ENODEV;
> -	clkdev_add(l);
> -	return 0;
> -}
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1db9bbf..1d37f42 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -142,4 +142,17 @@ struct clk *clk_get_parent(struct clk *clk);
>   */
>  struct clk *clk_get_sys(const char *dev_id, const char *con_id);
>  
> +/**
> + * clk_add_alias - add a new clock alias
> + * @alias: name for clock alias
> + * @alias_dev_name: device name
> + * @id: platform specific clock name
> + * @dev: device
> + *
> + * Allows using generic clock names for drivers by adding a new alias.
> + * Assumes clkdev, see clkdev.h for more info.
> + */
> +int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
> +			struct device *dev);
> +
>  #endif

