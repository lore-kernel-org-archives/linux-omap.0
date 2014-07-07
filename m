From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3
 HC
Date: Mon, 7 Jul 2014 13:46:27 +0100
Message-ID: <20140707124627.GG6407@lee--X1>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404541530-27856-2-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, 05 Jul 2014, Peter Griffin wrote:

> This patch adds the ST glue logic to manage the DWC3 HC
> on STiH407 SoC family. It manages the powerdown signal,
> and configures the internal glue logic and syscfg registers.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/usb/dwc3/Kconfig   |   9 ++
>  drivers/usb/dwc3/Makefile  |   1 +
>  drivers/usb/dwc3/dwc3-st.c | 325 +++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 335 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-st.c
>=20
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 8eb996e..6c85c43 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -79,6 +79,15 @@ config USB_DWC3_KEYSTONE
>  	  Support of USB2/3 functionality in TI Keystone2 platforms.
>  	  Say 'Y' or 'M' here if you have one such device
> =20
> +config USB_DWC3_ST
> +	tristate "STMicroelectronics Platforms"
> +	depends on ARCH_STI && OF
> +	default USB_DWC3_HOST
> +	help
> +	  STMicroelectronics SoCs with one DesignWare Core USB3 IP
> +	  inside (i.e. STiH407).
> +	  Say 'Y' or 'M' if you have one such device.
> +
>  comment "Debugging features"
> =20
>  config USB_DWC3_DEBUG
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index 10ac3e7..11c9f54 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_USB_DWC3_OMAP)		+=3D dwc3-omap.o
>  obj-$(CONFIG_USB_DWC3_EXYNOS)		+=3D dwc3-exynos.o
>  obj-$(CONFIG_USB_DWC3_PCI)		+=3D dwc3-pci.o
>  obj-$(CONFIG_USB_DWC3_KEYSTONE)		+=3D dwc3-keystone.o
> +obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> new file mode 100644
> index 0000000..2cae9d3
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -0,0 +1,325 @@
> +/**
> + * dwc3-st.c Support for dwc3 platform devices on ST Microelectronic=
s platforms
> + *
> + * This is a small platform driver for the dwc3 to provide the glue =
logic
> + * to configure the controller. Tested on STi platforms.

Not sure about the use of the term 'platform driver' here and in the
title.  We don't normally differentiate.  I can find examples to the
contrary, but not many.

> + * Copyright (C) 2014 Stmicroelectronics
> + *
> + * Author: Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
> + * Contributors: Aymen Bouattay <aymen.bouattay-qxv4g6HH51o@public.gmane.org>
> + *               Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * Inspired by dwc3-omap.c and dwc3-exynos.c.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include "core.h"
> +#include "io.h"
> +
> +/* Reg glue registers */
> +#define USB2_CLKRST_CTRL 0x00
> +#define aux_clk_en(n) ((n)<<0)
> +#define sw_pipew_reset_n(n) ((n)<<4)
> +#define ext_cfg_reset_n(n) ((n)<<8)
> +#define xhci_revision(n) ((n)<<12)

These all need reformatting, see CodingStyle - 3.1: Spaces

  #define xhci_revision(n)     ((n) << 12)

Lining them up with TABs would make them easier to read.

Also, I don't think there is a requirement to encapsulate the 'n'.

> +#define USB2_VBUS_MNGMNT_SEL1 0x2C
> +/*
> + * 2'b00 : Override value from Reg 0x30 is selected
> + * 2'b01 : utmiotg_vbusvalid from usb3_top top is selected
> + * 2'b10 : pipew_powerpresent from PIPEW instance is selected
> + * 2'b11 : value is 1'b0
> + */

What is this documenting?  Isn't documentation meant to make things
clearer?  Now I'm just really confused - by the documentation.

