From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [v3 PATCH 1/6] drivers: reset: TI: SoC reset controller
 support.
Date: Fri, 18 Jul 2014 08:41:11 +0200
Message-ID: <20140718084111.161e6fbd@ipc1.ka-ro>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:56176 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbaGRGlV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2014 02:41:21 -0400
In-Reply-To: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com

Hi,

Dan Murphy wrote:
> The TI SoC reset controller support utilizes the
> reset controller framework to give device drivers or
> function drivers a common set of APIs to call to reset
> a module.
>=20
> The reset-ti is a common interface to the reset framework.
>  The register data is retrieved during initialization
>  of the reset driver through the reset-ti-data
> file.  The array of data is associated with the compatible from the
> respective DT entry.
>=20
> Once the data is available then this is derefenced within the common
> interface.
>=20
> The device driver has the ability to assert, deassert or perform a
> complete reset.
>=20
> This code was derived from previous work by Rajendra Nayak and Afzal =
Mohammed.
> The code was changed to adopt to the reset core and abstract away the=
 SoC information.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>=20
> v3 - Resolved comments from v2.  To many to call out here - https://p=
atchwork.kernel.org/patch/4116941/
>=20
>  drivers/reset/Kconfig    |    9 ++
>  drivers/reset/Makefile   |    1 +
>  drivers/reset/reset-ti.c |  373 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 383 insertions(+)
>  create mode 100644 drivers/reset/reset-ti.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 0615f50..31a5a79 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -12,4 +12,13 @@ menuconfig RESET_CONTROLLER
> =20
>  	  If unsure, say no.
> =20
> +config RESET_TI
> +	depends on RESET_CONTROLLER && ARCH_OMAP || COMPILE_TEST
> +	bool "TI reset controller"
> +	help
> +	  Reset controller support for TI SoC's
> +
> +	  Reset controller found in TI's AM series of SoC's like
> +	  AM335x and AM43x and OMAP SoC's like OMAP5 and DRA7
> +
>  source "drivers/reset/sti/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 60fed3d..a5986b9 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_RESET_CONTROLLER) +=3D core.o
>  obj-$(CONFIG_ARCH_SOCFPGA) +=3D reset-socfpga.o
>  obj-$(CONFIG_ARCH_SUNXI) +=3D reset-sunxi.o
> +obj-$(CONFIG_RESET_TI) +=3D reset-ti.o
>  obj-$(CONFIG_ARCH_STI) +=3D sti/
> diff --git a/drivers/reset/reset-ti.c b/drivers/reset/reset-ti.c
> new file mode 100644
> index 0000000..e9d4039
> --- /dev/null
> +++ b/drivers/reset/reset-ti.c
> @@ -0,0 +1,373 @@
> +/*
> + * reset-ti.c - PRCM reset driver for TI SoC's
> + *
> + * Copyright (C) 2014 Texas Instruments Incorporated -  http://www.t=
i.com
> + *
> + * Author: Dan Murphy <dmurphy@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define DRIVER_NAME "prcm_reset_ti"
> +#define MAX_RESET_SIGNALS 255
> +
> +/**
> + * struct ti_reset_reg_data - Structure of the reset register inform=
ation
> + *		for a particular SoC.
> + * @rstctrl_offs: This is the reset control offset value from
> + *		from the parent reset node.
> + * @rstst_offs: This is the reset status offset value from
> + *		from the parent reset node.
> + * @rstctrl_bit: This is the reset control bit for the module.
> + * @rstst_bit: This is the reset status bit for the module.
> + *
> + * Longer description of this structure.
> + */
> +struct ti_reset_reg_data {
> +	phandle handle;
> +	u32	rstctrl_offs;
> +	u32	rstst_offs;
> +	u32	rstctrl_bit;
> +	u32	rstst_bit;
> +};
> +
> +/**
> + * struct ti_reset_data - Structure that contains the reset register=
 data
> + *	as well as the total number of resets for a particular SoC.
> + * @ti_data:	Pointer to this structure to be dereferenced
> + * @reg_data:	Pointer to the register data structure.
> + * @rcdev:		Reset controller device instance
> + * @dev:		Pointer to the devive structure
> + * @ti_reg_data: Array of register data.  Only reset signal with val=
id
> + *				phandles will be stored in this array.
> + * @reg_base:	Parent register base address
> + * @lock:		Spinlock for accessing the registers
> + * @nr_resets:	Total number of resets for the SoC in the reset array=
=2E
> + *
> + * This structure contains a pointer to the register data and the mo=
dules
> + * register base.  The number of resets and reset controller device =
data is
> + * stored within this structure.
> + *
> + */
> +struct ti_reset_data {
> +	struct ti_reset_data *ti_data;
> +	struct ti_reset_reg_data *reg_data;
> +	struct reset_controller_dev rcdev;
> +	struct device *dev;
> +	struct ti_reset_reg_data ti_reg_data[MAX_RESET_SIGNALS];
> +	void __iomem *reg_base;
> +	spinlock_t lock;
> +	int nr_resets;
> +};
> +
> +static int ti_reset_wait_on_reset(struct reset_controller_dev *rcdev=
,
> +				unsigned long id)
> +{
> +	struct ti_reset_data *reset_data =3D container_of(rcdev,
> +						     struct ti_reset_data,
> +						     rcdev);
> +	void __iomem *status_reg =3D reset_data->reg_base;
> +	u32 bit_mask =3D 0;
> +	u32 val =3D 0;
> +	unsigned long flags;
> +	int i =3D 1000;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&reset_data->lock, flags);
> +	/* Clear the reset status bit to reflect the current status */
> +	status_reg =3D reset_data->reg_base + reset_data->ti_reg_data[id].r=
stst_offs;
> +	bit_mask =3D reset_data->ti_reg_data[id].rstst_bit;
> +
> +	do {
> +		val =3D readl(status_reg);
> +	} while (--i && (val & (1 << bit_mask)));
> +
Is there no better way to detect timeout than counting down from some
magic number? Does the reference manual give any hints about how fast
the reset should be completed, so the timeout can be hinged on some
real microseconds rather than a number of CPU loops?

