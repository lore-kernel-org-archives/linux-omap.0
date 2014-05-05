From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC] [v2 Patch 1/6] drivers: reset: TI: SoC reset controller
 support.
Date: Mon, 5 May 2014 16:33:06 -0500
Message-ID: <20140505213306.GA3732@saruman.home>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
 <1399320567-3639-2-git-send-email-dmurphy@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43935 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756000AbaEEVdf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 May 2014 17:33:35 -0400
Content-Disposition: inline
In-Reply-To: <1399320567-3639-2-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 05, 2014 at 03:09:22PM -0500, Dan Murphy wrote:
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
> This code was derived from previous work by Rajendra Nayak and Afzal Moha=
mmed.
> The code was changed to adopt to the reset core and abstract away the SoC=
 information.

you should break your commit log at around 72 characters at most.

> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/reset/Kconfig            |    1 +
>  drivers/reset/Makefile           |    1 +
>  drivers/reset/ti/Kconfig         |    8 ++
>  drivers/reset/ti/Makefile        |    1 +
>  drivers/reset/ti/reset-ti-data.h |   56 ++++++++
>  drivers/reset/ti/reset-ti.c      |  267 ++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 334 insertions(+)
>  create mode 100644 drivers/reset/ti/Kconfig
>  create mode 100644 drivers/reset/ti/Makefile
>  create mode 100644 drivers/reset/ti/reset-ti-data.h
>  create mode 100644 drivers/reset/ti/reset-ti.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 0615f50..a58d789 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -13,3 +13,4 @@ menuconfig RESET_CONTROLLER
>  	  If unsure, say no.
> =20
>  source "drivers/reset/sti/Kconfig"
> +source "drivers/reset/ti/Kconfig"

this driver is so small that I'm not sure you need a directory for it.

> diff --git a/drivers/reset/ti/Kconfig b/drivers/reset/ti/Kconfig
> new file mode 100644
> index 0000000..dcdce90
> --- /dev/null
> +++ b/drivers/reset/ti/Kconfig
> @@ -0,0 +1,8 @@
> +config RESET_TI
> +	depends on RESET_CONTROLLER

don't you want to depend on ARCH_OMAP || COMPILE_TEST ?

> diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti=
-data.h
> new file mode 100644
> index 0000000..4d2a6d5
> --- /dev/null
> +++ b/drivers/reset/ti/reset-ti-data.h
> @@ -0,0 +1,56 @@
> +/*
> + * PRCM reset driver for TI SoC's
> + *
> + * Copyright 2014 Texas Instruments Inc.

this is not the TI aproved way for copyright notices. Yeah,
nit-picking...

> + * Author: Dan Murphy <dmurphy@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _RESET_TI_DATA_H_
> +#define _RESET_TI_DATA_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/reset-controller.h>
> +
> +/**
> + * struct ti_reset_reg_data - Structure of the reset register information
> + *		for a particular SoC.
> + * @rstctrl_offs: This is the reset control offset value from
> + *		from the parent reset node.
> + * @rstst_offs: This is the reset status offset value from
> + *		from the parent reset node.
> + * @rstctrl_bit: This is the reset control bit for the module.
> + * @rstst_bit: This is the reset status bit for the module.
> + *
> + * This structure describes the reset register control and status offset=
s.
> + * The bits are also defined for the same.
> + */
> +struct ti_reset_reg_data {
> +	void __iomem *reg_base;
> +	u32	rstctrl_offs;
> +	u32	rstst_offs;
> +	u32	rstctrl_bit;
> +	u32	rstst_bit;

this structure can be folded into struct ti_reset_data and all of that
can be initialized during probe.

> +};
> +
> +/**
> + * struct ti_reset_data - Structure that contains the reset register data
> + *	as well as the total number of resets for a particular SoC.
> + * @reg_data:	Pointer to the register data structure.
> + * @nr_resets:	Total number of resets for the SoC in the reset array.
> + *
> + * This structure contains a pointer to the register data and the modules
> + * register base.  The number of resets and reset controller device data=
 is
> + * stored within this structure.
> + *
> + */
> +struct ti_reset_data {
> +	struct ti_reset_reg_data *reg_data;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +#endif

this entire file can be moved into the .c file. It's too small and the
only user for these new types is the .c driver anyway.

> diff --git a/drivers/reset/ti/reset-ti.c b/drivers/reset/ti/reset-ti.c
> new file mode 100644
> index 0000000..349f4fb
> --- /dev/null
> +++ b/drivers/reset/ti/reset-ti.c
> @@ -0,0 +1,267 @@
> +/*
> + * PRCM reset driver for TI SoC's
> + *
> + * Copyright 2014 Texas Instruments Inc.
> + *
> + * Author: Dan Murphy <dmurphy@ti.com>

fix copyright notice here too

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#include "reset-ti-data.h"
> +
> +#define DRIVER_NAME "prcm_reset_ti"
> +
> +static struct ti_reset_data *ti_data;

NAK, you *really* don't need and don't to have this global here. It only
creates problems. And avoid arguing that "there's only one reset
controller anyway" because that has bitten us in the past. Also, it's
not a lot of work to make proper use of dev_set/get_drvdata() and
container_of() to find your struct ti_reset_data pointer.

> +static int ti_reset_get_of_data(struct ti_reset_reg_data *reset_data,
> +				unsigned long id)
> +{
> +	struct device_node *dev_node;
> +	struct device_node *parent;
> +	struct device_node *prcm_parent;
> +	struct device_node *reset_parent;
> +	int ret =3D -EINVAL;
> +
> +	dev_node =3D of_find_node_by_phandle((phandle) id);
> +	if (!dev_node) {
> +		pr_err("%s: Cannot find phandle node\n", __func__);

pass a struct device pointer as argument so you can convert these to
dev_err().

> +		return ret;
> +	}
> +
> +	/* node parent */
> +	parent =3D of_get_parent(dev_node);
> +	if (!parent) {
> +		pr_err("%s: Cannot find parent reset node\n", __func__);
> +		return ret;
> +	}
> +	/* prcm reset parent */
> +	reset_parent =3D of_get_next_parent(parent);
> +	if (!reset_parent) {
> +		pr_err("%s: Cannot find parent reset node\n", __func__);
> +		return ret;
> +	}
> +	/* PRCM Parent */
> +	reset_parent =3D of_get_parent(reset_parent);
> +	if (!prcm_parent) {
> +		pr_err("%s: Cannot find parent reset node\n", __func__);
> +		return ret;
> +	}
> +
> +	reset_data->reg_base =3D of_iomap(reset_parent, 0);

please don't. of_iomap() is the stupidest helper in the kernel. Find
your resource using platform_get_resource() and map it with
devm_ioremap_resource() since that will properly request_mem_region()
and correctly map the resource with or without caching.

> +	if (!reset_data->reg_base) {
> +		pr_err("%s: Cannot map reset parent.\n", __func__);
> +		return ret;
> +	}
> +
> +	ret =3D of_property_read_u32_index(parent, "reg", 0,
> +					 &reset_data->rstctrl_offs);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D of_property_read_u32_index(parent, "reg", 1,
> +					 &reset_data->rstst_offs);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D of_property_read_u32(dev_node, "control-bit",
> +				   &reset_data->rstctrl_bit);
> +	if (ret < 0)
> +		pr_err("%s: No entry in %s for rstst_offs\n", __func__,
> +			   dev_node->name);
> +
> +	ret =3D of_property_read_u32(dev_node, "status-bit",
> +				   &reset_data->rstst_bit);
> +	if (ret < 0)
> +		pr_err("%s: No entry in %s for rstst_offs\n", __func__,
> +			   dev_node->name);
> +
> +	return 0;
> +}
> +
> +static void ti_reset_wait_on_reset(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{

right here you should have:

	struct ti_reset_data *ti_data =3D container_of(rcdev,
		struct ti_reset_data, rcdev);

> +	struct ti_reset_reg_data *temp_reg_data;
> +	void __iomem *status_reg;
> +	u32 bit_mask =3D 0;
> +	u32 val =3D 0;
> +
> +	temp_reg_data =3D kzalloc(sizeof(struct ti_reset_reg_data), GFP_KERNEL);

let's think about this for a second:

user asks for a reset, then ->assert() method gets called, which will
allocate memory, do some crap, free the allocated memory, then you call
your ->deassert() method which will, allocate memory, do something, free
memory, then this method is called which will allocate memory, do
something, free memory.

Note that *all* of your allocations a) are unnecessary and b) will break
resets from inside IRQ context...