> +#define SEL_OVERRIDE_VBUSVALID(n) ((n)<<0)
> +#define SEL_OVERRIDE_POWERPRESENT(n) ((n)<<4)
> +#define SEL_OVERRIDE_BVALID(n) ((n)<<8)
> +
> +#define USB2_VBUS_MNGMNT_VAL1 0x30
> +#define OVERRIDE_VBUSVALID_VAL (1 << 0)
> +#define OVERRIDE_POWERPRESENT_VAL (1 << 4)
> +#define OVERRIDE_BVALID_VAL (1 << 8)

Use BIT() for all of these bit setting macros.

> +/* Static DRD configuration */
> +#define USB_HOST_DEFAULT_MASK	0xffe
> +#define USB_SET_PORT_DEVICE	0x1
> +
> +struct st_dwc3 {
> +	struct platform_device *dwc3;	/* platform device pointer */
> +	struct device *dev;	/* device pointer */
> +	void __iomem *glue_base;	/* ioaddr for programming the glue */
> +	struct regmap *regmap;	/* regmap for getting syscfg */
> +	int syscfg_reg_off;	/* usb syscfg control offset */
> +	bool drd_device_conf;	/* DRD static host/device conf */
> +	struct reset_control *rstc_pwrdn;/* Rst control for powerdown*/
> +};

This is a mess.  Use kerneldoc formatting instead.

> +static inline u32 st_dwc3_readl(void __iomem *base, u32 offset)
> +{
> +	return readl_relaxed(base + offset);
> +}
> +
> +static inline void st_dwc3_writel(void __iomem *base, u32 offset, u3=
2 value)
> +{
> +	writel_relaxed(value, base + offset);
> +}

Why are these being abstracted?

Just use {read,write}l_relaxed() directly.

> +/**
> + * st_dwc3_drd_init: program the port
> + * @dwc3_data: driver private structure
> + * Description: this function is to program the port as either host =
or device
> + * according to the static configuration passed from devicetree.
> + * OTG and dual role are not yet supported!
> + */
> +static int st_dwc3_drd_init(struct st_dwc3 *dwc3_data)
> +{
> +	u32 val;
> +
> +	regmap_read(dwc3_data->regmap, dwc3_data->syscfg_reg_off, &val);

Shouldn't you be checking the return value of regmap_read()?

> +	if (dwc3_data->drd_device_conf)
> +		val |=3D USB_SET_PORT_DEVICE;
> +	else
> +		val &=3D USB_HOST_DEFAULT_MASK;
> +
> +	return regmap_write(dwc3_data->regmap, dwc3_data->syscfg_reg_off, v=
al);
> +}
> +
> +/**
> + * st_dwc3_init: init the controller via glue logic
> + * @dwc3_data: driver private structure
> + */
> +static void st_dwc3_init(struct st_dwc3 *dwc3_data)
> +{
> +	u32 reg =3D st_dwc3_readl(dwc3_data->glue_base, USB2_CLKRST_CTRL);
> +
> +	reg |=3D aux_clk_en(1) | ext_cfg_reset_n(1) | xhci_revision(1);
> +	reg &=3D ~sw_pipew_reset_n(1);

1?  Better to add defines for these magic numbers.  What is 1 anyway?
Port one?  If so, shouldn't this function be called
st_dwc2_init_port_one(), or similar?

> +	st_dwc3_writel(dwc3_data->glue_base, USB2_CLKRST_CTRL, reg);
> +
> +	reg =3D st_dwc3_readl(dwc3_data->glue_base, USB2_VBUS_MNGMNT_SEL1);
> +	reg |=3D SEL_OVERRIDE_VBUSVALID(1) | SEL_OVERRIDE_POWERPRESENT(1) |
> +	    SEL_OVERRIDE_BVALID(1);
> +	st_dwc3_writel(dwc3_data->glue_base, USB2_VBUS_MNGMNT_SEL1, reg);
> +	udelay(100);

Why 100?

> +	reg =3D st_dwc3_readl(dwc3_data->glue_base, USB2_CLKRST_CTRL);
> +	reg |=3D sw_pipew_reset_n(1);
> +	st_dwc3_writel(dwc3_data->glue_base, USB2_CLKRST_CTRL, reg);
> +}
> +
> +static void st_dwc3_dt_get_pdata(struct platform_device *pdev,
> +				 struct st_dwc3 *dwc3_data)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +
> +	dwc3_data->drd_device_conf =3D
> +	    of_property_read_bool(np, "st,dwc3-drd-device");

