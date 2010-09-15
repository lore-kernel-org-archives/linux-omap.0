From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] OMAP: omap_device: make all devices a child of
 a new parent device
Date: Wed, 15 Sep 2010 17:02:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009151638190.458@utopia.booyaka.com>
References: <1284489714-14705-1-git-send-email-khilman@deeprootsystems.com> <1284489714-14705-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53996 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0IOXCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 19:02:05 -0400
In-Reply-To: <1284489714-14705-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Tue, 14 Sep 2010, Kevin Hilman wrote:

> From: Kevin Hilman <khilman@ti.com>
> 
> In order to help differentiate omap_devices from normal
> platform_devices, make them all a parent of a new common parent
> device.
> 
> Then, in order to determine if a platform_device is also an
> omap_device, checking the parent is all that is needed.
> 
> Users of this feature are the runtime PM core for OMAP, where we need
> to know if a device being passed in is an omap_device or not in order
> to know whether to call the omap_device API with it.
> 
> In addition, all omap_devices will now show up under /sys/devices/omap
> instead of /sys/devices/platform
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

At least with the current state of the Linux kernel codebase, I think it 
would be better to have an omap_bus/omap_bus_type.  But as we've 
discussed, that is a lot of work, and this solution seems to solve the 
immediate problem -- how to determine if a device is really an omap_device 
-- while being minimally invasive to the rest of the kernel code and 
device model.  So, looks good to me for now,

Acked-by: Paul Walmsley <paul@pwsan.com>

and feel free to merge this and patch 1/2 through your tree...

- Paul

> ---
> Changes since v1:
> - renamed the device from omap_bus to omap_parent_device to be more
>   clear that this is not a bus.
> 
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
>  arch/arm/plat-omap/omap_device.c              |   12 ++++++++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index bad4c3d..28e2d1a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -36,6 +36,8 @@
>  
>  #include <plat/omap_hwmod.h>
>  
> +extern struct device omap_device_parent;
> +
>  /* omap_device._state values */
>  #define OMAP_DEVICE_STATE_UNKNOWN	0
>  #define OMAP_DEVICE_STATE_ENABLED	1
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 7f05f49..8215b1b 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -465,6 +465,7 @@ int omap_device_register(struct omap_device *od)
>  {
>  	pr_debug("omap_device: %s: registering\n", od->pdev.name);
>  
> +	od->pdev.dev.parent = &omap_device_parent;
>  	return platform_device_register(&od->pdev);
>  }
>  
> @@ -737,3 +738,14 @@ int omap_device_enable_clocks(struct omap_device *od)
>  	/* XXX pass along return value here? */
>  	return 0;
>  }
> +
> +struct device omap_device_parent = {
> +	.init_name	= "omap",
> +	.parent         = &platform_bus,
> +};
> +
> +static int __init omap_device_init(void)
> +{
> +	return device_register(&omap_device_parent);
> +}
> +core_initcall(omap_device_init);
> -- 
> 1.7.2.1
> 


