From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v3]: Introducing 'gpmc-nand.c' for GPMC specific NAND init
Date: Wed, 13 Jan 2010 12:05:20 +0530
Message-ID: <ce9ab5791001122235p53ec8ec5j9f6b7c9be8ccfb84@mail.gmail.com>
References: <ce9ab5791001110240p6c74497eg128cb726ed4fe4d0@mail.gmail.com>
	<ce9ab5791001110249n65b303f5g9192395a883eb604@mail.gmail.com>
	<20100112010145.GJ5055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61991 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab0AMGfm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 01:35:42 -0500
Received: by bwz27 with SMTP id 27so1712007bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 22:35:40 -0800 (PST)
In-Reply-To: <20100112010145.GJ5055@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>

On Tue, Jan 12, 2010 at 6:31 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> Hi,
>
> Few more comments below.
>
> * Vimal Singh <vimal.newwork@gmail.com> [100111 02:47]:
>> On Mon, Jan 11, 2010 at 4:10 PM, Vimal Singh <vimal.newwork@gmail.co=
m> wrote:
>> > Re-summiting this patch. After re-basing on LO master.
>> >
>> > -vimal
>> >
>> >
>> > From a7ea8851fe96690c9322393eb35a344853992166 Mon Sep 17 00:00:00 =
2001
>> > From: Vimal Singh <vimalsingh@ti.com>
>> > Date: Mon, 11 Jan 2010 16:01:29 +0530
>> > Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND =
init
>> >
>> > Introducing 'gpmc-nand.c' for GPMC specific NAND init.
>> > For example: GPMC timing parameters and all.
>> > This patch also migrates gpmc related calls from 'nand/omap2.c'
>> > to 'gpmc-nand.c'.
>> >
>> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
>> > =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0| =A0136 +++++++=
+++++++++++++++++++++++++
>> > =A0arch/arm/plat-omap/include/plat/nand.h | =A0 =A06 ++
>> > =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 26 +=
------
>> > =A04 files changed, 148 insertions(+), 23 deletions(-)
>> > =A0create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>>
>>
>> Patch got line wrapped. Corrected it below.
>>
>> From a7ea8851fe96690c9322393eb35a344853992166 Mon Sep 17 00:00:00 20=
01
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Mon, 11 Jan 2010 16:01:29 +0530
>> Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND in=
it
>>
>> Introducing 'gpmc-nand.c' for GPMC specific NAND init.
>> For example: GPMC timing parameters and all.
>> This patch also migrates gpmc related calls from 'nand/omap2.c'
>> to 'gpmc-nand.c'.
>>
>> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
>> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0| =A0136 +++++++++=
+++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/nand.h | =A0 =A06 ++
>> =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 26 +--=
----
>> =A04 files changed, 148 insertions(+), 23 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index b32678b..247438b 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -119,5 +119,8 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D usb-ehci.o
>> =A0onenand-$(CONFIG_MTD_ONENAND_OMAP2) =A0:=3D gpmc-onenand.o
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0+=3D $(onenand-m) $(onenand-y)
>>
>> +nand-$(CONFIG_MTD_NAND_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D g=
pmc-nand.o
>> +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0+=3D $(nand-m) $(nand-y)
>> +
>> =A0smc91x-$(CONFIG_SMC91X) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
:=3D gpmc-smc91x.o
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0+=3D $(smc91x-m) $(smc91x-y)
>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/g=
pmc-nand.c
>> new file mode 100644
>> index 0000000..822ba82
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>> @@ -0,0 +1,136 @@
>> +/*
>> + * gpmc-nand.c
>> + *
>> + * Copyright (C) 2009 Texas Instruments
>> + * Vimal Singh <vimalsingh@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +
>> +#include <asm/mach/flash.h>
>> +
>> +#include <plat/nand.h>
>> +#include <plat/board.h>
>> +#include <plat/gpmc.h>
>> +
>> +#define WR_RD_PIN_MONITORING 0x00600000
>> +
>> +static struct omap_nand_platform_data *gpmc_nand_data;
>> +
>> +static struct resource gpmc_nand_resource =3D {
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
>> +};
>> +
>> +static struct platform_device gpmc_nand_device =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2-nand",
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 .num_resources =A0=3D 1,
>> + =A0 =A0 .resource =A0 =A0 =A0 =3D &gpmc_nand_resource,
>> +};
>> +
>> +static int omap2_nand_gpmc_config(int cs, void __iomem *nand_base)
>> +{
>> + =A0 =A0 struct gpmc_timings t;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 const int cs_rd_off =3D 36;
>> + =A0 =A0 const int cs_wr_off =3D 36;
>> + =A0 =A0 const int adv_on =3D 6;
>> + =A0 =A0 const int adv_rd_off =3D 24;
>> + =A0 =A0 const int adv_wr_off =3D 36;
>> + =A0 =A0 const int oe_off =3D 48;
>> + =A0 =A0 const int we_off =3D 30;
>> + =A0 =A0 const int rd_cycle =3D 72;
>> + =A0 =A0 const int wr_cycle =3D 72;
>> + =A0 =A0 const int access =3D 54;
>> + =A0 =A0 const int wr_data_mux_bus =3D 0;
>> + =A0 =A0 const int wr_access =3D 30;
>> +
>> + =A0 =A0 memset(&t, 0, sizeof(t));
>> + =A0 =A0 t.sync_clk =3D 0;
>> + =A0 =A0 t.cs_on =3D 0;
>> + =A0 =A0 t.adv_on =3D gpmc_round_ns_to_ticks(adv_on);
>> +
>> + =A0 =A0 /* Read */
>> + =A0 =A0 t.adv_rd_off =3D gpmc_round_ns_to_ticks(adv_rd_off);
>> + =A0 =A0 t.oe_on =A0=3D t.adv_on;
>> + =A0 =A0 t.access =3D gpmc_round_ns_to_ticks(access);
>> + =A0 =A0 t.oe_off =3D gpmc_round_ns_to_ticks(oe_off);
>> + =A0 =A0 t.cs_rd_off =3D gpmc_round_ns_to_ticks(cs_rd_off);
>> + =A0 =A0 t.rd_cycle =A0=3D gpmc_round_ns_to_ticks(rd_cycle);
>> +
>> + =A0 =A0 /* Write */
>> + =A0 =A0 t.adv_wr_off =3D gpmc_round_ns_to_ticks(adv_wr_off);
>> + =A0 =A0 t.we_on =A0=3D t.oe_on;
>> + =A0 =A0 if (cpu_is_omap34xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 t.wr_data_mux_bus =3D gpmc_round_ns_to_tic=
ks(wr_data_mux_bus);
>> + =A0 =A0 =A0 =A0 =A0 =A0 t.wr_access =3D gpmc_round_ns_to_ticks(wr_=
access);
>> + =A0 =A0 }
>> + =A0 =A0 t.we_off =3D gpmc_round_ns_to_ticks(we_off);
>> + =A0 =A0 t.cs_wr_off =3D gpmc_round_ns_to_ticks(cs_wr_off);
>> + =A0 =A0 t.wr_cycle =A0=3D gpmc_round_ns_to_ticks(wr_cycle);
>> +
>> + =A0 =A0 /* Configure GPMC */
>> + =A0 =A0 gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CONFIG1_DEVICESIZE(gp=
mc_nand_data->devsize) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CONFIG1_DEVICETYPE_NA=
ND);
>> +
>> + =A0 =A0 err =3D gpmc_cs_set_timings(cs, &t);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 return 0;
>> +}
>
> How about allow passing timings from board-*.c file? This most likely=
 will
