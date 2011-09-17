From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/2] OMAP: omap_device: Add a method to build an
 omap_device from a DT node
Date: Sat, 17 Sep 2011 10:13:14 -0600
Message-ID: <20110917161314.GV3523@ponder.secretlab.ca>
References: <1316184199-12599-1-git-send-email-b-cousson@ti.com>
 <1316184199-12599-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61660 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab1IQQNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Sep 2011 12:13:15 -0400
Received: by gyg10 with SMTP id 10so3438866gyg.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Sep 2011 09:13:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316184199-12599-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 16, 2011 at 04:43:19PM +0200, Benoit Cousson wrote:
> Add a notifier called during device_add phase. If an of_node is present,
> retrieve the hwmod entry in order to populate properly the omap_device
> structure.
> For the moment the resource from the device-tree are overloaded.
> DT does not support named resource yet, and thus, most driver
> will not work without that information.
> 
> Add two helpers function to parse a property that contains multiple
> strings.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c |  144 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 144 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index cac7b9a..da13630 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -85,6 +85,8 @@
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/notifier.h>
>  
>  #include <plat/omap_device.h>
>  #include <plat/omap_hwmod.h>
> @@ -94,12 +96,15 @@
>  #define USE_WAKEUP_LAT			0
>  #define IGNORE_WAKEUP_LAT		1
>  
> +#define MAX_HWMOD_NAME_SIZE		32
> +
>  static int omap_device_register(struct platform_device *pdev);
>  static int omap_early_device_register(struct platform_device *pdev);
>  static struct omap_device *omap_device_alloc(struct platform_device *pdev,
>  				      struct omap_hwmod **ohs, int oh_cnt,
>  				      struct omap_device_pm_latency *pm_lats,
>  				      int pm_lats_cnt);
> +static void omap_device_delete(struct omap_device *od);
>  
>  
>  static struct omap_device_pm_latency omap_default_latency[] = {
> @@ -315,6 +320,138 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
>  		_add_clkdev(od, oh->opt_clks[i].role, oh->opt_clks[i].clk);
>  }
>  
> +/*
> + * XXX: DT helper functions that should probably move elsewhere if
> + * they become usefull for other needs.
> + */

Lets just *assume* these are useful for other needs and start with
them in drivers/of so that other people know that they actually exist.
Otherwise they will never be made generic. :-)

> +static int _dt_count_property_string(const char *prop, int len)
> +{
> +	int i = 0;
> +	size_t l = 0, total = 0;
> +
> +	if (!prop || !len)
> +		return -EINVAL;
> +
> +	for (i = 0; len >= total; total += l, prop += l) {
> +		l = strlen(prop) + 1;
> +		if (*prop != 0)
> +			i++;
> +	}
> +	return i;
> +}
> +
> +static int _dt_get_property(const char *prop, int len, int index, char *output,
> +			    int size)
> +{
> +	int i = 0;
> +	size_t l = 0, total = 0;
> +
> +	if (!prop || !len)
> +		return -EINVAL;
> +
> +	for (i = 0; len >= total; total += l, prop += l) {
> +		l = strlcpy(output, prop, size) + 1;
> +		if (*prop != 0) {
> +			if (i++ == index)
> +				return 0;
> +		}
> +	}
> +	return -ENODEV;
> +}
> +
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
> +	prop = of_get_property(pdev->dev.of_node, "hwmods", &prop_len);

I know you've posted it before, but what is the status of the "hwmods"
binding documentation.  I would expect it to be part of this patch.

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
> +	for (i = 0; i < oh_cnt; i++) {
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
> +	pdev->dev.pm_domain = &omap_device_pm_domain;
> +
> +odbfd_exit1:
> +	kfree(hwmods);
> +odbfd_exit:
> +	return ret;
> +}
> +
> +static int _omap_device_notifier_call(struct notifier_block *nb,
> +				      unsigned long event, void *dev)

Nit: Why the preceding underscore?  Generally that is only done for
'special' variants of public functions.  ie. for a variant that
expects a lock to already be held.

> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	switch (event) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		if (pdev->dev.of_node)
> +			omap_device_build_from_dt(pdev);
> +		break;
> +
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		if (pdev->archdata.od)
> +			omap_device_delete(pdev->archdata.od);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  
>  /* Public functions for use by core code */
>  
> @@ -499,6 +636,9 @@ oda_exit1:
>  
>  static void omap_device_delete(struct omap_device *od)
>  {
> +	if (!od)
> +		return;
> +
>  	od->pdev->archdata.od = NULL;
>  	kfree(od->pm_lats);
>  	kfree(od->hwmods);
> @@ -1034,8 +1174,12 @@ struct device omap_device_parent = {
>  	.parent         = &platform_bus,
>  };
>  
> +static struct notifier_block platform_nb;

Nit: Since it is static initialization, you can do the following
instead of setting it up in the init function.

static struct notifier_block platform_nb = {
	.notifier_call = _omap_device_notifier_call;
};

> +
>  static int __init omap_device_init(void)
>  {
> +	platform_nb.notifier_call = _omap_device_notifier_call;
> +	bus_register_notifier(&platform_bus_type, &platform_nb);
>  	return device_register(&omap_device_parent);
>  }
>  core_initcall(omap_device_init);
> -- 
> 1.7.0.4
> 
