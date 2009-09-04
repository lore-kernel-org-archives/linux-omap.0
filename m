From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH-v2 2/3] OMAP3: Add support for NAND on ZOOM2/LDP boards
Date: Fri, 4 Sep 2009 11:12:26 +0530
Message-ID: <7f9d1ffb0909032242x6330d93h590fcf0e4601a20f@mail.gmail.com>
References: <1252005968-17686-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:33189 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbZIDFmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 01:42:25 -0400
Received: by fxm17 with SMTP id 17so436622fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 03 Sep 2009 22:42:26 -0700 (PDT)
In-Reply-To: <1252005968-17686-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, Vimal Singh <vimalsingh@ti.com>

On Fri, Sep 4, 2009 at 12:56 AM, Vikram Pandita<vikram.pandita@ti.com> =
wrote:
> From: Vimal Singh <vimalsingh@ti.com>
>
> Adding NAND support for ZOOM2 and LDP board. I have tested it for ZOO=
M2
> boards, someone can verify it for LDP, hopefully it should not have a=
ny
> problem.
>
> The size of the U-Boot environment partition was increased to 1.25MB.
>
> Vikram: Changed ldp name to zoom.
> =A0 =A0 =A0 =A0Future boards will be called Zoom2/3/4 etc.
> =A0 =A0 =A0 =A0LDP is a Zoom1. Somhow the LDP name got stuck to that.
>
> Singned-off-by: Vimal Singh <vimalsingh@ti.com>
> Singned-off-by: Vikram Pandita <vikram.pandita@ti.com>

Typo error: Singned -> Signed

> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +
> =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 | =A0196 ++++++=
++++++++++++++++++++
> =A0arch/arm/mach-omap2/board-zoom2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +
> =A0arch/arm/plat-omap/include/mach/board-zoom.h | =A0 36 +++++
> =A0arch/arm/plat-omap/include/mach/nand.h =A0 =A0 =A0 | =A0 =A01 +
> =A06 files changed, 239 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
> =A0create mode 100644 arch/arm/plat-omap/include/mach/board-zoom.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index ebe882b..182861d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_MACH_OMAP_APOLLON) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 +=3D board-apollon.o
> =A0obj-$(CONFIG_MACH_OMAP3_BEAGLE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-omap3beagle.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o
> =A0obj-$(CONFIG_MACH_OMAP_LDP) =A0 =A0 =A0 =A0 =A0 =A0+=3D board-ldp.=
o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0board-zoom-flash.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o
> =A0obj-$(CONFIG_MACH_OVERO) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D board-ov=
ero.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o
> @@ -69,6 +70,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51) =A0 =A0 =A0 =A0 +=3D =
board-rx51.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 board-rx51-peripherals.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o
> =A0obj-$(CONFIG_MACH_OMAP_ZOOM2) =A0 =A0 =A0 =A0 =A0+=3D board-zoom2.=
o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0board-zoom-flash.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 board-zoom-debugboard.o
>
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/bo=
ard-ldp.c
> index 4a4b300..88bd54f 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -42,6 +42,7 @@
> =A0#include <mach/control.h>
> =A0#include <mach/usb.h>
> =A0#include <mach/keypad.h>
> +#include <mach/board-zoom.h>
>
> =A0#include "mmc-twl4030.h"
>
> @@ -385,6 +386,7 @@ static void __init omap_ldp_init(void)
> =A0 =A0 =A0 =A0ads7846_dev_init();
> =A0 =A0 =A0 =A0omap_serial_init(&ldp_uart_config);
> =A0 =A0 =A0 =A0usb_musb_init();
> + =A0 =A0 =A0 zoom_flash_init();
>
> =A0 =A0 =A0 =A0twl4030_mmc_init(mmc);
> =A0 =A0 =A0 =A0/* link regulators to MMC adapters */
> diff --git a/arch/arm/mach-omap2/board-zoom-flash.c b/arch/arm/mach-o=
map2/board-zoom-flash.c
> new file mode 100644
> index 0000000..1007e5d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-zoom-flash.c
> @@ -0,0 +1,196 @@
> +/*
> + * arch/arm/mach-omap2/board-zoom-flash.c
> + *
> + * Copyright (C) 2008-09 Texas Instruments Inc.
> + *
> + * Modified from mach-omap2/board-2430sdp-flash.c
> + * Author(s): Rohit Choraria <rohitkc@ti.com>
> + * =A0 =A0 =A0 =A0 =A0 =A0Vimal Singh <vimalsingh@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +
> +#include <asm/mach/flash.h>
> +#include <mach/board.h>
> +#include <mach/gpmc.h>
> +#include <mach/nand.h>
> +
> +#include <mach/board-zoom.h>
> +
> +#define NAND_CMD_UNLOCK1 =A0 =A0 =A0 0x23
> +#define NAND_CMD_UNLOCK2 =A0 =A0 =A0 0x24
> +/**
> + * @brief platform specific unlock function
> + *
> + * @param mtd - mtd info
> + * @param ofs - offset to start unlock from
> + * @param len - length to unlock
> + *
> + * @return - unlock status
> + */
> +static int omap_zoom_nand_unlock(struct mtd_info *mtd, loff_t ofs, s=
ize_t len)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int chipnr;
> + =A0 =A0 =A0 int status;
> + =A0 =A0 =A0 unsigned long page;
> + =A0 =A0 =A0 struct nand_chip *this =3D mtd->priv;
> + =A0 =A0 =A0 printk(KERN_INFO "nand_unlock: start: %08x, length: %d!=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (int)ofs, (int)len);
> +
> + =A0 =A0 =A0 /* select the NAND device */
> + =A0 =A0 =A0 chipnr =3D (int)(ofs >> this->chip_shift);
> + =A0 =A0 =A0 this->select_chip(mtd, chipnr);
> + =A0 =A0 =A0 /* check the WP bit */
> + =A0 =A0 =A0 this->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
> + =A0 =A0 =A0 if ((this->read_byte(mtd) & 0x80) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Device is=
 write protected!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if ((ofs & (mtd->writesize - 1)) !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Start add=
ress must be"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "beginn=
ing of nand page!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (len =3D=3D 0 || (len & (mtd->writesize - 1)) !=3D 0=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Length mu=
st be a multiple of "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "nand p=
age size!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* submit address of first page to unlock */
> + =A0 =A0 =A0 page =3D (unsigned long)(ofs >> this->page_shift);
> + =A0 =A0 =A0 this->cmdfunc(mtd, NAND_CMD_UNLOCK1, -1, page & this->p=
agemask);
> +
> + =A0 =A0 =A0 /* submit ADDRESS of LAST page to unlock */
> + =A0 =A0 =A0 page +=3D (unsigned long)((ofs + len) >> this->page_shi=
ft) ;
> + =A0 =A0 =A0 this->cmdfunc(mtd, NAND_CMD_UNLOCK2, -1, page & this->p=
agemask);
> +
> + =A0 =A0 =A0 /* call wait ready function */
> + =A0 =A0 =A0 status =3D this->waitfunc(mtd, this);
> + =A0 =A0 =A0 udelay(1000);
> + =A0 =A0 =A0 /* see if device thinks it succeeded */
> + =A0 =A0 =A0 if (status & 0x01) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* there was an error */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: error sta=
tus =3D0x%08x ", status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + out:
> + =A0 =A0 =A0 /* de-select the NAND device */
> + =A0 =A0 =A0 this->select_chip(mtd, -1);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct mtd_partition zoom_nand_partitions[] =3D {
> + =A0 =A0 =A0 /* All the partition sizes are listed in terms of NAND =
block size */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader=
-NAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 *=
 2048), =A0 =A0 =A0/* 512KB, 0x80000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =
=A0 =A0 =A0 =A0/* force read-only */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot-N=
AND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x80000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 10 * (64 =
* 2048), =A0 =A0 /* 1.25MB, 0x140000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =
=A0 =A0 =A0 =A0/* force read-only */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Boot Env=
-NAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x1c0000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 2 * (64 *=
 2048), =A0 =A0 =A0/* 256KB, 0x40000 */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-N=
AND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x0200000*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 240 * (64=
 * 2048), =A0 =A0/* 30M, 0x1E00000 */
> + =A0 =A0 =A0 },
> +#ifdef CONFIG_MACH_OMAP_ZOOM2
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "system",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x2000000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 1280 * (6=
4 * 2048), =A0 /* 160M, 0xA000000 */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "userdata=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0xC000000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 256 * (64=
 * 2048), =A0 =A0/* 32M, 0x2000000 */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "cache",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0xE000000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 256 * (64=
 * 2048), =A0 =A0/* 32M, 0x2000000 */
> + =A0 =A0 =A0 },
> +#else
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File Sys=
tem - NAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x2000000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_S=
IZ_FULL, =A0 =A0 /* 96MB, 0x6000000 */
> + =A0 =A0 =A0 },
> +#endif
> +};
> +
> +/* NAND chip access: 16 bit */
> +static struct omap_nand_platform_data zoom_nand_data =3D {
> + =A0 =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D zoom_nand_partitions,
> + =A0 =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(zoom_nand_partitio=
ns),
> + =A0 =A0 =A0 .nand_setup =A0 =A0 =3D NULL,
> + =A0 =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disa=
ble DMA in OMAP NAND driver */
> + =A0 =A0 =A0 .dev_ready =A0 =A0 =A0=3D NULL,
> + =A0 =A0 =A0 .unlock =A0 =A0 =A0 =A0 =3D omap_zoom_nand_unlock,
> +};
> +
> +static struct resource zoom_nand_resource =3D {
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> +};
> +
> +static struct platform_device zoom_nand_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2-nand",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> + =A0 =A0 =A0 .platform_data =A0=3D &zoom_nand_data,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_resources =A0=3D 1,
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D &zoom_nand_resource,
> +};
> +
> +/**
> + * zoom_flash_init - Identify devices connected to GPMC and register=
=2E
> + *
> + * @return - void.
> + */
> +void __init zoom_flash_init(void)
> +{
> + =A0 =A0 =A0 u8 nandcs =3D GPMC_CS_NUM + 1;
> + =A0 =A0 =A0 u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
> +
> + =A0 =A0 =A0 /* pop nand part */
> + =A0 =A0 =A0 nandcs =3D ZOOM_3430_NAND_CS;
> +
> + =A0 =A0 =A0 zoom_nand_data.cs =3D nandcs;
> + =A0 =A0 =A0 zoom_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_base_=
add +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
> + =A0 =A0 =A0 zoom_nand_data.gpmc_baseaddr =3D (void *) (gpmc_base_ad=
d);
> +
> + =A0 =A0 =A0 if (platform_device_register(&zoom_nand_device) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register NAN=
D device\n");
> +}
> +
> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/=
board-zoom2.c
> index 4d295d5..2142198 100644
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -20,6 +20,7 @@
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
>
> +#include <mach/board-zoom.h>
> =A0#include <mach/common.h>
> =A0#include <mach/usb.h>
> =A0#include <mach/keypad.h>
> @@ -271,6 +272,7 @@ static void __init omap_zoom2_init(void)
> =A0 =A0 =A0 =A0omap_serial_init(&zoom2_uart_config);
> =A0 =A0 =A0 =A0omap_zoom2_debugboard_init();
> =A0 =A0 =A0 =A0usb_musb_init();
> + =A0 =A0 =A0 zoom_flash_init();
> =A0}
>
> =A0static void __init omap_zoom2_map_io(void)
> diff --git a/arch/arm/plat-omap/include/mach/board-zoom.h b/arch/arm/=
plat-omap/include/mach/board-zoom.h
> new file mode 100644
> index 0000000..af8850c
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/board-zoom.h
> @@ -0,0 +1,36 @@
> +/*
> + * arch/arm/plat-omap/include/mach/board-zoom.h
> + *
> + * Hardware definitions for TI OMAP3 LDP/ZOOM2.
> + *
> + * Copyright (C) 2008-09 Texas Instruments Inc.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + *
> + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES=
 OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIM=
ED. IN
> + * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDI=
NG, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS=
 OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED A=
ND ON
> + * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, O=
R TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=
 USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __ASM_ARCH_OMAP_LDP_H
> +#define __ASM_ARCH_OMAP_LDP_H
> +
> +extern void zoom_flash_init(void);
> +
> +#define ZOOM_3430_NAND_CS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> +
> +#endif /* __ASM_ARCH_OMAP_LDP_H */
> diff --git a/arch/arm/plat-omap/include/mach/nand.h b/arch/arm/plat-o=
map/include/mach/nand.h
> index 631a7be..6151985 100644
> --- a/arch/arm/plat-omap/include/mach/nand.h
> +++ b/arch/arm/plat-omap/include/mach/nand.h
> @@ -18,6 +18,7 @@ struct omap_nand_platform_data {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_parts;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*nand_set=
up)(void __iomem *);
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*dev_read=
y)(struct omap_nand_platform_data *);
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*unlock)(s=
truct mtd_info *, loff_t, size_t);
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_channe=
l;
> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_cs_baseaddr;
> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*gpmc_baseaddr;
> --
> 1.6.3.3.334.g916e1
>
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
