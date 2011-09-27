From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 2/2] OMAP: omap_device: Add a method to build an
 omap_device from a DT node
Date: Mon, 26 Sep 2011 19:46:32 -0600
Message-ID: <20110927014632.GB20588@ponder.secretlab.ca>
References: <1316724745-24896-1-git-send-email-b-cousson@ti.com>
 <1316724745-24896-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48624 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab1I0Bqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 21:46:35 -0400
Received: by yxl31 with SMTP id 31so4845124yxl.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 18:46:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316724745-24896-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 22, 2011 at 10:52:25PM +0200, Benoit Cousson wrote:
> Add a notifier called during device_add phase. If an of_node is present,
> retrieve the hwmod entry in order to populate properly the omap_device
> structure.
> For the moment the resource from the device-tree are overloaded.
> DT does not support named resource yet, and thus, most driver
> will not work without that information.
> 
> Add two helpers function to parse a property that contains multiple
> strings. Please note that these helpers will be replaced by a more generic
> iterator currently proposed on devicetree mailing list as soon as it
> will be merged.
> 
> Add a documentation to capture the specifics OMAP bindings
> needed for device-tree support.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |   42 ++++++
>  arch/arm/plat-omap/omap_device.c                   |  145 ++++++++++++++++++++
>  2 files changed, 187 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> new file mode 100644
> index 0000000..6513d05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -0,0 +1,42 @@
> +* Texas Instruments OMAP
> +
> +OMAP is currently using a static file per SoC family to describe the
> +IPs present in the SoC.
> +On top of that an omap_device is created to extend the platform_device
> +capabilities and to allow binding with one or several hwmods.
> +The hwmods will contain all the information to build the device:
> +adresse range, irq lines, dma lines, interconnect, PRCM register,
> +clock domain, input clocks.
> +For the moment just point to the existing hwmod, the next step will be
> +to move data from hwmod to device-tree representation.
> +
> +
> +Required properties:
> +- compatible: Every devices present in OMAP SoC should be in the
> +  form: "ti,XXX"
> +- ti,hwmods: list of hwmods attached to a device. Must contain at least
> +  one hwmod.

Nit: This should specify that ti,hwmods is a list of hwmod names
(ascii strings), and that the hwmod names come from the OMAP
documentation.  Don't respin the patch over this though, just do a
follow-up patch.

> +
> +Optional properties:
> +- ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
> +  during suspend.
> +
> +
> +Example:
> +
> +spinlock@1 {
> +    compatible = "ti,omap-spinlock";
> +    ti,hwmods = "spinlock";
> +};
> +
> +
> +Boards:
> +
> +- OMAP3 BeagleBoard : Low cost community board
> +  compatible = "ti,omap3-beagle", "ti,omap3"
> +
> +- OMAP4 SDP : Software Developement Board
> +  compatible = "ti,omap4-sdp", "ti,omap4430"
> +
> +- OMAP4 PandaBoard : Low cost community board
> +  compatible = "ti,omap4-panda", "ti,omap4430"
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index cac7b9a..5b63989 100644
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
> + * XXX: DT helper functions that should be replaced by more generic
> + * API introduced by Stephen Warren once they'll be in mainline.
> + */
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

Don't merge this.  Kevin or I could put Stephen's patch into a separate
branch that both Kevin and I pull.  There's no need to merge temporary
code.

That said, I just looked at Stephen's iterator, and even without it
this particular hunk shouldn't be merged here.  A
of_property_count_strings() function is useful in and of itself, and
of_property_read_string() could be extended with an
of_property_read_string_index() version.  Both changes should be in
the common drivers/of code, and you can easily do them.

Otherwise, both patches look good to me.

g.

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
> +	prop = of_get_property(pdev->dev.of_node, "ti,hwmods", &prop_len);
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
> +	if (of_get_property(pdev->dev.of_node, "ti,no_idle_on_suspend", NULL))
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
> @@ -1034,8 +1174,13 @@ struct device omap_device_parent = {
>  	.parent         = &platform_bus,
>  };
>  
> +static struct notifier_block platform_nb = {
> +	.notifier_call = _omap_device_notifier_call,
> +};
> +
>  static int __init omap_device_init(void)
>  {
> +	bus_register_notifier(&platform_bus_type, &platform_nb);
>  	return device_register(&omap_device_parent);
>  }
>  core_initcall(omap_device_init);
> -- 
> 1.7.0.4
> 
