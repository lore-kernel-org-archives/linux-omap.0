From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH/RFC 2/6] OMAP2+: PM: move runtime PM implementation to
 use device power domains
Date: Thu, 09 Jun 2011 17:30:47 +0300
Message-ID: <4DF0D917.905@maxwell.research.nokia.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com> <1302134569-22825-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:57395 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab1FIObM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 10:31:12 -0400
In-Reply-To: <1302134569-22825-3-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Balbi <balbi@ti.com>

Hi Kevin and Felipe,

Kevin Hilman wrote:
> In commit 7538e3db6e015e890825fbd9f8659952896ddd5b (PM: add support
> for device power domains) a better way for handling platform-specific
> power hooks was introduced.
> 
> Rather than using the platform_bus dev_pm_ops overrides
> (platform_bus_set_pm_ops()), this patch moves the OMAP runtime PM
> implementation over to using device power domains.
> 
> Since OMAP is the only user of platform_bus_set_pm_ops(), that
> interface can be removed (and will be in a forthcoming patch.)

I have little doubt of the correctness of the patch itself, but it
actually does break the USB on N900. I don't know PM so well that I
would have a good idea what might be going wrong here, so I'm not
certain that this is specific to the N900 either.

It looks strange to me also but I've tested it several times so I'm
fairly certain that the culprit is this very patch. :-) I'm using NFS
root and the device fails to respond to ping with the patch although it
can be clearly recognised by the host, and it also recognises the host.
It seems just that the data doesn't get through.

My .config may be found here:

<URL:http://www.retiisi.org.uk/~sakke/foo/.config>

And the respective boot logs, without and with the patch, are here:

<URL:http://www.retiisi.org.uk/~sakke/foo/boot-success.txt>
<URL:http://www.retiisi.org.uk/~sakke/foo/boot-fail.txt>

They're mostly the same.

There's no difference on host side logs either. The first connection is
with the patch, whereas the second one is without:

---
usb 5-2.1: new high speed USB device using ehci_hcd and address 42
cdc_ether 5-2.1:1.0: usb0: register 'cdc_ether' at usb-0000:00:1d.7-2.1,
CDC Ethernet Device, 0a:3b:20:fa:58:eb
device usb0 entered promiscuous mode
eth-usb: port 2(usb0) entering learning state
eth-usb: port 2(usb0) entering learning state
eth-usb: port 2(usb0) entering forwarding state
usb 5-2.1: USB disconnect, address 42
cdc_ether 5-2.1:1.0: usb0: unregister 'cdc_ether' usb-0000:00:1d.7-2.1,
CDC Ethernet Device
eth-usb: port 2(usb0) entering forwarding state
device usb0 left promiscuous mode
eth-usb: port 2(usb0) entering disabled state
usb 5-2.1: new high speed USB device using ehci_hcd and address 43
usb 5-2.1: USB disconnect, address 43
usb 5-2.1: new high speed USB device using ehci_hcd and address 44
cdc_ether 5-2.1:1.0: usb0: register 'cdc_ether' at usb-0000:00:1d.7-2.1,
CDC Ethernet Device, 4a:bc:09:bb:ba:98
device usb0 entered promiscuous mode
eth-usb: port 2(usb0) entering learning state
eth-usb: port 2(usb0) entering learning state
eth-usb: port 2(usb0) entering learning state
eth-usb: port 2(usb0) entering learning state
eth-usb: port 2(usb0) entering learning state
eth-usb: port 2(usb0) entering forwarding state
usb 5-2.1: USB disconnect, address 44
---

Any ideas?

The id of the patch in the mainline kernel is
638080c37ae08fd0c44cec13d7948ca5385ae851 .

Thanks.

> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile     |    6 +-
>  arch/arm/mach-omap2/pm_bus.c     |   85 --------------------------------------
>  arch/arm/plat-omap/omap_device.c |   22 ++++++++++
>  3 files changed, 25 insertions(+), 88 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/pm_bus.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index a45cd64..b353584 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -59,10 +59,10 @@ endif
>  # Power Management
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
> +obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
> -					   cpuidle34xx.o pm_bus.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
> +					   cpuidle34xx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
> deleted file mode 100644
> index 5acd2ab..0000000
> --- a/arch/arm/mach-omap2/pm_bus.c
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -/*
> - * Runtime PM support code for OMAP
> - *
> - * Author: Kevin Hilman, Deep Root Systems, LLC
> - *
> - * Copyright (C) 2010 Texas Instruments, Inc.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/io.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/platform_device.h>
> -#include <linux/mutex.h>
> -
> -#include <plat/omap_device.h>
> -#include <plat/omap-pm.h>
> -
> -#ifdef CONFIG_PM_RUNTIME
> -static int omap_pm_runtime_suspend(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	int r, ret = 0;
> -
> -	dev_dbg(dev, "%s\n", __func__);
> -
> -	ret = pm_generic_runtime_suspend(dev);
> -
> -	if (!ret && dev->parent == &omap_device_parent) {
> -		r = omap_device_idle(pdev);
> -		WARN_ON(r);
> -	}
> -
> -	return ret;
> -};
> -
> -static int omap_pm_runtime_resume(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	int r;
> -
> -	dev_dbg(dev, "%s\n", __func__);
> -
> -	if (dev->parent == &omap_device_parent) {
> -		r = omap_device_enable(pdev);
> -		WARN_ON(r);
> -	}
> -
> -	return pm_generic_runtime_resume(dev);
> -};
> -#else
> -#define omap_pm_runtime_suspend NULL
> -#define omap_pm_runtime_resume NULL
> -#endif /* CONFIG_PM_RUNTIME */
> -
> -static int __init omap_pm_runtime_init(void)
> -{
> -	const struct dev_pm_ops *pm;
> -	struct dev_pm_ops *omap_pm;
> -
> -	pm = platform_bus_get_pm_ops();
> -	if (!pm) {
> -		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
> -			__func__);
> -		return -ENODEV;
> -	}
> -
> -	omap_pm = kmemdup(pm, sizeof(struct dev_pm_ops), GFP_KERNEL);
> -	if (!omap_pm) {
> -		pr_err("%s: unable to alloc memory for new dev_pm_ops\n",
> -			__func__);
> -		return -ENOMEM;
> -	}
> -
> -	omap_pm->runtime_suspend = omap_pm_runtime_suspend;
> -	omap_pm->runtime_resume = omap_pm_runtime_resume;
> -
> -	platform_bus_set_pm_ops(omap_pm);
> -
> -	return 0;
> -}
> -core_initcall(omap_pm_runtime_init);
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 9bbda9a..93cd2fb 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -536,6 +536,27 @@ int omap_early_device_register(struct omap_device *od)
>  	return 0;
>  }
>  
> +static int _od_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	return omap_device_idle(pdev);
> +}
> +
> +static int _od_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	return omap_device_enable(pdev);
> +}
> +
> +static struct dev_power_domain omap_device_power_domain = {
> +	.ops = {
> +		.runtime_suspend = _od_runtime_suspend,
> +		.runtime_resume = _od_runtime_resume,
> +	}
> +};
> +
>  /**
>   * omap_device_register - register an omap_device with one omap_hwmod
>   * @od: struct omap_device * to register
> @@ -549,6 +570,7 @@ int omap_device_register(struct omap_device *od)
>  	pr_debug("omap_device: %s: registering\n", od->pdev.name);
>  
>  	od->pdev.dev.parent = &omap_device_parent;
> +	od->pdev.dev.pwr_domain = &omap_device_power_domain;
>  	return platform_device_register(&od->pdev);
>  }
>  


-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
