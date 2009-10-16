From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: Use getnstimeofday for omap_device
Date: Fri, 16 Oct 2009 10:42:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910161041490.2061@utopia.booyaka.com>
References: <20091008002506.GF29320@atomide.com> <20091008002659.GG29320@atomide.com> <20091008002814.GH29320@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60835 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZJPQmO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 12:42:14 -0400
In-Reply-To: <20091008002814.GH29320@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, 7 Oct 2009, Tony Lindgren wrote:

> Don't know if this generic solution is accurate enough?

Looks fine to me.  Thanks -

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> Tony
> 
> 
> >From 4b059c50262954ae4ce466983b5cf088851eab19 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 7 Oct 2009 17:10:18 -0700
> Subject: [PATCH] omap: Use getnstimeofday for omap_device
> 
> Otherwise we cannot remove OMAP2_IO_ADDRESS.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 2c409fc..12513f4 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -103,21 +103,6 @@
>  /* Private functions */
>  
>  /**
> - * _read_32ksynct - read the OMAP 32K sync timer
> - *
> - * Returns the current value of the 32KiHz synchronization counter.
> - * XXX this should be generalized to simply read the system clocksource.
> - * XXX this should be moved to a separate synctimer32k.c file
> - */
> -static u32 _read_32ksynct(void)
> -{
> -	if (!cpu_class_is_omap2())
> -		BUG();
> -
> -	return __raw_readl(OMAP2_IO_ADDRESS(OMAP_32KSYNCT_BASE + 0x010));
> -}
> -
> -/**
>   * _omap_device_activate - increase device readiness
>   * @od: struct omap_device *
>   * @ignore_lat: increase to latency target (0) or full readiness (1)?
> @@ -133,13 +118,13 @@ static u32 _read_32ksynct(void)
>   */
>  static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
>  {
> -	u32 a, b;
> +	struct timespec a, b, c;
>  
>  	pr_debug("omap_device: %s: activating\n", od->pdev.name);
>  
>  	while (od->pm_lat_level > 0) {
>  		struct omap_device_pm_latency *odpl;
> -		int act_lat = 0;
> +		unsigned long long act_lat = 0;
>  
>  		od->pm_lat_level--;
>  
> @@ -149,20 +134,22 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
>  		    (od->dev_wakeup_lat <= od->_dev_wakeup_lat_limit))
>  			break;
>  
> -		a = _read_32ksynct();
> +		getnstimeofday(&a);
>  
>  		/* XXX check return code */
>  		odpl->activate_func(od);
>  
> -		b = _read_32ksynct();
> +		getnstimeofday(&b);
>  
> -		act_lat = (b - a) >> 15; /* 32KiHz cycles to microseconds */
> +		c = timespec_sub(b, a);
> +		act_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
>  
>  		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
> -			 "%d usec\n", od->pdev.name, od->pm_lat_level, act_lat);
> +			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
> +			 act_lat);
>  
>  		WARN(act_lat > odpl->activate_lat, "omap_device: %s.%d: "
> -		     "activate step %d took longer than expected (%d > %d)\n",
> +		     "activate step %d took longer than expected (%llu > %d)\n",
>  		     od->pdev.name, od->pdev.id, od->pm_lat_level,
>  		     act_lat, odpl->activate_lat);
>  
> @@ -188,13 +175,13 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
>   */
>  static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
>  {
> -	u32 a, b;
> +	struct timespec a, b, c;
>  
>  	pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
>  
>  	while (od->pm_lat_level < od->pm_lats_cnt) {
>  		struct omap_device_pm_latency *odpl;
> -		int deact_lat = 0;
> +		unsigned long long deact_lat = 0;
>  
>  		odpl = od->pm_lats + od->pm_lat_level;
>  
> @@ -203,23 +190,24 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
>  		     od->_dev_wakeup_lat_limit))
>  			break;
>  
> -		a = _read_32ksynct();
> +		getnstimeofday(&a);
>  
>  		/* XXX check return code */
>  		odpl->deactivate_func(od);
>  
> -		b = _read_32ksynct();
> +		getnstimeofday(&b);
>  
> -		deact_lat = (b - a) >> 15; /* 32KiHz cycles to microseconds */
> +		c = timespec_sub(b, a);
> +		deact_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
>  
>  		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
> -			 "%d usec\n", od->pdev.name, od->pm_lat_level,
> +			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
>  			 deact_lat);
>  
>  		WARN(deact_lat > odpl->deactivate_lat, "omap_device: %s.%d: "
> -		     "deactivate step %d took longer than expected (%d > %d)\n",
> -		     od->pdev.name, od->pdev.id, od->pm_lat_level,
> -		     deact_lat, odpl->deactivate_lat);
> +		     "deactivate step %d took longer than expected "
> +		     "(%llu > %d)\n", od->pdev.name, od->pdev.id,
> +		     od->pm_lat_level, deact_lat, odpl->deactivate_lat);
>  
>  		od->dev_wakeup_lat += odpl->activate_lat;
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
