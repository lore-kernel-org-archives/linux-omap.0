From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/2]: Introducing 'gpmc-nand.c' for GPMC specific NAND
	init
Date: Fri, 4 Dec 2009 19:00:48 +0530
Message-ID: <d6a0f7aa0912040530o72d16979m4c785c2f9cda150c@mail.gmail.com>
References: <ce9ab5790912030606u38ff19bdy536c1931a5fb63f0@mail.gmail.com>
	 <ce9ab5790912040504q5ad01329haa80f5814407a991@mail.gmail.com>
	 <ce9ab5790912040514n238fd080g722f42b426bb6b1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:37324 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbZLDNam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 08:30:42 -0500
Received: by qyk30 with SMTP id 30so1047351qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 04 Dec 2009 05:30:48 -0800 (PST)
In-Reply-To: <ce9ab5790912040514n238fd080g722f42b426bb6b1b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linux MTD <linux-mtd@lists.infradead.org>

This patch got line wrapped.

--=20
---
Regards,
Govindraj.R


On Fri, Dec 4, 2009 at 6:44 PM, Vimal Singh <vimal.newwork@gmail.com> w=
rote:
> Ahh.. this is my bad.
>
> [...]
>> + =A0 =A0 =A0 err =3D gpmc_nand_setup((void __iomem *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &gpmc_nand_data->gpmc_cs_baseaddr);
> we just do not need casting here.
>
> Apologies for making noise and confusion.
> Please take this one.
>
> -vimal
>
> From e024a2e6aa2051259ad904daff13bdac73b3b1b8 Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Wed, 25 Nov 2009 18:23:15 +0530
> Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND ini=
t
>
> Introducing 'gpmc-nand.c' for GPMC specific NAND init.
> For example: GPMC timing parameters and all.
> This patch also migrates gpmc related calls from 'nand/omap2.c'
> to 'gpmc-nand.c'.
>
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0| =A0141 ++++++++++=
++++++++++++++++++++++
> =A0arch/arm/plat-omap/include/plat/nand.h | =A0 =A06 ++
> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 26 +---=
--
> =A04 files changed, 153 insertions(+), 23 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 59b0ccc..0dfe27a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -103,5 +103,8 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D usb-ehci.o
> =A0onenand-$(CONFIG_MTD_ONENAND_OMAP2) =A0 =A0:=3D gpmc-onenand.o
> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0+=3D $(onenand-m) $(onenand-y)
>
> +nand-$(CONFIG_MTD_NAND_OMAP2) =A0 =A0 =A0 =A0 =A0:=3D gpmc-nand.o
> +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D $(nand-m) $(nand-y)
> +
> =A0smc91x-$(CONFIG_SMC91X) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0:=3D gpmc-smc91x.o
> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0+=3D $(smc91x-m) $(smc91x-y)
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gp=
mc-nand.c
> new file mode 100644
> index 0000000..0621e39
> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -0,0 +1,141 @@
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
> +#define WR_RD_PIN_MONITORING =A0 0x00600000
> +
> +static struct omap_nand_platform_data *gpmc_nand_data;
> +
> +static struct resource gpmc_nand_resource =3D {
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> +};
> +
> +static struct platform_device gpmc_nand_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2-nand",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .num_resources =A0=3D 1,
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D &gpmc_nand_resource,
> +};
> +
> +static int omap2_nand_gpmc_config(int cs, void __iomem *nand_base)
> +{
> + =A0 =A0 =A0 struct gpmc_timings t;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 const int cs_rd_off =3D 36;
> + =A0 =A0 =A0 const int cs_wr_off =3D 36;
> + =A0 =A0 =A0 const int adv_on =3D 6;
> + =A0 =A0 =A0 const int adv_rd_off =3D 24;
> + =A0 =A0 =A0 const int adv_wr_off =3D 36;
> + =A0 =A0 =A0 const int oe_off =3D 48;
> + =A0 =A0 =A0 const int we_off =3D 30;
> + =A0 =A0 =A0 const int rd_cycle =3D 72;
> + =A0 =A0 =A0 const int wr_cycle =3D 72;
> + =A0 =A0 =A0 const int access =3D 54;
> + =A0 =A0 =A0 const int wr_data_mux_bus =3D 8;
> + =A0 =A0 =A0 const int wr_access =3D 30;
> +
> + =A0 =A0 =A0 memset(&t, 0, sizeof(t));
> + =A0 =A0 =A0 t.sync_clk =3D 0;
> + =A0 =A0 =A0 t.cs_on =3D 0;
> + =A0 =A0 =A0 t.adv_on =3D gpmc_round_ns_to_ticks(adv_on);
> +
> + =A0 =A0 =A0 /* Read */
> + =A0 =A0 =A0 t.adv_rd_off =3D gpmc_round_ns_to_ticks(adv_rd_off);
> + =A0 =A0 =A0 t.oe_on =A0=3D t.adv_on;
> + =A0 =A0 =A0 t.access =3D gpmc_round_ns_to_ticks(access);
> + =A0 =A0 =A0 t.oe_off =3D gpmc_round_ns_to_ticks(oe_off);
> + =A0 =A0 =A0 t.cs_rd_off =3D gpmc_round_ns_to_ticks(cs_rd_off);
> + =A0 =A0 =A0 t.rd_cycle =A0=3D gpmc_round_ns_to_ticks(rd_cycle);
> +
> + =A0 =A0 =A0 /* Write */
> + =A0 =A0 =A0 t.adv_wr_off =3D gpmc_round_ns_to_ticks(adv_wr_off);
> + =A0 =A0 =A0 t.we_on =A0=3D t.oe_on;
> + =A0 =A0 =A0 if (cpu_is_omap34xx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t.wr_data_mux_bus =3D gpmc_round_ns_to_=
ticks(wr_data_mux_bus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t.wr_access =3D gpmc_round_ns_to_ticks(=
wr_access);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 t.we_off =3D gpmc_round_ns_to_ticks(we_off);
> + =A0 =A0 =A0 t.cs_wr_off =3D gpmc_round_ns_to_ticks(cs_wr_off);
> + =A0 =A0 =A0 t.wr_cycle =A0=3D gpmc_round_ns_to_ticks(wr_cycle);
> +
> + =A0 =A0 =A0 /* Configure GPMC */
> + =A0 =A0 =A0 gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CONFIG1_DEVICESIZE=
(gpmc_nand_data->devsize) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CONFIG1_DEVICETYPE=
_NAND);
> +
> + =A0 =A0 =A0 err =3D gpmc_cs_set_timings(cs, &t);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int gpmc_nand_setup(void __iomem *nand_base)
> +{
> + =A0 =A0 =A0 struct device *dev =3D &gpmc_nand_device.dev;
> +
> + =A0 =A0 =A0 /* Set timings in GPMC */
> + =A0 =A0 =A0 if (omap2_nand_gpmc_config(gpmc_nand_data->cs, nand_bas=
e) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to set gpmc timing=
s\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data=
)
> +{
> + =A0 =A0 =A0 unsigned int val;
> + =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 struct device *dev =3D &gpmc_nand_device.dev;
> +
> + =A0 =A0 =A0 gpmc_nand_data =3D _nand_data;
> + =A0 =A0 =A0 gpmc_nand_data->nand_setup =3D gpmc_nand_setup;
> + =A0 =A0 =A0 gpmc_nand_device.dev.platform_data =3D gpmc_nand_data;
> +
> + =A0 =A0 =A0 err =3D gpmc_nand_setup(gpmc_nand_data->gpmc_cs_baseadd=
r);
> + =A0 =A0 =A0 if (err < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "NAND platform setup faile=
d: %d\n", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Enable RD PIN Monitoring Reg */
> + =A0 =A0 =A0 if (gpmc_nand_data->dev_ready) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =A0=3D gpmc_cs_read_reg(gpmc_nand_d=
ata->cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0GPMC_CS_CONFIG1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D WR_RD_PIN_MONITORING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(gpmc_nand_data->cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS_CONFIG1, val);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 val =A0=3D gpmc_cs_read_reg(gpmc_nand_data->cs, GPMC_CS=
_CONFIG7);
> + =A0 =A0 =A0 val &=3D ~(0xf << 8);
> + =A0 =A0 =A0 val |=3D =A0(0xc & 0xf) << 8;
> + =A0 =A0 =A0 gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG7, =
val);
> +
> + =A0 =A0 =A0 err =3D platform_device_register(&gpmc_nand_device);
> + =A0 =A0 =A0 if (err < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to register NAND d=
evice\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/nand.h
> b/arch/arm/plat-omap/include/plat/nand.h
> index 631a7be..2ba9842 100644
> --- a/arch/arm/plat-omap/include/plat/nand.h
> +++ b/arch/arm/plat-omap/include/plat/nand.h
> @@ -21,4 +21,10 @@ struct omap_nand_platform_data {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_channe=
l;
> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_cs_baseaddr;
> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_baseaddr;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devsize;
> =A0};
> +
> +/* size (4 KiB) for IO mapping */
> +#define =A0 =A0 =A0 =A0NAND_IO_SIZE =A0 =A0SZ_4K
> +
> +extern int gpmc_nand_init(struct omap_nand_platform_data *d);
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 1bb799f..aaef170 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -30,12 +30,8 @@
>
> =A0#define =A0 =A0 =A0 =A0DRIVER_NAME =A0 =A0 "omap2-nand"
>
> -/* size (4 KiB) for IO mapping */
> -#define =A0 =A0 =A0 =A0NAND_IO_SIZE =A0 =A0SZ_4K
> -
> =A0#define =A0 =A0 =A0 =A0NAND_WP_OFF =A0 =A0 0
> =A0#define NAND_WP_BIT =A0 =A00x00000010
> -#define WR_RD_PIN_MONITORING =A0 0x00600000
>
> =A0#define =A0 =A0 =A0 =A0GPMC_BUF_FULL =A0 0x00000001
> =A0#define =A0 =A0 =A0 =A0GPMC_BUF_EMPTY =A00x00000000
> @@ -882,8 +878,6 @@ static int __devinit omap_nand_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0struct omap_nand_info =A0 =A0 =A0 =A0 =A0 *info;
> =A0 =A0 =A0 =A0struct omap_nand_platform_data =A0*pdata;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 err;
> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val;
> -
>
> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
> =A0 =A0 =A0 =A0if (pdata =3D=3D NULL) {
> @@ -910,24 +904,15 @@ static int __devinit omap_nand_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0info->mtd.name =A0 =A0 =A0 =A0 =A0=3D dev_name(&pdev->=
dev);
> =A0 =A0 =A0 =A0info->mtd.owner =A0 =A0 =A0 =A0 =3D THIS_MODULE;
>
> + =A0 =A0 =A0 info->nand.options =A0 =A0 =A0|=3D pdata->devsize ? NAN=
D_BUSWIDTH_16 : 0;
> + =A0 =A0 =A0 info->nand.options =A0 =A0 =A0|=3D NAND_SKIP_BBTSCAN;
> +
> =A0 =A0 =A0 =A0err =3D gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, &=
info->phys_base);
> =A0 =A0 =A0 =A0if (err < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "Cannot request GP=
MC CS\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_free_info;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Enable RD PIN Monitoring Reg */
> - =A0 =A0 =A0 if (pdata->dev_ready) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =A0=3D gpmc_cs_read_reg(info->gpmc_=
cs, GPMC_CS_CONFIG1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D WR_RD_PIN_MONITORING;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(info->gpmc_cs, GPMC_C=
S_CONFIG1, val);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 val =A0=3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONF=
IG7);
> - =A0 =A0 =A0 val &=3D ~(0xf << 8);
> - =A0 =A0 =A0 val |=3D =A0(0xc & 0xf) << 8;
> - =A0 =A0 =A0 gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
> -
> =A0 =A0 =A0 =A0/* NAND write protect off */
> =A0 =A0 =A0 =A0omap_nand_wp(&info->mtd, NAND_WP_OFF);
>
> @@ -963,11 +948,6 @@ static int __devinit omap_nand_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand.chip_delay =3D 50;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 info->nand.options =A0|=3D NAND_SKIP_BBTSCAN;
> - =A0 =A0 =A0 if ((gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1) &=
 0x3000)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D 0x1000)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.options =A0|=3D NAND_BUSWIDT=
H_16;
> -
> =A0 =A0 =A0 =A0if (use_prefetch) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* copy the virtual address of nand ba=
se for fifo access */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->nand_pref_fifo_add =3D info->nan=
d.IO_ADDR_R;
> --
> 1.5.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