> +	if (i =3D=3D 0 && val & (1 << bit_mask)) {
> +		dev_err(reset_data->dev, "%s: Reset failed\n", __func__);
> +		ret =3D -EIO;
> +	}
> +
> +	spin_unlock_irqrestore(&reset_data->lock, flags);
> +	return ret;
> +}
> +
> +static int ti_reset_assert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct ti_reset_data *reset_data =3D container_of(rcdev,
> +						     struct ti_reset_data,
> +						     rcdev);
> +	void __iomem *reg;
> +	void __iomem *status_reg;
> +	u32 status_bit =3D 0;
> +	u32 bit_mask =3D 0;
> +	u32 val =3D 0;
>
Useless initialization!

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&reset_data->lock, flags);
> +
> +	/* Clear the reset status bit to reflect the current status */
> +	status_reg =3D reset_data->reg_base + reset_data->ti_reg_data[id].r=
stst_offs;
> +	status_bit =3D reset_data->ti_reg_data[id].rstst_bit;
> +	writel(1 << status_bit, status_reg);
> +
> +	reg =3D reset_data->reg_base + reset_data->ti_reg_data[id].rstctrl_=
offs;
> +	bit_mask =3D reset_data->ti_reg_data[id].rstctrl_bit;
> +	val =3D readl(reg);
> +	if (!(val & bit_mask)) {
> +		val |=3D bit_mask;
> +		writel(val, reg);
> +	}
> +
> +	spin_unlock_irqrestore(&reset_data->lock, flags);
> +	return 0;
> +}
> +
> +static int ti_reset_deassert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +
> +	struct ti_reset_data *reset_data =3D container_of(rcdev,
> +						     struct ti_reset_data,
> +						     rcdev);
> +	void __iomem *reg;
> +	void __iomem *status_reg;
> +	u32 status_bit =3D 0;
> +	u32 bit_mask =3D 0;
> +	u32 val =3D 0;
>
dto.

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&reset_data->lock, flags);
> +
> +	/* Clear the reset status bit to reflect the current status */
> +	status_reg =3D reset_data->reg_base + reset_data->ti_reg_data[id].r=
stst_offs;
> +	status_bit =3D reset_data->ti_reg_data[id].rstst_bit;
> +	writel(1 << status_bit, status_reg);
> +
> +	reg =3D reset_data->reg_base + reset_data->ti_reg_data[id].rstctrl_=
offs;
> +	bit_mask =3D reset_data->ti_reg_data[id].rstctrl_bit;
> +	val =3D readl(reg);
> +	if (val & bit_mask) {
> +		val &=3D ~bit_mask;
> +		writel(val, reg);
> +	}
> +
> +	spin_unlock_irqrestore(&reset_data->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int ti_reset_reset(struct reset_controller_dev *rcdev,
> +			  unsigned long id)
> +{
> +	ti_reset_assert(rcdev, id);
> +	ti_reset_deassert(rcdev, id);
> +
> +	return ti_reset_wait_on_reset(rcdev, id);
> +}
> +
> +static int ti_reset_xlate(struct reset_controller_dev *rcdev,
> +			const struct of_phandle_args *reset_spec)
> +{
> +
> +	struct ti_reset_data *reset_data =3D container_of(rcdev,
> +						     struct ti_reset_data,
> +						     rcdev);
> +	struct device_node *dev_node;
> +	int i;
> +
> +	if (WARN_ON(reset_spec->args_count !=3D rcdev->of_reset_n_cells))
> +		return -EINVAL;
> +
> +	/* Verify that the phandle exists */
> +	dev_node =3D of_find_node_by_phandle((phandle) reset_spec->args[0])=
;
> +	if (!dev_node) {
> +		dev_err(reset_data->dev,
> +				"%s: Cannot find phandle node\n",
> +				__func__);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i <=3D reset_data->nr_resets; i++) {
> +		if (reset_data->ti_reg_data[i].handle =3D=3D dev_node->phandle)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static struct reset_control_ops ti_reset_ops =3D {
> +	.reset =3D ti_reset_reset,
> +	.assert =3D ti_reset_assert,
> +	.deassert =3D ti_reset_deassert,
> +};
> +
> +static int ti_reset_populate_child(struct ti_reset_data *reset_data,
> +					struct device_node *reset_child,
> +					u32 ctrl_offs, u32 status_offs)
> +{
> +	struct device_node *next_reset_child =3D NULL;
> +	int i =3D reset_data->nr_resets;
> +	int ret;
> +	u32 ctrl_bit;
> +
> +	while ((next_reset_child =3D of_get_next_child(reset_child, next_re=
set_child))) {
> +		if (next_reset_child->phandle) {
> +			/* Get the bits of each sub-reset */
> +			ret =3D of_property_read_u32(next_reset_child, "control-bit",
> +						&ctrl_bit);
> +				if (ret < 0) {
> +					dev_err(reset_data->dev,
> +						"%s: No entry in %s for rstctrl_offs\n",
> +						__func__, next_reset_child->name);
> +
> +				return -ENODEV;
>
return the error code from of_property_read()?

> +			}
> +
> +			ret =3D of_property_read_u32(next_reset_child, "status-bit",
> +						&reset_data->ti_reg_data[i].rstst_bit);
> +				if (ret < 0) {
> +					dev_err(reset_data->dev,
> +							"%s: No entry in %s for rstst_offs\n",
> +							__func__, next_reset_child->name);
> +
> +				return -ENODEV;
>
dto.

> +			}
> +
> +			reset_data->ti_reg_data[i].rstctrl_offs =3D ctrl_offs;
> +			reset_data->ti_reg_data[i].rstst_offs =3D status_offs;
> +			reset_data->ti_reg_data[i].handle =3D next_reset_child->phandle;
> +			i++;
> +		}
> +	};
> +
> +	reset_data->nr_resets =3D i;
> +
> +	return 0;
> +}
> +
> +static int ti_reset_get_of_data(struct ti_reset_data *reset_data,
> +				struct device_node *dev_node)
> +{
> +	struct device_node *reset_child =3D NULL;
> +	int ret =3D -EINVAL;
>
useless initialization.

> +	u32 ctrl_offs, status_offs;
> +
> +	/* Loop through all the children and populate a lookup array */
> +	while ((reset_child =3D of_get_next_child(dev_node, reset_child))) =
{
>
I'd prefer:
	while ((reset_child =3D of_get_next_child(dev_node,
reset_child)) !=3D NULL) { to make it abundantly clear that the =3D is =
not meant as a comparison
operator but an assignment.

> +		ret =3D of_property_read_u32_index(reset_child, "reg", 0,
> +						 &ctrl_offs);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D of_property_read_u32_index(reset_child, "reg", 1,
> +						 &status_offs);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ti_reset_populate_child(reset_data, reset_child,
> +							ctrl_offs, status_offs);
> +		if (ret)
> +			return ret;
> +	};
> +
> +	return 0;
> +}
> +
> +static int ti_reset_probe(struct platform_device *pdev)
> +{
> +	struct device_node *resets;
> +	struct ti_reset_data *reset_data;
> +	struct resource *res;
> +	int ret;
> +
> +	reset_data =3D devm_kzalloc(&pdev->dev, sizeof(*reset_data), GFP_KE=
RNEL);
> +	if (!reset_data)
> +		return -ENOMEM;
> +
> +	resets =3D of_find_node_by_name(NULL, "resets");
> +	if (!resets) {
> +		dev_err(&pdev->dev, "%s: missing 'resets' child node.\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reset_data->reg_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reset_data->reg_base)) {
> +		dev_err(&pdev->dev, "%s: Cannot map reset parent.\n", __func__);
> +		return -ENODEV;
>
return the error code from devm_ioremap_resource.

> +	}
> +
> +	spin_lock_init(&reset_data->lock);
> +	reset_data->dev =3D &pdev->dev;
> +	ret =3D ti_reset_get_of_data(reset_data, resets);
> +	if (ret)
> +		return -EINVAL;
>
return ret!

> +	reset_data->rcdev.owner =3D THIS_MODULE;
> +	reset_data->rcdev.of_node =3D resets;
> +	reset_data->rcdev.ops =3D &ti_reset_ops;
> +
> +	reset_data->rcdev.of_reset_n_cells =3D 1;
> +	reset_data->rcdev.of_xlate =3D &ti_reset_xlate;
> +
> +	reset_data->ti_data =3D reset_data;
> +
> +	platform_set_drvdata(pdev, reset_data);
> +
> +	reset_controller_register(&reset_data->rcdev);
> +
> +	return 0;
> +}
> +
> +static int ti_reset_remove(struct platform_device *pdev)
> +{
> +	struct ti_reset_data *reset_data;
> +
> +	reset_data =3D platform_get_drvdata(pdev);
>
struct ti_reset_data *reset_data =3D platform_get_drvdata(pdev);

> +	reset_controller_unregister(&reset_data->rcdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ti_reset_of_match[] =3D {
> +	{ .compatible =3D "ti,omap5-prm" },
> +	{ .compatible =3D	"ti,omap4-prm" },
> +	{ .compatible =3D	"ti,omap5-prm" },
> +	{ .compatible =3D	"ti,dra7-prm" },
> +	{ .compatible =3D "ti,am4-prcm" },
> +	{ .compatible =3D	"ti,am3-prcm" },
> +	{},
>
useless comma after list terminator.
Without the comma an entry inadvertedly added after the terminator
(e.g. due to a badly resolved merge conflict) will lead to a compile
error while otherwise the new entry will silently be ignored.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
