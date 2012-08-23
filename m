From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v3] backlight: Add TPS65217 WLED driver
Date: Thu, 23 Aug 2012 07:53:49 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA1E90E@DBDE01.ent.ti.com>
References: <20120822210419.GA6235@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab2HWHyG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Aug 2012 03:54:06 -0400
In-Reply-To: <20120822210419.GA6235@darwin>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kaehlcke,

On Thu, Aug 23, 2012 at 02:34:19, Matthias Kaehlcke wrote:
> The TPS65217 chip contains a boost converter and current sinks which can be
> used to drive LEDs for use as backlights. Expose this functionality via the
> backlight API.
> 
> Tested on an AM335x based custom board with a single WLED string, using
> different values for ISEL and FDIM (though it would be hard to tell the
> difference except for the value in WLEDCTRL1). Both instantiation through the
> device tree and by passing platform data have been tested. Testing has been
> done with an Androidized 3.2 kernel from the rowboat project
> 
> This patch is based on the mfd/for-next branch (20120822)
> 
> Changes since v2:
> 
>  * adapted to the latest version of the tps65217 mfd driver
>  * register backlight as mfd subdevice
>  * allocate struct tps65217_bl after validation of the device tree/platform data

This patch should divide into 2 patches, one patch meant for
MFD changes other for backlight.

> 
> Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> ---
>  drivers/mfd/tps65217.c                |    3 +
>  drivers/video/backlight/Kconfig       |    7 +
>  drivers/video/backlight/Makefile      |    1 +
>  drivers/video/backlight/tps65217_bl.c |  352 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65217.h          |   18 ++
>  5 files changed, 381 insertions(+)
>  create mode 100644 drivers/video/backlight/tps65217_bl.c
> 
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 3bc2744..592059e 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -34,6 +34,9 @@ static struct mfd_cell tps65217s[] = {
>  	{
>  		.name = "tps65217-pmic",
>  	},
> +	{
> +		.name = "tps65217-bl",
> +	},
>  };
>  
>  /**
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index cf28276..63cee2e 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -373,6 +373,13 @@ config BACKLIGHT_PANDORA
>  	  If you have a Pandora console, say Y to enable the
>  	  backlight driver.
>  
> +config BACKLIGHT_TPS65217
> +	tristate "TPS65217 Backlight"
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
> index 0000000..5842d5f
> --- /dev/null
> +++ b/drivers/video/backlight/tps65217_bl.c
> @@ -0,0 +1,352 @@
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
> +struct tps65217_bl {
> +	struct tps65217 *tps;
> +	struct device *dev;
> +	struct backlight_device *bl;
> +	int on;

Can you use Boolean here? Change the name as well, something
like bool is_enabled?

> +};
> +
> +static int tps65217_bl_enable(struct tps65217_bl *tps65217_bl)
> +{
> +	int rc;
> +
> +	rc = tps65217_set_bits(tps65217_bl->tps, TPS65217_REG_WLEDCTRL1,
> +			TPS65217_WLEDCTRL1_ISINK_ENABLE,
> +			TPS65217_WLEDCTRL1_ISINK_ENABLE, TPS65217_PROTECT_NONE);
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
> +static int tps65217_bl_hw_init(struct tps65217_bl *tps65217_bl,
> +			struct tps65217_bl_pdata *pdata)
> +{
> +	int rc;
> +
> +	rc = tps65217_bl_disable(tps65217_bl);
> +	if (rc)
> +		return rc;
> +
> +	switch (pdata->isel) {
> +	case TPS65217_BL_ISET1:
> +		/* select ISET_1 current level */
> +		rc = tps65217_clear_bits(tps65217_bl->tps,
> +					TPS65217_REG_WLEDCTRL1,
> +					TPS65217_WLEDCTRL1_ISEL,
> +					TPS65217_PROTECT_NONE);
> +		if (rc) {
> +			dev_err(tps65217_bl->dev,
> +				"failed to select ISET1 current level: %d)\n",
> +				rc);
> +			return rc;
> +		}
> +
> +		dev_dbg(tps65217_bl->dev, "selected ISET1 current level\n");
> +
> +		break;
> +
> +	case TPS65217_BL_ISET2:
> +		/* select ISET2 current level */
> +		rc = tps65217_set_bits(tps65217_bl->tps, TPS65217_REG_WLEDCTRL1,
> +				TPS65217_WLEDCTRL1_ISEL,
> +				TPS65217_WLEDCTRL1_ISEL, TPS65217_PROTECT_NONE);
> +		if (rc) {
> +			dev_err(tps65217_bl->dev,
> +				"failed to select ISET2 current level: %d\n",
> +				rc);
> +			return rc;
> +		}
> +
> +		dev_dbg(tps65217_bl->dev, "selected ISET2 current level\n");
> +
> +		break;
> +
> +	default:
> +		dev_err(tps65217_bl->dev,
> +			"invalid value for current level: %d\n", pdata->isel);
> +		return -EINVAL;
> +	}
> +
> +	/* set PWM frequency */
> +	rc = tps65217_set_bits(tps65217_bl->tps,
> +			TPS65217_REG_WLEDCTRL1,
> +			TPS65217_WLEDCTRL1_FDIM_MASK,
> +			pdata->fdim,
> +			TPS65217_PROTECT_NONE);
> +	if (rc) {
> +		dev_err(tps65217_bl->dev,
> +			"failed to select PWM dimming frequency: %d\n",
> +			rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static struct tps65217_bl_pdata *
> +tps65217_bl_parse_dt(struct platform_device *pdev)
> +{
> +	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *node = of_node_get(tps->dev->of_node);
> +	struct tps65217_bl_pdata *pdata, *err;
> +	u32 val;
> +
> +	node = of_find_node_by_name(node, "backlight");
> +	if (!node)
> +		return ERR_PTR(-ENODEV);
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "failed to allocate platform data\n");
> +		err = ERR_PTR(-ENOMEM);
> +		goto err;
> +	}
> +
> +	pdata->isel = TPS65217_BL_ISET1;
> +	if (!of_property_read_u32(node, "isel", &val)) {
> +		if (val < TPS65217_BL_ISET1 ||
> +			val > TPS65217_BL_ISET2) {
> +			dev_err(&pdev->dev,
> +				"invalid 'isel' value in the device tree\n");
> +			err = ERR_PTR(-EINVAL);
> +			goto err;
> +		}
> +
> +		pdata->isel = val;
> +	}
> +
> +	pdata->fdim = TPS65217_BL_FDIM_200HZ;

Why 200 by default?

Regards
AnilKumar
