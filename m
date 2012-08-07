From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] backlight: Add TPS65217 WLED driver
Date: Tue, 7 Aug 2012 08:59:17 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA0D18A@DBDE01.ent.ti.com>
References: <20120731194838.GJ4701@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46285 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab2HGI7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 04:59:38 -0400
In-Reply-To: <20120731194838.GJ4701@darwin>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kaehlcke,

Can you re-submit the patch based on linux-next tree?

Comments inline

On Wed, Aug 01, 2012 at 01:18:38, Matthias Kaehlcke wrote:
> The TPS65217 chip contains a boost converter and current sinks which can be
> used to drive LEDs for use as backlights. Expose this functionality via the
> backlight API.

Can you provide more details here, like patch is based on which tree?
Testing details of the driver?

> 
> Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> ---
>  drivers/mfd/tps65217.c                |   71 +++++++++
>  drivers/video/backlight/Kconfig       |    7 +
>  drivers/video/backlight/Makefile      |    1 +
>  drivers/video/backlight/tps65217_bl.c |  272 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65217.h          |   19 +++
>  5 files changed, 370 insertions(+)
>  create mode 100644 drivers/video/backlight/tps65217_bl.c
> 
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 61c097a..c248bb3 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -29,6 +29,12 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/tps65217.h>
>  
> +#if defined(CONFIG_BACKLIGHT_TPS65217) || defined(CONFIG_BACKLIGHT_TPS65217_MODULE)
> +#define tps_has_bl() true
> +#else
> +#define tps_has_bl() false
> +#endif
> +

Is this really required?