> +	ti_reset_get_of_data(temp_reg_data, id);

this means that *every time* a reset is asserted/deasserted/waited on,
you will parse *ONE MORE TIME* the DTB. Why ? Why don't you parse it
once during probe() and cache the results ?

> +	/* Clear the reset status bit to reflect the current status */
> +	status_reg =3D temp_reg_data->reg_base + temp_reg_data->rstst_offs;
> +	bit_mask =3D temp_reg_data->rstst_bit;
> +	do {
> +		val =3D readl(status_reg);
> +		if (!(val & (1 << bit_mask)))
> +			break;
> +	} while (1);

also, none of these loops have a timeout. You are creating the
possibility of hanging the platform completely if the HW misbehaves.

> +static int ti_reset_assert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct ti_reset_reg_data *temp_reg_data;
> +	void __iomem *reg;
> +	void __iomem *status_reg;
> +	u32 status_bit =3D 0;
> +	u32 bit_mask =3D 0;
> +	u32 val =3D 0;
> +
> +	temp_reg_data =3D kzalloc(sizeof(struct ti_reset_reg_data), GFP_KERNEL);
> +	ti_reset_get_of_data(temp_reg_data, id);
> +
> +	/* Clear the reset status bit to reflect the current status */
> +	status_reg =3D temp_reg_data->reg_base + temp_reg_data->rstst_offs;
> +	status_bit =3D temp_reg_data->rstst_bit;
> +	writel(1 << status_bit, status_reg);
> +
> +	reg =3D temp_reg_data->reg_base + temp_reg_data->rstctrl_offs;
> +	bit_mask =3D temp_reg_data->rstctrl_bit;
> +	val =3D readl(reg);
> +	if (!(val & bit_mask)) {
> +		val |=3D bit_mask;
> +		writel(val, reg);
> +	}
> +
> +	kfree(temp_reg_data);

same comments as previous callback

> +	return 0;
> +}
> +
> +static int ti_reset_deassert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +
> +	struct ti_reset_reg_data *temp_reg_data;
> +	void __iomem *reg;
> +	void __iomem *status_reg;
> +	u32 status_bit =3D 0;
> +	u32 bit_mask =3D 0;
> +	u32 val =3D 0;
> +
> +	temp_reg_data =3D kzalloc(sizeof(struct ti_reset_reg_data), GFP_KERNEL);
> +	ti_reset_get_of_data(temp_reg_data, id);
> +
> +	/* Clear the reset status bit to reflect the current status */
> +	status_reg =3D temp_reg_data->reg_base + temp_reg_data->rstst_offs;
> +	status_bit =3D temp_reg_data->rstst_bit;
> +	writel(1 << status_bit, status_reg);
> +
> +	reg =3D temp_reg_data->reg_base + temp_reg_data->rstctrl_offs;
> +	bit_mask =3D temp_reg_data->rstctrl_bit;
> +	val =3D readl(reg);
> +	if (val & bit_mask) {
> +		val &=3D ~bit_mask;
> +		writel(val, reg);
> +	}

and here. Also, this is leaking temp_reg_data.