> work with only one type of NAND chip.

Yeah, but since we are passing platform data from board-*-flash.c, it
will make sense to pass timings from there. Anyway, in case a board
has different chip, board can have its own board-*-flash.c file.

>
>> +static int gpmc_nand_setup(void __iomem *nand_base)
>> +{
>> + =A0 =A0 struct device *dev =3D &gpmc_nand_device.dev;
>> +
>> + =A0 =A0 /* Set timings in GPMC */
>> + =A0 =A0 if (omap2_nand_gpmc_config(gpmc_nand_data->cs, nand_base) =
< 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to set gpmc timings\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_dat=
a)
>> +{
>> + =A0 =A0 unsigned int val;
>> + =A0 =A0 int err =3D 0;
>> + =A0 =A0 struct device *dev =3D &gpmc_nand_device.dev;
>> +
>> + =A0 =A0 gpmc_nand_data =3D _nand_data;
>> + =A0 =A0 gpmc_nand_data->nand_setup =3D gpmc_nand_setup;
>> + =A0 =A0 gpmc_nand_device.dev.platform_data =3D gpmc_nand_data;
>> +
>> + =A0 =A0 err =3D gpmc_nand_setup(gpmc_nand_data->gpmc_cs_baseaddr);
>> + =A0 =A0 if (err < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "NAND platform setup failed: =
%d\n", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Enable RD PIN Monitoring Reg */
>> + =A0 =A0 if (gpmc_nand_data->dev_ready) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =A0=3D gpmc_cs_read_reg(gpmc_nand_data=
->cs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0GPMC_CS_CONFIG1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 val |=3D WR_RD_PIN_MONITORING;
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(gpmc_nand_data->cs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 GPMC_CS_CONFIG1, val);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 err =3D platform_device_register(&gpmc_nand_device);
>> + =A0 =A0 if (err < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to register NAND devi=
ce\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>
> Looks like nothing is calling gpmc_nand_init. Please provide patches =
to
> convert the users to call gpmc_nand_init.

I was planning to post patches for sdp and zoom boards to enable nand
separately in patch sets.
But now I'll post sdp patches along with this patch in a single patch s=
et.

>
> And while at it, please fix the driver to call gpmc_cs_request.

OK. I'll do it.

Regards,
vimal

>
> Regards,
>
> Tony
>
>
>> diff --git a/arch/arm/plat-omap/include/plat/nand.h
>> b/arch/arm/plat-omap/include/plat/nand.h
>> index 631a7be..2ba9842 100644
>> --- a/arch/arm/plat-omap/include/plat/nand.h
>> +++ b/arch/arm/plat-omap/include/plat/nand.h
>> @@ -21,4 +21,10 @@ struct omap_nand_platform_data {
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_channel;
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_cs_baseaddr;
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_baseaddr;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devsize;
>> =A0};
>> +
>> +/* size (4 KiB) for IO mapping */
>> +#define =A0 =A0 =A0NAND_IO_SIZE =A0 =A0SZ_4K
>> +
>> +extern int gpmc_nand_init(struct omap_nand_platform_data *d);
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index 7df303a..af028f7 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -30,12 +30,8 @@
>>
>> =A0#define =A0 =A0 =A0DRIVER_NAME =A0 =A0 "omap2-nand"
>>
>> -/* size (4 KiB) for IO mapping */
>> -#define =A0 =A0 =A0NAND_IO_SIZE =A0 =A0SZ_4K
>> -
>> =A0#define =A0 =A0 =A0NAND_WP_OFF =A0 =A0 0
>> =A0#define NAND_WP_BIT =A00x00000010
>> -#define WR_RD_PIN_MONITORING 0x00600000
>>
>> =A0#define =A0 =A0 =A0GPMC_BUF_FULL =A0 0x00000001
>> =A0#define =A0 =A0 =A0GPMC_BUF_EMPTY =A00x00000000
>> @@ -885,8 +881,6 @@ static int __devinit omap_nand_probe(struct
>> =A0 =A0 =A0 struct omap_nand_info =A0 =A0 =A0 =A0 =A0 *info;
>> =A0 =A0 =A0 struct omap_nand_platform_data =A0*pdata;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 err;
>> - =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val;
>> -
>>
>> =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 if (pdata =3D=3D NULL) {
>> @@ -913,24 +907,15 @@ static int __devinit omap_nand_probe(struct
>> =A0 =A0 =A0 info->mtd.name =A0 =A0 =A0 =A0 =A0=3D dev_name(&pdev->de=
v);
>> =A0 =A0 =A0 info->mtd.owner =A0 =A0 =A0 =A0 =3D THIS_MODULE;
>>
>> + =A0 =A0 info->nand.options =A0 =A0 =A0|=3D pdata->devsize ? NAND_B=
USWIDTH_16 : 0;
>> + =A0 =A0 info->nand.options =A0 =A0 =A0|=3D NAND_SKIP_BBTSCAN;
>> +
>> =A0 =A0 =A0 err =3D gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, &in=
fo->phys_base);
>> =A0 =A0 =A0 if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot request GPMC=
 CS\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_info;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /* Enable RD PIN Monitoring Reg */
>> - =A0 =A0 if (pdata->dev_ready) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 val =A0=3D gpmc_cs_read_reg(info->gpmc_cs,=
 GPMC_CS_CONFIG1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 val |=3D WR_RD_PIN_MONITORING;
>> - =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_C=
ONFIG1, val);
>> - =A0 =A0 }
>> -
>> - =A0 =A0 val =A0=3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG7=
);
>> - =A0 =A0 val &=3D ~(0xf << 8);
>> - =A0 =A0 val |=3D =A0(0xc & 0xf) << 8;
>> - =A0 =A0 gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
>> -
>> =A0 =A0 =A0 /* NAND write protect off */
>> =A0 =A0 =A0 omap_nand_wp(&info->mtd, NAND_WP_OFF);
>>
>> @@ -966,11 +951,6 @@ static int __devinit omap_nand_probe(struct
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand.chip_delay =3D 50;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 info->nand.options =A0|=3D NAND_SKIP_BBTSCAN;
>> - =A0 =A0 if ((gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1) & 0x=
3000)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D 0x1000)
>> - =A0 =A0 =A0 =A0 =A0 =A0 info->nand.options =A0|=3D NAND_BUSWIDTH_1=
6;
>> -
>> =A0 =A0 =A0 if (use_prefetch) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* copy the virtual address of nand base=
 for fifo access */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->nand_pref_fifo_add =3D info->nand.=
IO_ADDR_R;
>> --
>> 1.5.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
