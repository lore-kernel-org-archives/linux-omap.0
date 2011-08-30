From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 3/3] OMAP: omap_device: Add a method to build an omap_device
 from a DT node
Date: Tue, 30 Aug 2011 15:31:55 +0200
Message-ID: <4E5CE64B.5080500@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com> <1314037343-19783-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59388 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898Ab1H3NbX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 09:31:23 -0400
In-Reply-To: <1314037343-19783-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

Kevin,

Some self-review...

On 8/22/2011 8:22 PM, Cousson, Benoit wrote:
> Add a notifier called during device_add phase. If a of_node is present,
> retrieve the hwmod entry in order to populate propely the omap_device

typo

> structure.
> For the moment the resource from the device-tree are overloaded.
> DT does not support named resource yet, and thus, most driver
> will not work without that information.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/plat-omap/omap_device.c |  102 ++++++++++++++++++++++++++++++++++++++
>   1 files changed, 102 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 70361f8..0ae9e7f 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -85,6 +85,8 @@
>   #include<linux/clk.h>
>   #include<linux/clkdev.h>
>   #include<linux/pm_runtime.h>
> +#include<linux/of_platform.h>

This is not the proper include and will break non-DT build.
It should be that one:

+#include<linux/of.h>

I'll fix the series and re-send.

Benoit


> +#include<linux/notifier.h>
>
>   #include<plat/omap_device.h>
>   #include<plat/omap_hwmod.h>
> @@ -94,6 +96,8 @@
>   #define USE_WAKEUP_LAT			0
>   #define IGNORE_WAKEUP_LAT		1
>
> +#define MAX_HWMOD_NAME_SIZE		32
> +
>   static int omap_device_register(struct platform_device *pdev);
>   static int omap_early_device_register(struct platform_device *pdev);
>   static struct omap_device *omap_device_alloc(struct platform_device *pdev,
> @@ -354,6 +358,100 @@ static int _dt_get_property(const char *prop, int len, int index, char *output,
>   	return -ENODEV;
>   }
>
> +static struct dev_pm_domain omap_device_pm_domain;
> +
> +/**
> + * omap_device_build_from_dt - build an omap_device with multiple hwmods
> + * @pdev_name: name of the platform_device driver to use
> + * @pdev_id: this platform_device's connection ID
> + * @oh: ptr to the single omap_hwmod that backs this omap_device
> + * @pdata: platform_data ptr to associate with the platform_device
> + * @pdata_len: amount of memory pointed to by @pdata
> + * @pm_lats: pointer to a omap_device_pm_latency array for this device
> + * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
> + * @is_early_device: should the device be registered as an early device or not
> + *
> + * Function for building an omap_device already registered from device-tree
> + *
> + * Returns 0 or PTR_ERR() on error.
> + */
> +static int omap_device_build_from_dt(struct platform_device *pdev)
> +{
> +	struct omap_hwmod **hwmods;
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +	char oh_name[MAX_HWMOD_NAME_SIZE];
> +	const char *prop;
> +	int oh_cnt, i, prop_len;
> +	int ret = 0;
> +
> +	prop = of_get_property(pdev->dev.of_node, "hwmods",&prop_len);
> +	oh_cnt = _dt_count_property_string(prop, prop_len);
> +	if (!oh_cnt || IS_ERR_VALUE(oh_cnt)) {
> +		dev_warn(&pdev->dev, "No 'hwmods' to build omap_device\n");
> +		return -ENODEV;
> +	}
> +
> +	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt, GFP_KERNEL);
> +	if (!hwmods) {
> +		ret = -ENOMEM;
> +		goto odbfd_exit;
> +	}
> +
> +	for (i = 0; i<  oh_cnt; i++) {
> +		_dt_get_property(prop, prop_len, i, oh_name,
> +				 MAX_HWMOD_NAME_SIZE);
> +
> +		oh = omap_hwmod_lookup(oh_name);
> +		if (!oh) {
> +			dev_err(&pdev->dev, "Cannot lookup hwmod '%s'\n",
> +				oh_name);
> +			ret = -EINVAL;
> +			goto odbfd_exit1;
> +		}
> +		hwmods[i] = oh;
> +	}
> +
> +	od = omap_device_alloc(pdev, hwmods, oh_cnt, NULL, 0);
> +	if (!od) {
> +		dev_err(&pdev->dev, "Cannot allocate omap_device for :%s\n",
> +			oh_name);
> +		ret = PTR_ERR(od);
> +		goto odbfd_exit1;
> +	}
> +
> +	if (of_get_property(pdev->dev.of_node, "no_idle_on_suspend", NULL))
> +		omap_device_disable_idle_on_suspend(pdev);
> +
> +	pdev->dev.pm_domain =&omap_device_pm_domain;
> +
> +odbfd_exit1:
> +	kfree(hwmods);
> +odbfd_exit:
> +	return ret;
> +}
> +
> +static int _omap_device_notifier_call(struct notifier_block *nb,
> +				      unsigned long event, void *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	switch (event) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		if (pdev->dev.of_node) {
> +			dev_dbg(&pdev->dev, "add_device with DT bindings\n");
> +			omap_device_build_from_dt(pdev);
> +		}
> +		break;
> +
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		dev_dbg(&pdev->dev, "del_device\n");
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>
>   /* Public functions for use by core code */
>
> @@ -1064,8 +1162,12 @@ struct device omap_device_parent = {
>   	.parent         =&platform_bus,
>   };
>
> +static struct notifier_block platform_nb;
> +
>   static int __init omap_device_init(void)
>   {
> +	platform_nb.notifier_call = _omap_device_notifier_call;
> +	bus_register_notifier(&platform_bus_type,&platform_nb);
>   	return device_register(&omap_device_parent);
>   }
>   core_initcall(omap_device_init);