>  /**
>   * tps65217_reg_read: Read a single tps65217 register.
>   *
> @@ -174,6 +180,47 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
>  		pdata->of_node[i] = reg_matches[i].of_node;
>  	}
>  
> +	if (tps_has_bl()) {
> +		struct device_node *np = of_find_node_by_name(node, "backlight");
> +		if (np) {

This can be changed to
np = of_find_node_by_name(node, "backlight");
if (np) {
}

else fall into non-backlight case.

> +			u32 val;
> +
> +			pdata->bl_pdata = devm_kzalloc(&client->dev, sizeof(*pdata->bl_pdata), GFP_KERNEL);
> +			if (!pdata->bl_pdata)
> +				return NULL;
> +
> +			if (!of_property_read_u32(np, "isel", &val)) {
> +				if (val == 1) {
> +					pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> +				} else if (val == 2) {
> +					pdata->bl_pdata->isel = TPS65217_BL_ISET2;
> +				} else {
> +					dev_err(&client->dev, "invalid value for backlight current limit selection in the device tree\n");

fix checkpatch.pl errors before submitting the patches. More than
80 ch.

> +					return NULL;

Should not return here, need to handle rest of dt portion.

> +				}
> +			} else {
> +				pdata->bl_pdata->isel = TPS65217_BL_ISET1;
> +			}

This can be changed to

pdata->bl_pdata->isel = TPS65217_BL_ISET1;
of_property_read_u32(np, "isel", &val)
if (val > TPS65217_BL_ISET2 || val < TPS65217_BL_ISET1) {
	dev_err(...);
	goto rest_dt_portion;
} else {
	pdata->bl_pdata->isel = val;
}

> +
> +			if (!of_property_read_u32(np, "fdim", &val)) {
> +				if (val == 100) {
> +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_100HZ;
> +				} else if (val == 200) {
> +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> +				} else if (val == 500) {
> +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_500HZ;
> +				} else if (val == 1000) {
> +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_1000HZ;
> +				} else {
> +					dev_err(&client->dev, "invalid value for backlight dimming frequency in the device tree\n");
> +					return NULL;
> +				}
> +			} else {
> +				pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> +			}
> +		}
> +	}

Same here.

> +
>  	return pdata;
>  }
>  
> @@ -250,7 +297,28 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  		platform_device_add(pdev);
>  	}
>  
> +	if (tps_has_bl() &&
> +			pdata->bl_pdata) {
> +		tps->bl_pdev = platform_device_alloc("tps65217-bl", 0);
> +		if (!tps->bl_pdev) {
> +			dev_err(tps->dev, "Cannot create backlight platform device\n");
> +			ret = -ENOMEM;
> +			goto err_alloc_bl_pdev;
> +		}
> +
> +		tps->bl_pdev->dev.parent = tps->dev;
> +		tps->bl_pdev->dev.platform_data = pdata->bl_pdata;
> +
> +		platform_device_add(tps->bl_pdev);
> +	}
> +
>  	return 0;
> +
> +err_alloc_bl_pdev:
> +	for (i = 0; i < TPS65217_NUM_REGULATOR; i++)
> +		platform_device_unregister(tps->regulator_pdev[i]);
> +
> +	return ret;
>  }
>  
>  static int __devexit tps65217_remove(struct i2c_client *client)
> @@ -258,6 +326,9 @@ static int __devexit tps65217_remove(struct i2c_client *client)
>  	struct tps65217 *tps = i2c_get_clientdata(client);
>  	int i;
>  
> +	if (tps->bl_pdev)
> +		platform_device_unregister(tps->bl_pdev);
> +
>  	for (i = 0; i < TPS65217_NUM_REGULATOR; i++)
>  		platform_device_unregister(tps->regulator_pdev[i]);
>  
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 2979292..6fb8bd7 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -373,6 +373,13 @@ config BACKLIGHT_PANDORA
>  	  If you have a Pandora console, say Y to enable the
>  	  backlight driver.
>  
> +config BACKLIGHT_TPS65217
> +	tristate "Backlight driver for TI TPS65217 using WLED"
> +	depends on BACKLIGHT_CLASS_DEVICE && MFD_TPS65217
> +	help
> +	  If you have a Texas Instruments TPS65217 say Y to enable the
> +	  backlight driver.
> +
>  endif # BACKLIGHT_CLASS_DEVICE
>  
>  endif # BACKLIGHT_LCD_SUPPORT
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index a2ac9cf..00223a6 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -43,3 +43,4 @@ obj-$(CONFIG_BACKLIGHT_88PM860X) += 88pm860x_bl.o
>  obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
>  obj-$(CONFIG_BACKLIGHT_AAT2870) += aat2870_bl.o
>  obj-$(CONFIG_BACKLIGHT_OT200) += ot200_bl.o
> +obj-$(CONFIG_BACKLIGHT_TPS65217) += tps65217_bl.o
> diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
> new file mode 100644
> index 0000000..ca26c61
> --- /dev/null
> +++ b/drivers/video/backlight/tps65217_bl.c
> @@ -0,0 +1,272 @@
> +/*
> + * tps65217_bl.c
> + *
> + * TPS65217 backlight driver
> + *
> + * Copyright (C) 2012 Matthias Kaehlcke
> + * Author: Matthias Kaehlcke <matthias@kaehlcke.net>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/backlight.h>
> +#include <linux/err.h>
> +#include <linux/fb.h>
> +#include <linux/mfd/tps65217.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct tps65217_bl
> +{
> +	struct tps65217 *tps;
> +	struct device *dev;
> +	struct backlight_device *bl;
> +	int on;
> +};
> +
> +struct tps65217_bl_pdata tps65217_bl_default_pdata = {
> +	.isel	= TPS65217_BL_ISET1,
> +	.fdim	= TPS65217_BL_FDIM_200HZ

Comma missed at the end, if some other parameters added to this
struct after some time then this line should be updated. Which is
not necessary if we take care now.

> +};
> +
> +static int tps65217_bl_enable(struct tps65217_bl *tps65217_bl)
> +{
> +	int rc;
> +
> +	rc = tps65217_set_bits(tps65217_bl->tps,
> +			TPS65217_REG_WLEDCTRL1,
> +			TPS65217_WLEDCTRL1_ISINK_ENABLE,
> +			TPS65217_WLEDCTRL1_ISINK_ENABLE,
> +			TPS65217_PROTECT_NONE);
> +	if (rc) {
> +		dev_err(tps65217_bl->dev,
> +			"failed to enable backlight: %d\n", rc);
> +		return rc;
> +	}
> +
> +	tps65217_bl->on = 1;
> +
> +	dev_dbg(tps65217_bl->dev, "backlight enabled\n");
> +
> +	return 0;
> +}
> +
> +static int tps65217_bl_disable(struct tps65217_bl *tps65217_bl)
> +{
> +	int rc;
> +
> +	rc = tps65217_clear_bits(tps65217_bl->tps,
> +				TPS65217_REG_WLEDCTRL1,
> +				TPS65217_WLEDCTRL1_ISINK_ENABLE,
> +				TPS65217_PROTECT_NONE);
> +	if (rc) {
> +		dev_err(tps65217_bl->dev,
> +			"failed to disable backlight: %d\n", rc);
> +		return rc;
> +	}
> +
> +	tps65217_bl->on = 0;
> +
> +	dev_dbg(tps65217_bl->dev, "backlight disabled\n");
> +
> +	return 0;
> +}
> +
> +static int tps65217_bl_update_status(struct backlight_device *bl)
> +{
> +	struct tps65217_bl *tps65217_bl = bl_get_data(bl);
> +	int rc;
> +	int brightness = bl->props.brightness;
> +
> +	if (bl->props.state & BL_CORE_SUSPENDED)
> +		brightness = 0;
> +
> +	if ((bl->props.power != FB_BLANK_UNBLANK) ||
> +		(bl->props.fb_blank != FB_BLANK_UNBLANK))
> +		/* framebuffer in low power mode or blanking active */
> +		brightness = 0;
> +
> +	if (brightness > 0) {
> +		rc = tps65217_reg_write(tps65217_bl->tps,
> +					TPS65217_REG_WLEDCTRL2,
> +					brightness - 1,
> +					TPS65217_PROTECT_NONE);
> +		if (rc) {
> +			dev_err(tps65217_bl->dev,
> +				"failed to set brightness level: %d\n", rc);
> +			return rc;
> +		}
> +
> +		dev_dbg(tps65217_bl->dev, "brightness set to %d\n", brightness);
> +
> +		if (!tps65217_bl->on)
> +			rc = tps65217_bl_enable(tps65217_bl);
> +	} else {
> +		rc = tps65217_bl_disable(tps65217_bl);
> +	}
> +
> +	return rc;
> +}
> +
> +static int tps65217_bl_get_brightness(struct backlight_device *bl)
> +{
> +	return bl->props.brightness;
> +}
> +
> +static const struct backlight_ops tps65217_bl_ops = {
> +	.options	= BL_CORE_SUSPENDRESUME,
> +	.update_status	= tps65217_bl_update_status,
> +	.get_brightness	= tps65217_bl_get_brightness
> +};
> +
> +static int tps65217_bl_hw_init(struct tps65217_bl *tps65217_bl, struct tps65217_bl_pdata *pdata)

