From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 5/5] OMAP: I2C: Convert I2C driver to use device tree
Date: Wed, 6 Jul 2011 13:08:03 -0600
Message-ID: <20110706190803.GN4871@ponder.secretlab.ca>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-6-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56680 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab1GFTIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 15:08:06 -0400
Received: by pzk9 with SMTP id 9so202011pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 12:08:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309426647-31587-6-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jun 30, 2011 at 03:07:27PM +0500, G, Manjunath Kondaiah wrote:
> 
> The OMAP I2C driver is modified to use platform_device data from
> device tree data structures.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>

Mostly looks good, but a few things that need to be fixed.  You can
probably even get this change merged for v3.1

> ---
>  drivers/i2c/busses/i2c-omap.c |   30 +++++++++++++++++++++++++++++-
>  1 files changed, 29 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ae1545b..d4ccc52 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -38,9 +38,13 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/of_i2c.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/i2c-omap.h>
>  #include <linux/pm_runtime.h>
> +#include <plat/i2c.h>
>  
>  /* I2C controller revisions */
>  #define OMAP_I2C_REV_2			0x20
> @@ -972,6 +976,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
>  	.functionality	= omap_i2c_func,
>  };
>  
> +static const struct of_device_id omap_i2c_of_match[];
>  static int __devinit
>  omap_i2c_probe(struct platform_device *pdev)
>  {
> @@ -979,10 +984,15 @@ omap_i2c_probe(struct platform_device *pdev)
>  	struct i2c_adapter	*adap;
>  	struct resource		*mem, *irq, *ioarea;
>  	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
> +	const struct of_device_id *match;
>  	irq_handler_t isr;
>  	int r;
>  	u32 speed = 0;
>  
> +	match = of_match_device(omap_i2c_of_match, &pdev->dev);
> +	if (!match)
> +		dev_err(&pdev->dev, "DT: i2c device match not found.......\n");
> +

This isn't an error.  It just mean that the device wasn't registered
from the device tree, and it needs to get its configuration from
pdata.

In fact, you don't even need this block since the driver never uses
the match entry returned by of_match_device()

>  	/* NOTE: driver uses the static register mapping */
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!mem) {
> @@ -1007,10 +1017,19 @@ omap_i2c_probe(struct platform_device *pdev)
>  		r = -ENOMEM;
>  		goto err_release_region;
>  	}
> -

Don't drop the empty line.

> +	/* I2C device without DT might use this */

No need for the comment.

>  	if (pdata != NULL) {
>  		speed = pdata->clkrate;
>  		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> +	} else if (pdev->dev.of_node) {
> +		const unsigned int *prop;
> +		prop = of_get_property(pdev->dev.of_node,
> +				"clock-frequency", NULL);
> +		if (prop)
> +			speed = be32_to_cpup(prop);
> +		else
> +			speed = 100;

There is a new function that makes this easier.  Do this instead:

	speed = 100;
	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency", &prop)
		speed = prop / 1000000; /* speed in Hz, this might be wrong */

> +		dev->set_mpu_wkup_lat = NULL;

dev is kzalloced, which means set_mpu_wkup_lat is already NULL.

>  	} else {
>  		speed = 100;	/* Default speed */
>  		dev->set_mpu_wkup_lat = NULL;
> @@ -1045,6 +1064,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
>  
> +

Drop the unrelated whitespace change.

>  	if (dev->rev <= OMAP_I2C_REV_ON_3430)
>  		dev->errata |= I2C_OMAP3_1P153;
>  
> @@ -1073,6 +1093,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  				       (1000 * speed / 8);
>  	}
>  
> +

Ditto.

>  	/* reset ASAP, clearing any IRQs */
>  	omap_i2c_init(dev);
>  
> @@ -1162,6 +1183,12 @@ static int omap_i2c_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static const struct of_device_id omap_i2c_of_match[] = {
> +	{.compatible = "ti,omap_i2c", },
> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> +

This needs to be protected with #ifdef CONFIG_OF/#else/#endif.  Don't
break non-dt builds.

>  static struct dev_pm_ops omap_i2c_pm_ops = {
>  	.suspend = omap_i2c_suspend,
>  	.resume = omap_i2c_resume,
> @@ -1178,6 +1205,7 @@ static struct platform_driver omap_i2c_driver = {
>  		.name	= "omap_i2c",
>  		.owner	= THIS_MODULE,
>  		.pm	= OMAP_I2C_PM_OPS,
> +		.of_match_table = omap_i2c_of_match,
>  	},
>  };
>  
> -- 
> 1.7.4.1
> 
