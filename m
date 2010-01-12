From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3]: Introducing 'gpmc-nand.c' for GPMC specific NAND
 init
Date: Mon, 11 Jan 2010 17:01:45 -0800
Message-ID: <20100112010145.GJ5055@atomide.com>
References: <ce9ab5791001110240p6c74497eg128cb726ed4fe4d0@mail.gmail.com>
 <ce9ab5791001110249n65b303f5g9192395a883eb604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59999 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0ALBBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 20:01:40 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5791001110249n65b303f5g9192395a883eb604@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>

Hi,

=46ew more comments below.

* Vimal Singh <vimal.newwork@gmail.com> [100111 02:47]:
> On Mon, Jan 11, 2010 at 4:10 PM, Vimal Singh <vimal.newwork@gmail.com=
> wrote:
> > Re-summiting this patch. After re-basing on LO master.
> >
> > -vimal
> >
> >
> > From a7ea8851fe96690c9322393eb35a344853992166 Mon Sep 17 00:00:00 2=
001
> > From: Vimal Singh <vimalsingh@ti.com>
> > Date: Mon, 11 Jan 2010 16:01:29 +0530
> > Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND i=
nit
> >
> > Introducing 'gpmc-nand.c' for GPMC specific NAND init.
> > For example: GPMC timing parameters and all.
> > This patch also migrates gpmc related calls from 'nand/omap2.c'
> > to 'gpmc-nand.c'.
> >
> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> > ---
> > =C2=A0arch/arm/mach-omap2/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A03 +
> > =C2=A0arch/arm/mach-omap2/gpmc-nand.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0136 ++++++++++++++++++++++++++++++++
> > =C2=A0arch/arm/plat-omap/include/plat/nand.h | =C2=A0 =C2=A06 ++
> > =C2=A0drivers/mtd/nand/omap2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 26 +------
> > =C2=A04 files changed, 148 insertions(+), 23 deletions(-)
> > =C2=A0create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>=20
>=20
> Patch got line wrapped. Corrected it below.
>=20
> From a7ea8851fe96690c9322393eb35a344853992166 Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Mon, 11 Jan 2010 16:01:29 +0530
> Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND ini=
t
>=20
> Introducing 'gpmc-nand.c' for GPMC specific NAND init.
> For example: GPMC timing parameters and all.
> This patch also migrates gpmc related calls from 'nand/omap2.c'
> to 'gpmc-nand.c'.
>=20
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    3 +
>  arch/arm/mach-omap2/gpmc-nand.c        |  136 ++++++++++++++++++++++=
++++++++++
>  arch/arm/plat-omap/include/plat/nand.h |    6 ++
>  drivers/mtd/nand/omap2.c               |   26 +------
>  4 files changed, 148 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>=20
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index b32678b..247438b 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -119,5 +119,8 @@ obj-y					+=3D usb-ehci.o
>  onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:=3D gpmc-onenand.o
>  obj-y					+=3D $(onenand-m) $(onenand-y)
>=20
> +nand-$(CONFIG_MTD_NAND_OMAP2)		:=3D gpmc-nand.o
> +obj-y					+=3D $(nand-m) $(nand-y)
> +
>  smc91x-$(CONFIG_SMC91X)			:=3D gpmc-smc91x.o
>  obj-y					+=3D $(smc91x-m) $(smc91x-y)
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gp=
mc-nand.c
> new file mode 100644
> index 0000000..822ba82
> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -0,0 +1,136 @@
> +/*
> + * gpmc-nand.c
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Vimal Singh <vimalsingh@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <asm/mach/flash.h>
> +
> +#include <plat/nand.h>
> +#include <plat/board.h>
> +#include <plat/gpmc.h>
> +
> +#define WR_RD_PIN_MONITORING	0x00600000
> +
> +static struct omap_nand_platform_data *gpmc_nand_data;
> +
> +static struct resource gpmc_nand_resource =3D {
> +	.flags		=3D IORESOURCE_MEM,
> +};
> +
> +static struct platform_device gpmc_nand_device =3D {
> +	.name		=3D "omap2-nand",
> +	.id		=3D 0,
> +	.num_resources	=3D 1,
> +	.resource	=3D &gpmc_nand_resource,
> +};
> +
> +static int omap2_nand_gpmc_config(int cs, void __iomem *nand_base)
> +{
> +	struct gpmc_timings t;
> +	int err;
> +
> +	const int cs_rd_off =3D 36;
> +	const int cs_wr_off =3D 36;
> +	const int adv_on =3D 6;
> +	const int adv_rd_off =3D 24;
> +	const int adv_wr_off =3D 36;
> +	const int oe_off =3D 48;
> +	const int we_off =3D 30;
> +	const int rd_cycle =3D 72;
> +	const int wr_cycle =3D 72;
> +	const int access =3D 54;
> +	const int wr_data_mux_bus =3D 0;
> +	const int wr_access =3D 30;
> +
> +	memset(&t, 0, sizeof(t));
> +	t.sync_clk =3D 0;
> +	t.cs_on =3D 0;
> +	t.adv_on =3D gpmc_round_ns_to_ticks(adv_on);
> +
> +	/* Read */
> +	t.adv_rd_off =3D gpmc_round_ns_to_ticks(adv_rd_off);
> +	t.oe_on  =3D t.adv_on;
> +	t.access =3D gpmc_round_ns_to_ticks(access);
> +	t.oe_off =3D gpmc_round_ns_to_ticks(oe_off);
> +	t.cs_rd_off =3D gpmc_round_ns_to_ticks(cs_rd_off);
> +	t.rd_cycle  =3D gpmc_round_ns_to_ticks(rd_cycle);
> +
> +	/* Write */
> +	t.adv_wr_off =3D gpmc_round_ns_to_ticks(adv_wr_off);
> +	t.we_on  =3D t.oe_on;
> +	if (cpu_is_omap34xx()) {
> +		t.wr_data_mux_bus =3D gpmc_round_ns_to_ticks(wr_data_mux_bus);
> +		t.wr_access =3D gpmc_round_ns_to_ticks(wr_access);
> +	}
> +	t.we_off =3D gpmc_round_ns_to_ticks(we_off);
> +	t.cs_wr_off =3D gpmc_round_ns_to_ticks(cs_wr_off);
> +	t.wr_cycle  =3D gpmc_round_ns_to_ticks(wr_cycle);
> +
> +	/* Configure GPMC */
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
> +			GPMC_CONFIG1_DEVICESIZE(gpmc_nand_data->devsize) |
> +			GPMC_CONFIG1_DEVICETYPE_NAND);
> +
> +	err =3D gpmc_cs_set_timings(cs, &t);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