This requires a DT Ack.

> +}
> +
> +/**
> + * st_dwc3_probe: main probe function
> + * @pdev: platform_device
> + * Description: this is the probe function that gets all the resourc=
es to manage
> + * the glue-logic, setup the controller and take out of powerdown.
> + */

I've never seen .probe() documented before?  I think you can safely
remove this kerneldoc header.

> +static int st_dwc3_probe(struct platform_device *pdev)
> +{
> +	struct platform_device *dwc3;
> +	struct st_dwc3 *dwc3_data;
> +	struct resource *res;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct regmap *regmap;
> +	int ret =3D 0;

No need to initialise.

> +	if (!node) {
> +		dev_err(dev, "device node not found\n");
> +		return -EINVAL;
> +	}

Remove this and make the driver depend on OF.

> +	dwc3_data =3D devm_kzalloc(dev, sizeof(*dwc3_data), GFP_KERNEL);
> +	if (!dwc3_data)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg-glu=
e");
> +	if (!res)
> +		return -ENXIO;

No need to check res here, devm_request_and_ioremap() does it for you.

> +	dwc3_data->glue_base =3D devm_request_and_ioremap(dev, res);
> +	if (!dwc3_data->glue_base)
> +		return -EADDRNOTAVAIL;

What?  Better to return the value from devm_request_and_ioremap() than
make up your own.

> +	regmap =3D syscon_regmap_lookup_by_phandle(node, "st,syscfg");
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	dwc3 =3D platform_device_alloc("st-dwc3", PLATFORM_DEVID_AUTO);
> +	if (!dwc3) {
> +		dev_err(&pdev->dev, "couldn't allocate dwc3 device\n");
> +		return -ENOMEM;
> +	}

I'm confused.  What is this doing?  Isn't this the DWC3 driver, which
already had a platform device structure associated to it?  Perhaps a
small ASCII diagram describing the layers might be useful.

> +	dma_set_coherent_mask(&dwc3->dev, dev->coherent_dma_mask);
> +
> +	dwc3->dev.parent =3D &pdev->dev;
> +	dwc3->dev.dma_mask =3D pdev->dev.dma_mask;
> +	dwc3->dev.dma_parms =3D pdev->dev.dma_parms;
> +
> +	dwc3_data->dwc3 =3D dwc3;
> +	dwc3_data->dev =3D &pdev->dev;

We're saving this twice, it's already available in dwc3, which we just
saved.

> +	dwc3_data->regmap =3D regmap;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-=
reg");
> +	if (!res) {
> +		ret =3D -ENXIO;
> +		goto undo_platform_dev_alloc;
> +	}
> +
> +	dwc3_data->syscfg_reg_off =3D res->start;
> +
> +	dev_info(&pdev->dev, "glue-logic addr 0x%p, syscfg-reg offset 0x%x\=
n",
> +		 dwc3_data->glue_base, dwc3_data->syscfg_reg_off);

I think this should be removed.  At the very least downgraded to
dev_dbg().

> +	dwc3_data->rstc_pwrdn =3D devm_reset_control_get(dwc3_data->dev, NU=
LL);
> +	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
> +		dev_err(&pdev->dev, "could not get reset controller\n");
> +		ret =3D PTR_ERR(dwc3_data->rstc_pwrdn);
> +		goto undo_platform_dev_alloc;
> +	}
> +
> +	/* Manage PowerDown */
> +	reset_control_deassert(dwc3_data->rstc_pwrdn);
> +
> +	st_dwc3_dt_get_pdata(pdev, dwc3_data);

