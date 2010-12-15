From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH/RFC 2/2] OMAP: PM: implement context loss count APIs
Date: Tue, 14 Dec 2010 20:35:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142024030.15971@utopia.booyaka.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com> <1291939712-25487-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37055 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab0LODff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 22:35:35 -0500
In-Reply-To: <1291939712-25487-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin

a few comments here

On Thu, 9 Dec 2010, Kevin Hilman wrote:

> Implement OMAP PM layer omap_pm_get_dev_context_loss_count() API by
> creating similar APIs at the omap_device and omap_hwmod levels.  The
> omap_hwmod level call is the layer with access to the powerdomain
> core, so it is the place where the powerdomain is queried to get the
> context loss count.
> 
> NOTE: only works for devices which have been converted to use
>       omap_device/omap_hwmod.
> 
> Longer term, we could possibly remove this API from the OMAP PM layer,
> and instead directly use the omap_device level API.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   18 ++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
>  arch/arm/plat-omap/omap-pm-noop.c             |   17 +++++++++--------
>  arch/arm/plat-omap/omap_device.c              |   20 ++++++++++++++++++++
>  5 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 81c1097..0ec9c70 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2220,3 +2220,21 @@ ohsps_unlock:
>  
>  	return ret;
>  }
> +
> +/**
> + * omap_hwmod_get_context_loss_count - get lost context count
> + * @oh: struct omap_hwmod *
> + *
> + * Query the powerdomain of of @oh to get the context loss
> + * count for this device.

Might want to document the possible return values of this function, and 
suggest that its callers consider the context to be lost whenever a 
successful call to this function results in any different value than the 
caller got the last time it called this code.

> + */
> +int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
> +{
> +	struct powerdomain *pwrdm;
> +

Please test to see if oh is null here...

> +	pwrdm = omap_hwmod_get_pwrdm(oh);
> +	if (!pwrdm)
> +		return -ENODEV;
> +
> +	return pwrdm_get_context_loss_count(pwrdm);
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index 28e2d1a..70d31d0 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -107,6 +107,7 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
>  int omap_device_align_pm_lat(struct platform_device *pdev,
>  			     u32 new_wakeup_lat_limit);
>  struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
> +int omap_device_get_context_loss_count(struct platform_device *pdev);
>  
>  /* Other */
>  
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 62bdb23..5a96ac5 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -568,6 +568,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
>  				 void *user);
>  
>  int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
> +int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
> index 7578366..5a58f97 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -20,9 +20,11 @@
>  #include <linux/init.h>
>  #include <linux/cpufreq.h>
>  #include <linux/device.h>
> +#include <linux/platform_device.h>
>  
>  /* Interface documentation is in mach/omap-pm.h */
>  #include <plat/omap-pm.h>
> +#include <plat/omap_device.h>
>  
>  struct omap_opp *dsp_opps;
>  struct omap_opp *mpu_opps;
> @@ -288,20 +290,19 @@ unsigned long omap_pm_cpu_get_freq(void)
>  
>  int omap_pm_get_dev_context_loss_count(struct device *dev)
>  {
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int count;
> +
>  	if (!dev) {
>  		WARN_ON(1);
>  		return -EINVAL;
>  	};
>  
> -	pr_debug("OMAP PM: returning context loss count for dev %s\n",
> -		 dev_name(dev));
> +	count = omap_device_get_context_loss_count(pdev);
> +	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
> +		 dev_name(dev), count);
>  
> -	/*
> -	 * Map the device to the powerdomain.  Return the powerdomain
> -	 * off counter.
> -	 */
> -
> -	return 0;
> +	return count;
>  }
>  
>  
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index abe933c..e29c2d6 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -280,6 +280,26 @@ static void _add_optional_clock_alias(struct omap_device *od,
>  /* Public functions for use by core code */
>  
>  /**
> + * omap_device_get_context_loss_count - get lost context count
> + * @od: struct omap_device *
> + *
> + * Using the primary hwmod for this device, query the context loss
> + * count for this device.

Please document the possible return values here (as above).

> + */
> +int omap_device_get_context_loss_count(struct platform_device *pdev)
> +{
> +	struct omap_device *od;
> +	int ret = -ENODEV;
> +
> +	od = _find_by_pdev(pdev);
> +
> +	if (od->hwmods_cnt)
> +		omap_hwmod_get_context_loss_count(od->hwmods[0]);
> +
> +	return ret;
> +}
> +
> +/**
>   * omap_device_count_resources - count number of struct resource entries needed
>   * @od: struct omap_device *
>   *


- Paul
