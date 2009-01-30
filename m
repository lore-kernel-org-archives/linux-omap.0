From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Adding and building TPS6235x based PR785 board support
Date: Fri, 30 Jan 2009 11:53:14 +0000
Message-ID: <20090130115313.GB18825@sirena.org.uk>
References: <1233307390-14974-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1204 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbZA3LxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 06:53:16 -0500
Content-Disposition: inline
In-Reply-To: <1233307390-14974-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jan 30, 2009 at 02:53:10PM +0530, Manikandan Pillai wrote:

> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -27,6 +27,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
>  #include <mach/mux.h>
> +#include <linux/string.h>
> +#include <linux/regulator/machine.h>

> +#if defined(CONFIG_OMAP3EVM_PR785)
> +/* This is the callback function used to find the correct
> + * i2c platform child for the regulator consumer
> +*/
> +int omap_i2c_match_child(struct device *dev, void *data)
> +{
> +	struct regulator_init_data *reg_init_data = dev->platform_data;
> +	char *name = data;
> +
> +	/* Child does not match */
> +	if (strcmp(name, reg_init_data->consumer_supplies->supply))
> +		return 0;
> +	else
> +		return 1;
> +}
> +
> +int omap_i2c_register_child(struct platform_device *pdev_parent,
> +			const char *name, struct platform_device **pdev)
> +{
> +	int ret = 0;
> +
> +	*pdev = platform_device_alloc(name, -1);
> +	if (pdev == NULL) {
> +		dev_err(&(*pdev)->dev, "Failed to alloc i2c-child %s\n", name);
> +		return -1;
> +	}
> +
> +	(*pdev)->dev.parent = &pdev_parent->dev;
> +	if (!strcmp(name, "vdd2_consumer"))
> +		(*pdev)->dev.platform_data = &vdd2_tps_regulator_data;
> +	else if (!strcmp(name, "vdd1_consumer"))
> +		(*pdev)->dev.platform_data = &vdd1_tps_regulator_data;
> +
> +
> +	ret = platform_device_add(*pdev);
> +	if (ret != 0) {
> +		dev_err(&(*pdev)->dev, "Failed to register %s: %d\n",
> +			name, ret);
> +		platform_device_put(*pdev);
> +		*pdev = NULL;
> +	}
> +	return ret;
> +}
> +#endif

I'm not sure what this is intended for but if it's in the generic OMAP
I2C driver it shouldn't be conditional on this particular EVM and
shouldn't have hard coded references to board specific things.

> @@ -160,5 +216,16 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
>  
>  	omap_i2c_mux_pins(bus_id - 1);
> -	return platform_device_register(pdev);
> +	platform_device_register(pdev);
> +#if defined(CONFIG_OMAP3EVM_PR785)
> +	if (bus_id == 1) {
> +		omap_i2c_register_child(pdev, "vdd2_consumer", \
> +				&vdd2_platform_device);
> +		omap_i2c_register_child(pdev, "vdd1_consumer", \
> +				&vdd1_platform_device);
> +		tps62352_core_consumers.dev = &vdd2_platform_device->dev;
> +		tps62352_mpu_consumers.dev = &vdd1_platform_device->dev;
> +	}
> +#endif
> +	return 0;

Ditto.  It's important to remember that this I2C driver is going to be
used by all OMAP systems using I2C - patching in ifdefs for setting up
each board isn't going to scale, they would end up obscuring the code
for the I2C controller itself.

> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 0dacb18..fdc5f5b 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -12,5 +12,6 @@ obj-$(CONFIG_REGULATOR_TWL4030) += twl4030-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
> +obj-$(CONFIG_REGULATOR_TPS6235X)+= tps6235x-regulator.o
>  

This wants to be in your previous patch, as do the changes to the
regulator driver below.