> +
> +	return 0;
> +}
> +
> +static int ti_reset_reset(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	ti_reset_assert(rcdev, id);
> +	ti_reset_deassert(rcdev, id);
> +	ti_reset_wait_on_reset(rcdev, id);
> +
> +	return 0;
> +}
> +
> +static int ti_reset_xlate(struct reset_controller_dev *rcdev,
> +			const struct of_phandle_args *reset_spec)
> +{
> +	struct device_node *dev_node;
> +
> +	if (WARN_ON(reset_spec->args_count !=3D rcdev->of_reset_n_cells))
> +		return -EINVAL;
> +
> +	/* Verify that the phandle exists */
> +	dev_node =3D of_find_node_by_phandle((phandle) reset_spec->args[0]);
> +	if (!dev_node) {
> +		pr_err("%s: Cannot find phandle node\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	return reset_spec->args[0];
> +}
> +
> +static struct reset_control_ops ti_reset_ops =3D {
> +	.reset =3D ti_reset_reset,
> +	.assert =3D ti_reset_assert,
> +	.deassert =3D ti_reset_deassert,
> +};
> +
> +static int ti_reset_probe(struct platform_device *pdev)
> +{
> +	struct device_node *resets;

here you should have something like:

	struct ti_reset_data *ti_data;

	[...]

	ti_data =3D devm_kzalloc(sizeof(*ti_data), GFP_KERNEL);
	if (!ti_data)
		return -ENOMEM;

	platform_get_resource(...);

	ti_data->base =3D devm_ioremap_resource(res);
	if (IS_ERR(ti_data->base))
		return PTR_ERR(ti_data->base);

	platform_set_drvdata(pdev, ti_data);

> +	resets =3D of_find_node_by_name(NULL, "resets");
> +	if (!resets) {
> +		pr_err("%s: missing 'resets' child node.\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ti_data =3D kzalloc(sizeof(*ti_data), GFP_KERNEL);
> +	if (!ti_data)
> +		return -ENOMEM;
> +
> +	ti_data->rcdev.owner =3D THIS_MODULE;
> +	ti_data->rcdev.of_node =3D resets;
> +	ti_data->rcdev.ops =3D &ti_reset_ops;
> +
> +	ti_data->rcdev.of_reset_n_cells =3D 1;
> +	ti_data->rcdev.of_xlate =3D &ti_reset_xlate;
> +
> +	reset_controller_register(&ti_data->rcdev);
> +
> +	return 0;
> +}
> +
> +static int ti_reset_remove(struct platform_device *pdev)
> +{

and here:

	struct ti_reset_data *ti_data =3D platform_get_drvdata(pdev);

	reset_controller_unregister(&ti_data->rcdev);

> +	reset_controller_unregister(&ti_data->rcdev);
> +
> +	return 0;
> +}

--=20
balbi

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaAOSAAoJEIaOsuA1yqREjd0P/2O6QI42HuD7LeEl61osdykv
h1CKNsdypgJXeCVAWwXBCT2uotkNEgA3zb78bQqfuG6/Zlee3v2RuXaEj9aWcWmv
YmmahyjkfH6zmi6fXJEoSmosjBWhd0lPyqp7otkxjswYJHvuK7/PD6eaHMJECi3n
3SlzJnLqCC55SEMm21bHWOMPQwmCguTlqATBFIgrKqgl+eEC1bDwJyGtRtr7ddHb
kdkcROS3a1X85tA576yPPQe+yRos9awqbzjAOJ7fszhmv3ebyzRN3W4QZ7keK1gE
90TUrf+Zyug0GieNT66/qGW9DC4jCUL8F3GykELyTRZpVoGUF/Ulj8xqkXN46qR8
2dHiR+wt4s7CQMn1X0kZIvxDfhA9bSl1qwlAJ2U3+MaDLZtBy18f47znhzlWzXv4
0n03Tpv3DrdbpSUtDsWQa5yShvPwVA3OWr2n3hHlLD2/87CgGEs7xEN+scSPeILQ
FOMDKQI+kjvYPKWS06QPZV9AQmiA9W6KW/hoIMAvC+ZWkRL/nDQeGzRE1jNz/Sak
AEBQ8KpzTiZph9KGqbPJ8ct6BWft7YIzn6V60+8iH/FCKwz+aZ6w55oRun8N+7Ri
e8KZT+rN2Z5UR/ZSFPPrlEiz4dnrY3M1p1WrQi//HGtEi0JaBRwSvHlbnal6raof
KUOlirxsorkqae2JEpqg
=JUFl
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