How about allow passing timings from board-*.c file? This most likely w=
ill
work with only one type of NAND chip.

> +static int gpmc_nand_setup(void __iomem *nand_base)
> +{
> +	struct device *dev =3D &gpmc_nand_device.dev;
> +
> +	/* Set timings in GPMC */
> +	if (omap2_nand_gpmc_config(gpmc_nand_data->cs, nand_base) < 0) {
> +		dev_err(dev, "Unable to set gpmc timings\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data=
)
> +{
> +	unsigned int val;
> +	int err	=3D 0;
> +	struct device *dev =3D &gpmc_nand_device.dev;
> +
> +	gpmc_nand_data =3D _nand_data;
> +	gpmc_nand_data->nand_setup =3D gpmc_nand_setup;
> +	gpmc_nand_device.dev.platform_data =3D gpmc_nand_data;
> +
> +	err =3D gpmc_nand_setup(gpmc_nand_data->gpmc_cs_baseaddr);
> +	if (err < 0) {
> +		dev_err(dev, "NAND platform setup failed: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Enable RD PIN Monitoring Reg */
> +	if (gpmc_nand_data->dev_ready) {
> +		val  =3D gpmc_cs_read_reg(gpmc_nand_data->cs,
> +						 GPMC_CS_CONFIG1);
> +		val |=3D WR_RD_PIN_MONITORING;
> +		gpmc_cs_write_reg(gpmc_nand_data->cs,
> +						GPMC_CS_CONFIG1, val);
> +	}
> +
> +	err =3D platform_device_register(&gpmc_nand_device);
> +	if (err < 0) {
> +		dev_err(dev, "Unable to register NAND device\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}

Looks like nothing is calling gpmc_nand_init. Please provide patches to
convert the users to call gpmc_nand_init.

And while at it, please fix the driver to call gpmc_cs_request.

Regards,

Tony


> diff --git a/arch/arm/plat-omap/include/plat/nand.h
> b/arch/arm/plat-omap/include/plat/nand.h
> index 631a7be..2ba9842 100644
> --- a/arch/arm/plat-omap/include/plat/nand.h
> +++ b/arch/arm/plat-omap/include/plat/nand.h
> @@ -21,4 +21,10 @@ struct omap_nand_platform_data {
>  	int			dma_channel;
>  	void __iomem		*gpmc_cs_baseaddr;
>  	void __iomem		*gpmc_baseaddr;
> +	int			devsize;
>  };
> +
> +/* size (4 KiB) for IO mapping */
> +#define	NAND_IO_SIZE	SZ_4K
> +
> +extern int gpmc_nand_init(struct omap_nand_platform_data *d);
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 7df303a..af028f7 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -30,12 +30,8 @@
>=20
>  #define	DRIVER_NAME	"omap2-nand"
>=20
> -/* size (4 KiB) for IO mapping */
> -#define	NAND_IO_SIZE	SZ_4K
> -
>  #define	NAND_WP_OFF	0
>  #define NAND_WP_BIT	0x00000010
> -#define WR_RD_PIN_MONITORING	0x00600000
>=20
>  #define	GPMC_BUF_FULL	0x00000001
>  #define	GPMC_BUF_EMPTY	0x00000000
> @@ -885,8 +881,6 @@ static int __devinit omap_nand_probe(struct
>  	struct omap_nand_info		*info;
>  	struct omap_nand_platform_data	*pdata;
>  	int				err;
> -	unsigned long 			val;
> -
>=20
>  	pdata =3D pdev->dev.platform_data;
>  	if (pdata =3D=3D NULL) {
> @@ -913,24 +907,15 @@ static int __devinit omap_nand_probe(struct
>  	info->mtd.name		=3D dev_name(&pdev->dev);
>  	info->mtd.owner		=3D THIS_MODULE;
>=20
> +	info->nand.options	|=3D pdata->devsize ? NAND_BUSWIDTH_16 : 0;
> +	info->nand.options	|=3D NAND_SKIP_BBTSCAN;
> +
>  	err =3D gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, &info->phys_ba=
se);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
>  		goto out_free_info;
>  	}
>=20
> -	/* Enable RD PIN Monitoring Reg */
> -	if (pdata->dev_ready) {
> -		val  =3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1);
> -		val |=3D WR_RD_PIN_MONITORING;
> -		gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1, val);
> -	}
> -
> -	val  =3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG7);
> -	val &=3D ~(0xf << 8);
> -	val |=3D  (0xc & 0xf) << 8;
> -	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
> -
>  	/* NAND write protect off */
>  	omap_nand_wp(&info->mtd, NAND_WP_OFF);
>=20
> @@ -966,11 +951,6 @@ static int __devinit omap_nand_probe(struct
>  		info->nand.chip_delay =3D 50;
>  	}
>=20
> -	info->nand.options  |=3D NAND_SKIP_BBTSCAN;
> -	if ((gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1) & 0x3000)
> -								=3D=3D 0x1000)
> -		info->nand.options  |=3D NAND_BUSWIDTH_16;
> -
>  	if (use_prefetch) {
>  		/* copy the virtual address of nand base for fifo access */
>  		info->nand_pref_fifo_add =3D info->nand.IO_ADDR_R;
> --=20
> 1.5.5
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