Greater than 80 Chs

> +{
> +	int rc;
> +
> +	rc = tps65217_bl_disable(tps65217_bl);
> +	if (rc)
> +		return rc;
> +
> +	if (pdata->isel == TPS65217_BL_ISET1) {
> +		/* select ISET_1 current level */
> +		rc = tps65217_clear_bits(tps65217_bl->tps,
> +					TPS65217_REG_WLEDCTRL1,
> +					TPS65217_WLEDCTRL1_ISEL,
> +					TPS65217_PROTECT_NONE);
> +		if (rc) {
> +			dev_err(tps65217_bl->dev,
> +				"failed to select ISET1 current level: %d)\n", rc);
> +			return rc;
> +		}
> +
> +		dev_dbg(tps65217_bl->dev, "selected ISET1 current level\n");
> +	} else {
> +		/* select ISET2 current level */
> +		rc = tps65217_set_bits(tps65217_bl->tps,
> +				TPS65217_REG_WLEDCTRL1,
> +				TPS65217_WLEDCTRL1_ISEL,
> +				TPS65217_WLEDCTRL1_ISEL,
> +				TPS65217_PROTECT_NONE);

Can reduce number of lines and should not exceed 80 ch. Same can be done
at other places.

> +		if (rc) {
> +			dev_err(tps65217_bl->dev,
> +				"failed to select ISET2 current level: %d\n", rc);
> +			return rc;
> +		}
> +
> +		dev_dbg(tps65217_bl->dev, "selected ISET2 current level\n");
> +	}

Switch gives better readability.

> +
> +	/* set PWM frequency */
> +	rc = tps65217_set_bits(tps65217_bl->tps,
> +			TPS65217_REG_WLEDCTRL1,
> +			TPS65217_WLEDCTRL1_FDIM_MASK,
> +			pdata->fdim,
> +			TPS65217_PROTECT_NONE);
> +	if (rc) {
> +		dev_err(tps65217_bl->dev,
> +				"failed to select PWM dimming frequency: %d\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65217_bl_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct i2c_client *i2c_client = to_i2c_client(pdev->dev.parent);
> +	struct tps65217 *tps = i2c_get_clientdata(i2c_client);
> +	struct tps65217_bl *tps65217_bl;
> +	struct tps65217_bl_pdata *pdata;
> +	struct backlight_properties bl_props;
> +
> +	tps65217_bl = kzalloc(GFP_KERNEL, sizeof(*tps65217_bl));
> +	if (tps65217_bl == NULL) {
> +		dev_err(&pdev->dev, "allocation of struct tps65217_bl failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	tps65217_bl->tps = tps;
> +	tps65217_bl->dev = &pdev->dev;
> +	tps65217_bl->on = 0;
> +

DT handling for backlight should be done here.

> +	if (pdev->dev.platform_data)
> +		pdata = pdev->dev.platform_data;
> +	else
> +		pdata = &tps65217_bl_default_pdata;
> +
> +	rc = tps65217_bl_hw_init(tps65217_bl, pdata);
> +	if (rc)
> +		goto err_bl_hw_init;
> +
> +	memset(&bl_props, 0, sizeof(struct backlight_properties));
> +	bl_props.type = BACKLIGHT_RAW;
> +	bl_props.max_brightness = 100;
> +
> +	tps65217_bl->bl = backlight_device_register(pdev->name,
> +						tps65217_bl->dev,
> +						tps65217_bl,
> +						&tps65217_bl_ops,
> +						&bl_props);
> +	if (IS_ERR(tps65217_bl->bl)) {
> +		rc = PTR_ERR(tps65217_bl->bl);
> +		dev_err(tps65217_bl->dev, "registration of backlight device failed: %d\n", rc);
> +		goto err_reg_bl;
> +	}
> +
> +	tps65217_bl->bl->props.brightness = 0;
> +
> +	return 0;
> +
> +err_reg_bl:
> +err_bl_hw_init:
> +	kfree(tps65217_bl);
> +
> +	return rc;
> +}
> +
> +static int tps65217_bl_remove(struct platform_device *pdev)
> +{
> +	struct tps65217_bl *tps65217_bl = (struct tps65217_bl *)platform_get_drvdata(pdev);

type cast is not required.

> +
> +	backlight_device_unregister(tps65217_bl->bl);
> +
> +	kfree(tps65217_bl);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tps65217_bl_driver = {
> +	.probe		= tps65217_bl_probe,
> +	.remove		= tps65217_bl_remove,
> +	.driver		= {
> +		.owner	= THIS_MODULE,
> +		.name	= "tps65217-bl",
> +	},
> +};
> +
> +static int __init tps65217_bl_init(void)
> +{
> +	return platform_driver_register(&tps65217_bl_driver);
> +}
> +
> +static void __exit tps65217_bl_exit(void)
> +{
> +	platform_driver_unregister(&tps65217_bl_driver);
> +}
> +
> +module_init(tps65217_bl_init);
> +module_exit(tps65217_bl_exit);
> +
> +MODULE_DESCRIPTION("TPS65217 Backlight driver");
> +MODULE_LICENSE("GPL");

GPLv2

Regards
AnilKumar
