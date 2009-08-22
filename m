From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP2/3: Add support for flash on SDP boards
Date: Sat, 22 Aug 2009 12:27:03 +0530
Message-ID: <ce9ab5790908212357o67160b13gb17e864abc33dfee@mail.gmail.com>
References: <47139.192.168.10.88.1250657068.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:49111 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933225AbZHVG5W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 02:57:22 -0400
Received: by qw-out-2122.google.com with SMTP id 8so750097qwh.37
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2009 23:57:23 -0700 (PDT)
In-Reply-To: <47139.192.168.10.88.1250657068.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, vimal singh <vimalsingh@ti.com>

Hi Tony,

Are you OK with below patch? I have not received any comment yet.

In case this patch is OK, can you please push it?

-vimal

On Wed, Aug 19, 2009 at 10:14 AM, vimal singh<vimalsingh@ti.com> wrote:
> Add support for flash on SDP boards. NAND, NOR and OneNAND
> are supported.
>
> Only tested on 3430SDP (ES2 and ES3.1), somebody please test on
> 2430SDP and check the chips select for 2430SDP.
>
> Also note that:
> For OneNAND: in the earlier 2430SDP code the kernel partition
> was set to only 1MB instead of 2MB on 3430SDP. If people want
> the old partition sizes back on 2430SDP, please provide a patch.
>
> For NAND: 'U-Boot', 'Boot Env' and 'Kernel' partitions sizes increase=
d
> by few blocks to provide few spare blocks for NAND bab block manageme=
nt
> in u-boot. If people want old partition sizes, please provide a patch=
=2E
>
>
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02
> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0| =A0 =A02
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0| =A0 =A02
> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0| =A0326 ++++++++++++++++=
+++++++++++++++++
> =A0arch/arm/mach-omap2/board-sdp.h =A0 =A0 =A0 =A0| =A0 15 +
> =A0arch/arm/plat-omap/include/mach/gpmc.h | =A0 =A02
> =A06 files changed, 349 insertions(+)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile
> +++ linux-omap-2.6/arch/arm/mach-omap2/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_OMAP_IOMMU) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+=3D $(iommu-y)
> =A0obj-$(CONFIG_MACH_OMAP_GENERIC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-generic.o
> =A0obj-$(CONFIG_MACH_OMAP_H4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D board-h4.o
> =A0obj-$(CONFIG_MACH_OMAP_2430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-2430sdp.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0board-sdp-flash.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o
> =A0obj-$(CONFIG_MACH_OMAP_APOLLON) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-apollon.o
> =A0obj-$(CONFIG_MACH_OMAP3_BEAGLE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-omap3beagle.o \
> @@ -61,6 +62,7 @@ obj-$(CONFIG_MACH_OMAP3EVM) =A0 =A0 =A0 =A0 =A0 +=3D=
 board-om
> =A0obj-$(CONFIG_MACH_OMAP3_PANDORA) =A0 =A0 =A0 +=3D board-omap3pando=
ra.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o
> =A0obj-$(CONFIG_MACH_OMAP_3430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-3430sdp.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0board-sdp-flash.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc-twl4030.o
> =A0obj-$(CONFIG_MACH_NOKIA_N8X0) =A0 =A0 =A0 =A0 =A0+=3D board-n8x0.o
> =A0obj-$(CONFIG_MACH_NOKIA_RX51) =A0 =A0 =A0 =A0 =A0+=3D board-rx51.o=
 \
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c
> @@ -38,6 +38,7 @@
> =A0#include <mach/usb.h>
> =A0#include <mach/gpmc-smc91x.h>
>
> +#include "board-sdp.h"
> =A0#include "mmc-twl4030.h"
>
> =A0#define SDP2430_CS0_BASE =A0 =A0 =A0 0x04000000
> @@ -210,6 +211,7 @@ static void __init omap_2430sdp_init(voi
> =A0 =A0 =A0 =A0twl4030_mmc_init(mmc);
> =A0 =A0 =A0 =A0usb_musb_init();
> =A0 =A0 =A0 =A0board_smc91x_init();
> + =A0 =A0 =A0 sdp_flash_init();
>
> =A0 =A0 =A0 =A0/* Turn off secondary LCD backlight */
> =A0 =A0 =A0 =A0ret =3D gpio_request(SECONDARY_LCD_GPIO, "Secondary LC=
D backlight");
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
> @@ -41,6 +41,7 @@
> =A0#include <mach/keypad.h>
> =A0#include <mach/gpmc-smc91x.h>
>
> +#include "board-sdp.h"
> =A0#include "sdram-qimonda-hyb18m512160af-6.h"
> =A0#include "mmc-twl4030.h"
>
> @@ -494,6 +495,7 @@ static void __init omap_3430sdp_init(voi
> =A0 =A0 =A0 =A0omap_serial_init(&sdp3430_uart_config);
> =A0 =A0 =A0 =A0usb_musb_init();
> =A0 =A0 =A0 =A0board_smc91x_init();
> + =A0 =A0 =A0 sdp_flash_init();
> =A0 =A0 =A0 =A0usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, =
61);
> =A0}
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-sdp-flash.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-sdp-flash.c
> @@ -0,0 +1,326 @@
> +/*
> + * arch/arm/mach-omap2/board-sdp-flash.c
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * Modified from mach-omap2/board-3430sdp-flash.c
> + * Author: Vimal Singh <vimalsingh@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/io.h>
> +
> +#include <asm/mach/flash.h>
> +#include <mach/onenand.h>
> +#include <mach/gpmc.h>
> +#include <mach/nand.h>
> +
> +#define REG_FPGA_REV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x10
> +#define REG_FPGA_DIP_SWITCH_INPUT2 =A0 =A0 0x60
> +#define MAX_SUPPORTED_GPMC_CONFIG =A0 =A0 =A03
> +
> +/* various memory sizes */
> +#define FLASH_SIZE_SDPV1 =A0 =A0 =A0 SZ_64M
> +#define FLASH_SIZE_SDPV2 =A0 =A0 =A0 SZ_128M
> +
> +#define FLASH_BASE_SDPV1 =A0 =A0 =A0 0x04000000 /* NOR flash (64 Meg=
 aligned) */
> +#define FLASH_BASE_SDPV2 =A0 =A0 =A0 0x10000000 /* NOR flash (256 Me=
g aligned) */
> +
> +#define DEBUG_BASE =A0 =A0 =A0 =A0 =A0 =A0 0x08000000 /* debug board=
 */
> +
> +#define PDC_NOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +#define PDC_NAND =A0 =A0 =A0 2
> +#define PDC_ONENAND =A0 =A03
> +#define DBG_MPDB =A0 =A0 =A0 4
> +
> +/* REVISIT: Does for some x, chip_sel_sdp[x] maches for 2430 SDP ? *=
/
> +
> +/* SDP3430 V2 Board CS organization
> + * Different from SDP3430 V1. Now 4 switches used to specify CS
> + */
> +static const unsigned char chip_sel_sdp[][GPMC_CS_NUM] =3D {
> +/* GPMC CS Indices (ON=3D0, OFF=3D1)*/
> +/* S8-1 2 3 4 IDX =A0 CS0, =A0 =A0 =A0 CS1, =A0 =A0 =A0CS2 .. =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CS7 =A0*/
> +/*ON ON ON ON*/{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0=
},
> +/*ON ON ON OFF*/{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, =
0},
> +/*ON ON OFF ON */{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0,=
 0},
> +};
> +
> +static struct mtd_partition sdp_nor_partitions[] =3D {
> + =A0 =A0 =A0 /* bootloader (U-Boot, etc) in first sector */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Bootload=
er-NOR",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D SZ_256K,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =
/* force read-only */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 /* bootloader params in the next sector */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Params-N=
OR",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D SZ_256K,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D 0,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 /* kernel */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-N=
OR",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D SZ_2M,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D 0
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 /* file system */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Filesyst=
em-NOR",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_S=
IZ_FULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D 0
> + =A0 =A0 =A0 }
> +};
> +
> +static struct flash_platform_data sdp_nor_data =3D {
> + =A0 =A0 =A0 .map_name =A0 =A0 =A0 =3D "cfi_probe",
> + =A0 =A0 =A0 .width =A0 =A0 =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D sdp_nor_partitions,
> + =A0 =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(sdp_nor_partitions=
),
> +};
> +
> +static struct resource sdp_nor_resource =3D {
> + =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D 0,
> + =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> +};
> +
> +static struct platform_device sdp_nor_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omapflash",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &sdp=
_nor_data,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_resources =A0=3D 1,
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D &sdp_nor_resource,
> +};
> +
> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 defined(CONFIG_MTD_ONENAND_OMAP2_MODULE=
)
> +
> +static struct mtd_partition board_onenand_partitions[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader=
-OneNAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 *=
 2048),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE =A0=
/* force read-only */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot-O=
neNAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 2 * (64 *=
 2048),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE =A0=
/* force read-only */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot E=
nvironment-OneNAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 1 * (64 *=
 2048),
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-O=
neNAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 16 * (64 =
* 2048),
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File Sys=
tem-OneNAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_S=
IZ_FULL,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct omap_onenand_platform_data board_onenand_data =3D {
> + =A0 =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D board_onenand_partitions,
> + =A0 =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(board_onenand_part=
itions),
> + =A0 =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 /* disable DMA in OMAP =
OneNAND driver */
> +};
> +
> +
> +static void __init board_onenand_init(void)
> +{
> + =A0 =A0 =A0 gpmc_onenand_init(&board_onenand_data);
> +}
> +
> +#else
> +
> +static inline void board_onenand_init(void)
> +{
> +}
> +#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODUL=
E */
> +
> +static struct mtd_partition sdp_nand_partitions[] =3D {
> + =A0 =A0 =A0 /* All the partition sizes are listed in terms of NAND =
block size */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader=
-NAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 *=
 2048),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =
=A0 =A0 =A0 =A0/* force read-only */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot-N=
AND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x80000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 10 * (64 =
* 2048),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =
=A0 =A0 =A0 =A0/* force read-only */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Boot Env=
-NAND",
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x1c0000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 6 * (64 *=
 2048),
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-N=
AND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x280000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 40 * (64 =
* 2048),
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File Sys=
tem - NAND",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_S=
IZ_FULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS=
_APPEND, =A0 /* Offset =3D 0x780000 */
> + =A0 =A0 =A0 },
> +};
> +
> +static struct omap_nand_platform_data sdp_nand_data =3D {
> + =A0 =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D sdp_nand_partitions,
> + =A0 =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(sdp_nand_partition=
s),
> + =A0 =A0 =A0 .nand_setup =A0 =A0 =3D NULL,
> + =A0 =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disa=
ble DMA in OMAP NAND driver */
> + =A0 =A0 =A0 .dev_ready =A0 =A0 =A0=3D NULL,
> +};
> +
> +static struct resource sdp_nand_resource =3D {
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> +};
> +
> +static struct platform_device sdp_nand_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "omap2-na=
nd",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &sdp_nand_data,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_resources =A0=3D 1,
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &sdp_nand_res=
ource,
> +};
> +
> +/**
> + * get_gpmc0_type - Reads the FPGA DIP_SWITCH_INPUT_REGISTER2 to get
> + * the various cs values.
> + */
> +static u8 get_gpmc0_type(void)
> +{
> + =A0 =A0 =A0 u8 cs;
> + =A0 =A0 =A0 void __iomem *fpga_map_addr;
> + =A0 =A0 =A0 fpga_map_addr =3D ioremap(DEBUG_BASE, 4096);
> + =A0 =A0 =A0 /* if ioremap does not return a valid pointer, exit */
> + =A0 =A0 =A0 if (!fpga_map_addr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we dont have an DEBUG FPGA??? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Depend on #defines!! default to stra=
ta boot return param */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0x0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* S8-DIP-OFF =3D 1, S8-DIP-ON =3D 0 */
> + =A0 =A0 =A0 cs =3D (u8) (__raw_readw(fpga_map_addr + REG_FPGA_DIP_S=
WITCH_INPUT2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & 0xF);
> + =A0 =A0 =A0 /* ES2.0 SDP's onwards 4 dip switches are provided for =
CS */
> + =A0 =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:4=3DDS-2:0) to (S8-4:1=3D=
DS-2:0) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 8) >> 3) | ((cs & 4) >> 1=
) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((cs & 2) << 1) | ((cs =
& 1) << 3);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:3=3DDS-2:0) to (S8-3:1=3D=
DS-2:0) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 4) >> 2) | (cs & 2) | ((c=
s & 1) << 2);
> + =A0 =A0 =A0 iounmap(fpga_map_addr);
> + =A0 =A0 =A0 return cs;
> +}
> +
> +/**
> + * sdp3430_flash_init - Identify devices connected to GPMC and regis=
ter.
> + *
> + * @return - void.
> + */
> +void __init sdp_flash_init(void)
> +{
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs =3D 0;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0nandcs =3D GPMC_CS_NUM + =
1;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0onenandcs =3D GPMC_CS_NUM=
 + 1;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0idx;
> + =A0 =A0 =A0 unsigned char =A0 *config_sel =3D NULL;
> +
> + =A0 =A0 =A0 /* REVISIT: Is this return correct idx for 2430 SDP?
> + =A0 =A0 =A0 =A0* for which cs configuration matches for 2430 SDP?
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 idx =3D get_gpmc0_type();
> + =A0 =A0 =A0 if (idx >=3D MAX_SUPPORTED_GPMC_CONFIG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Invalid Chip select Se=
lection..\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp3430=
_flash_init returned with error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 config_sel =3D (unsigned char *)(chip_sel_sdp[idx]);
> +
> + =A0 =A0 =A0 /* Configure start address and size of NOR device */
> + =A0 =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BAS=
E_SDPV2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_B=
ASE_SDPV2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV2 - 1;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BAS=
E_SDPV1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_B=
ASE_SDPV1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV1 - 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (platform_device_register(&sdp_nor_device) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register NOR=
 device\n");
> +
> + =A0 =A0 =A0 while (cs < GPMC_CS_NUM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (config_sel[cs]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PDC_NAND:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nandcs > GPMC_CS_NU=
M)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nandcs =
=3D cs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PDC_ONENAND:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (onenandcs > GPMC_CS=
_NUM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 onenand=
cs =3D cs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (onenandcs > GPMC_CS_NUM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OneNAND: Unable to fi=
nd configuration "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " in GP=
MC\n ");
> + =A0 =A0 =A0 } else {
> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 defined(CONFIG_MTD_ONENAND_OMAP2_MODULE=
)
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 board_onenand_data.cs =3D onenandcs;
> +#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODUL=
E */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 board_onenand_init();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (nandcs > GPMC_CS_NUM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "NAND: Unable to find =
configuration "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " in GP=
MC\n ");
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_nand_data.cs =3D nandcs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_nand_data.gpmc_cs_baseaddr =3D (voi=
d *)(OMAP34XX_GPMC_VIRT +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_nand_data.gpmc_baseaddr =3D (void *=
) (OMAP34XX_GPMC_VIRT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (platform_device_register(&sdp_nand_=
device) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable=
 to register NAND device\n");
> +
> + =A0 =A0 =A0 }
> +}
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-sdp.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-sdp.h
> @@ -0,0 +1,15 @@
> +/*
> + * =A0arch/arm/plat-omap/include/mach/board-sdp.h
> + *
> + * =A0Information structures for SDP-specific board config data
> + *
> + * =A0Copyright (C) 2009 Nokia Corporation
> + * =A0Copyright (C) 2009 Texas Instruments
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +extern void sdp_flash_init(void);
> +
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/gpmc.h
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h
> @@ -27,6 +27,8 @@
>
> =A0#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A0 =A00x50
> =A0#define GPMC_STATUS =A0 =A0 =A0 =A0 =A0 =A00x54
> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A00x60
> +#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 =A0 0x30
>
> =A0#define GPMC_CONFIG1_WRAPBURST_SUPP =A0 =A0 (1 << 31)
> =A0#define GPMC_CONFIG1_READMULTIPLE_SUPP =A0(1 << 30)
>
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