As there is only one line in this function and this driver is DT only,
I would bring that line directly into .probe().

> +	/* Allocate and initialize the core */
> +	ret =3D of_platform_populate(node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to add dwc3 core\n");
> +		goto undo_powerdown;
> +	}
> +
> +	/*
> +	 * Configure the USB port as device or host according to the static
> +	 * configuration passed from the platform.
> +	 * DRD is the only mode currently supported so this will be enhance=
d
> +	 * later as soon as OTG will be available.
> +	 */
> +	ret =3D st_dwc3_drd_init(dwc3_data);
> +	if (ret) {
> +		dev_err(dev, "st_dwc3_drd_init failed\n");

I wouldn't have names of functions in the kernel log.

Swap out for something like "initialisation failed\n"

> +		goto undo_powerdown;
> +	}
> +
> +	dev_info(&pdev->dev, "configured as %s DRD\n",
> +		 dwc3_data->drd_device_conf ? "device" : "host");
> +
> +	/* ST glue logic init */
> +	st_dwc3_init(dwc3_data);

Can this fail?

> +	ret =3D platform_device_add_resources(dwc3_data->dwc3, pdev->resour=
ce,
> +					    pdev->num_resources);
> +	if (ret) {
> +		dev_err(&pdev->dev, "couldn't add resources to dwc3 device\n");
> +		goto undo_powerdown;
> +	}
> +
> +	ret =3D platform_device_add(dwc3_data->dwc3);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register dwc3 device\n");
> +		goto undo_powerdown;
> +	}
> +
> +	platform_set_drvdata(pdev, dwc3_data);
> +
> +	return 0;
> +
> +undo_powerdown:
> +	reset_control_assert(dwc3_data->rstc_pwrdn);
> +undo_platform_dev_alloc:
> +	platform_device_put(pdev);
> +
> +	return ret;
> +

Remove the '\n' here.

> +}
> +
> +static int st_dwc3_remove(struct platform_device *pdev)
> +{
> +	struct st_dwc3 *dwc3_data =3D platform_get_drvdata(pdev);
> +
> +	platform_device_unregister(dwc3_data->dwc3);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int st_dwc3_suspend(struct device *dev)
> +{
> +	struct st_dwc3 *dwc3_data =3D dev_get_drvdata(dev);
> +
> +	reset_control_assert(dwc3_data->rstc_pwrdn);
> +
> +	pinctrl_pm_select_sleep_state(dev);
> +
> +	return 0;
> +}
> +
> +static int st_dwc3_resume(struct device *dev)
> +{
> +	struct st_dwc3 *dwc3_data =3D dev_get_drvdata(dev);
> +
> +	pinctrl_pm_select_default_state(dev);
> +
> +	reset_control_deassert(dwc3_data->rstc_pwrdn);
> +
> +	return 0;
> +}
> +

Remove the '\n' here.

> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops st_dwc3_dev_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(st_dwc3_suspend, st_dwc3_resume)
> +};

Use SIMPLE_DEV_PM_OPS().

> +static struct of_device_id st_dwc3_match[] =3D {
> +	{ .compatible =3D "st,stih407-dwc3" },
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, st_dwc3_match);
> +
> +static struct platform_driver st_dwc3_driver =3D {
> +	.probe =3D st_dwc3_probe,
> +	.remove =3D st_dwc3_remove,
> +	.driver =3D {
> +		.name =3D "usb-st-dwc3",
> +		.owner =3D THIS_MODULE,

This is done for you elese where, you can remove.

> +		.of_match_table =3D of_match_ptr(st_dwc3_match),
> +		.pm =3D &st_dwc3_dev_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(st_dwc3_driver);
> +
> +MODULE_AUTHOR("Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>");
> +MODULE_DESCRIPTION("DesignWare USB3 STi Glue Layer");
> +MODULE_LICENSE("GPL v2");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
