From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v4 1/4] OMAP2/3: Add support for flash on SDP boards
Date: Tue, 10 Nov 2009 11:08:51 +0530
Message-ID: <ce9ab5790911092138o36756fdct4daf845523d29a8@mail.gmail.com>
References: <ce9ab5790910260510g6f2a731fqb87388bd5dee6a84@mail.gmail.com>
	<20091109205128.GA23952@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55337 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZKJFjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 00:39:06 -0500
Received: by bwz27 with SMTP id 27so4211050bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2009 21:39:11 -0800 (PST)
In-Reply-To: <20091109205128.GA23952@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, vimal singh <vimalsingh@ti.com>

On Tue, Nov 10, 2009 at 2:21 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> Hi,
>
> Few comments below.
>
> * Vimal Singh <vimal.newwork@gmail.com> [091026 05:10]:
>> From 92c416f513df62cc0ad75b61639df27f2857b641 Mon Sep 17 00:00:00 20=
01
>> From: Vimal Singh <vimalsingh@ti.com>
>> Date: Mon, 26 Oct 2009 14:24:18 +0530
>> Subject: [PATCH] OMAP2/3: Add support for flash on SDP boards
>>
>> Add support for flash on SDP boards. NAND, NOR and OneNAND
>> are supported.
>>
>> Only tested on 3430SDP (ES2 and ES3.1), somebody please test on
>> 2430SDP and check the chips select for 2430SDP.
>>
>> Also note that:
>> For OneNAND: in the earlier 2430SDP code the kernel partition
>> was set to only 1MB instead of 2MB on 3430SDP. If people want
>> the old partition sizes back on 2430SDP, please provide a patch.
>>
>> For NAND: 'U-Boot', 'Boot Env' and 'Kernel' partitions sizes increas=
ed
>> by few blocks to provide few spare blocks for NAND bab block managem=
ent
>> in u-boot. If people want old partition sizes, please provide a patc=
h.
>>
>> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +
>> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 | =A0327 ++++++=
+++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/board-sdp.h | =A0 15 ++
>> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 =A0| =A0 =A02 +
>> =A06 files changed, 350 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/board-sdp.h
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 03cb4fc..627f500 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -53,6 +53,7 @@ obj-$(CONFIG_OMAP_IOMMU) =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 $(iommu-y)
>> =A0obj-$(CONFIG_MACH_OMAP_GENERIC) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D b=
oard-generic.o
>> =A0obj-$(CONFIG_MACH_OMAP_H4) =A0 =A0 =A0 =A0 =A0 +=3D board-h4.o
>> =A0obj-$(CONFIG_MACH_OMAP_2430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D b=
oard-2430sdp.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0board-sdp-flash.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc-twl4030.o
>> =A0obj-$(CONFIG_MACH_OMAP_APOLLON) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D b=
oard-apollon.o
>> =A0obj-$(CONFIG_MACH_OMAP3_BEAGLE) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D b=
oard-omap3beagle.o \
>> @@ -66,6 +67,7 @@ obj-$(CONFIG_MACH_OMAP3EVM) =A0 =A0 =A0 =A0 +=3D b=
oard-omap3evm.o \
>> =A0obj-$(CONFIG_MACH_OMAP3_PANDORA) =A0 =A0 +=3D board-omap3pandora.=
o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc-twl4030.o
>> =A0obj-$(CONFIG_MACH_OMAP_3430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D b=
oard-3430sdp.o \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0board-sdp-flash.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc-twl4030.o
>> =A0obj-$(CONFIG_MACH_NOKIA_N8X0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-n8x0.o
>> =A0obj-$(CONFIG_MACH_NOKIA_RX51) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-rx51.o \
>> diff --git a/arch/arm/mach-omap2/board-2430sdp.c
>> b/arch/arm/mach-omap2/board-2430sdp.c
>> index db9374b..5676ab9 100644
>> --- a/arch/arm/mach-omap2/board-2430sdp.c
>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
>> @@ -38,6 +38,7 @@
>> =A0#include <plat/usb.h>
>> =A0#include <plat/gpmc-smc91x.h>
>>
>> +#include <plat/board-sdp.h>
>> =A0#include "mmc-twl4030.h"
>>
>> =A0#define SDP2430_CS0_BASE =A0 =A0 0x04000000
>> @@ -205,6 +206,7 @@ static void __init omap_2430sdp_init(void)
>> =A0 =A0 =A0 twl4030_mmc_init(mmc);
>> =A0 =A0 =A0 usb_musb_init();
>> =A0 =A0 =A0 board_smc91x_init();
>> + =A0 =A0 sdp_flash_init();
>>
>> =A0 =A0 =A0 /* Turn off secondary LCD backlight */
>> =A0 =A0 =A0 ret =3D gpio_request(SECONDARY_LCD_GPIO, "Secondary LCD =
backlight");
>> diff --git a/arch/arm/mach-omap2/board-3430sdp.c
>> b/arch/arm/mach-omap2/board-3430sdp.c
>> index a3c1271..4497ded 100644
>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>> @@ -41,6 +41,7 @@
>> =A0#include <plat/control.h>
>> =A0#include <plat/gpmc-smc91x.h>
>>
>> +#include <plat/board-sdp.h>
>> =A0#include "sdram-qimonda-hyb18m512160af-6.h"
>> =A0#include "mmc-twl4030.h"
>>
>> @@ -511,6 +512,7 @@ static void __init omap_3430sdp_init(void)
>> =A0 =A0 =A0 omap_serial_init();
>> =A0 =A0 =A0 usb_musb_init();
>> =A0 =A0 =A0 board_smc91x_init();
>> + =A0 =A0 sdp_flash_init();
>> =A0 =A0 =A0 enable_board_wakeup_source();
>> =A0 =A0 =A0 usb_ehci_init(&ehci_pdata);
>> =A0}
>> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
>> b/arch/arm/mach-omap2/board-sdp-flash.c
>> new file mode 100644
>> index 0000000..a19327d
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
>> @@ -0,0 +1,327 @@
>> +/*
>> + * arch/arm/mach-omap2/board-sdp-flash.c
>> + *
>> + * Copyright (C) 2009 Nokia Corporation
>> + * Copyright (C) 2007 Texas Instruments
>> + *
>> + * Modified from mach-omap2/board-3430sdp-flash.c
>> + * Author: Vimal Singh <vimalsingh@ti.com>
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
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/io.h>
>> +
>> +#include <asm/mach/flash.h>
>> +#include <plat/onenand.h>
>> +#include <plat/gpmc.h>
>> +#include <plat/nand.h>
>> +
>> +#define REG_FPGA_REV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x10
>> +#define REG_FPGA_DIP_SWITCH_INPUT2 =A0 0x60
>> +#define MAX_SUPPORTED_GPMC_CONFIG =A0 =A03
>> +
>> +/* various memory sizes */
>> +#define FLASH_SIZE_SDPV1 =A0 =A0 SZ_64M
>> +#define FLASH_SIZE_SDPV2 =A0 =A0 SZ_128M
>> +
>> +#define FLASH_BASE_SDPV1 =A0 =A0 0x04000000 /* NOR flash (64 Meg al=
igned) */
>> +#define FLASH_BASE_SDPV2 =A0 =A0 0x10000000 /* NOR flash (256 Meg a=
ligned) */
>> +
>> +#define DEBUG_BASE =A0 =A0 =A0 =A0 =A0 0x08000000 /* debug board */
>> +
>> +#define PDC_NOR =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define PDC_NAND =A0 =A0 2
>> +#define PDC_ONENAND =A03
>> +#define DBG_MPDB =A0 =A0 4
>> +
>> +/* REVISIT: Does for some x, chip_sel_sdp[x] maches for 2430 SDP ? =
*/
>> +
>> +/* SDP3430 V2 Board CS organization
>> + * Different from SDP3430 V1. Now 4 switches used to specify CS
>> + */
>> +static const unsigned char chip_sel_sdp[][GPMC_CS_NUM] =3D {
>> +/* GPMC CS Indices (ON=3D0, OFF=3D1)*/
>> +/* S8-1 2 3 4 IDX =A0 CS0, =A0 =A0 =A0 CS1, =A0 =A0 =A0CS2 .. =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CS7 =A0*/
>> +/*ON ON ON ON*/{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, =
0},
>> +/*ON ON ON OFF*/{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0,=
 0},
>> +/*ON ON OFF ON */{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0=
, 0},
>> +};
>
> The comments above look confusing, how about this instead:
>
> /*
> =A0* SDP3430 V2 Board CS organization
> =A0* Different from SDP3430 V1. Now 4 switches used to specify CS
> =A0*
> =A0* See also the Switch S8 settings in the comments.
> =A0*
> =A0* REVISIT: Add support for 2430 SDP
> =A0*/
> static const unsigned char chip_sel_sdp[][GPMC_CS_NUM] =3D {
> =A0 =A0 =A0 =A0{ PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0=
 }, /* S8:1111 */
> =A0 =A0 =A0 =A0{ PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0=
 }, /* S8:1110 */
> =A0 =A0 =A0 =A0{ PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0=
 }, /* S8:1101 */
> };

Looks fine to me.

>
>
>> +static struct mtd_partition sdp_nor_partitions[] =3D {
>> + =A0 =A0 /* bootloader (U-Boot, etc) in first sector */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Bootloader-=
NOR",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D SZ_256K,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, /* =
force read-only */
>> + =A0 =A0 },
>> + =A0 =A0 /* bootloader params in the next sector */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Params-NOR"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D SZ_256K,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D 0,
>> + =A0 =A0 },
>> + =A0 =A0 /* kernel */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-NOR"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D SZ_2M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D 0
>> + =A0 =A0 },
>> + =A0 =A0 /* file system */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Filesystem-=
NOR",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_SIZ_=
=46ULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D 0
>> + =A0 =A0 }
>> +};
>> +
>> +static struct flash_platform_data sdp_nor_data =3D {
>> + =A0 =A0 .map_name =A0 =A0 =A0 =3D "cfi_probe",
>> + =A0 =A0 .width =A0 =A0 =A0 =A0 =A0=3D 2,
>> + =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D sdp_nor_partitions,
>> + =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(sdp_nor_partitions),
>> +};
>> +
>> +static struct resource sdp_nor_resource =3D {
>> + =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D 0,
>> + =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
>> +};
>> +
>> +static struct platform_device sdp_nor_device =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omapflash",
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &sdp_no=
r_data,
>> + =A0 =A0 },
>> + =A0 =A0 .num_resources =A0=3D 1,
>> + =A0 =A0 .resource =A0 =A0 =A0 =3D &sdp_nor_resource,
>> +};
>> +
>> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
>> + =A0 =A0 =A0 =A0 =A0 =A0 defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
>> +
>> +static struct mtd_partition board_onenand_partitions[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader-On=
eNAND",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 * 20=
48),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE =A0/=
* force read-only */
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot-OneN=
AND",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 2 * (64 * 20=
48),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE =A0/=
* force read-only */
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot Envi=
ronment-OneNAND",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 1 * (64 * 20=
48),
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-OneN=
AND",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 16 * (64 * 2=
048),
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File System=
-OneNAND",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_SIZ_=
=46ULL,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_onenand_platform_data board_onenand_data =3D {
>> + =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D board_onenand_partitions,
>> + =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(board_onenand_partiti=
ons),
>> + =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 /* disable DMA in OMAP One=
NAND driver */
>> +};
>> +
>> +
>> +static void __init board_onenand_init(void)
>> +{
>> + =A0 =A0 gpmc_onenand_init(&board_onenand_data);
>> +}
>> +
>> +#else
>> +
>> +static inline void board_onenand_init(void)
>> +{
>> +}
>> +#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODU=
LE */
>> +
>> +static struct mtd_partition sdp_nand_partitions[] =3D {
>> + =A0 =A0 /* All the partition sizes are listed in terms of NAND blo=
ck size */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader-NA=
ND",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 * 20=
48),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0=
 =A0 =A0 =A0/* force read-only */
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot-NAND=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x80000 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 10 * (64 * 2=
048),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0=
 =A0 =A0 =A0/* force read-only */
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Boot Env-NA=
ND",
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x1c0000 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 6 * (64 * 20=
48),
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-NAND=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x280000 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 40 * (64 * 2=
048),
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File System=
 - NAND",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_SIZ_=
=46ULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_AP=
PEND, =A0 /* Offset =3D 0x780000 */
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_nand_platform_data sdp_nand_data =3D {
>> + =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D sdp_nand_partitions,
>> + =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(sdp_nand_partitions),
>> + =A0 =A0 .nand_setup =A0 =A0 =3D NULL,
>> + =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disable=
 DMA in OMAP NAND driver */
>> + =A0 =A0 .dev_ready =A0 =A0 =A0=3D NULL,
>> +};
>> +
>> +static struct resource sdp_nand_resource =3D {
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
>> +};
>> +
>> +static struct platform_device sdp_nand_device =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "omap2-nand"=
,
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &sdp_nand_data,
>> + =A0 =A0 },
>> + =A0 =A0 .num_resources =A0=3D 1,
>> + =A0 =A0 .resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &sdp_nand_resour=
ce,
>> +};
>> +
>> +/**
>> + * get_gpmc0_type - Reads the FPGA DIP_SWITCH_INPUT_REGISTER2 to ge=
t
>> + * the various cs values.
>> + */
>> +static u8 get_gpmc0_type(void)
>> +{
>> + =A0 =A0 u8 cs;
>> + =A0 =A0 void __iomem *fpga_map_addr;
>> + =A0 =A0 fpga_map_addr =3D ioremap(DEBUG_BASE, 4096);
>> + =A0 =A0 /* if ioremap does not return a valid pointer, exit */
>
> This seems like an unnecessary comment.

OK. I'll remove this.

>
>
>> + =A0 =A0 if (!fpga_map_addr)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 if (!(__raw_readw(fpga_map_addr + REG_FPGA_REV))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* we dont have an DEBUG FPGA??? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Depend on #defines!! default to strata =
boot return param */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0x0;
>> + =A0 =A0 }
>
> Maybe return -ENODEV here too instead?

In this we still want to go ahead with default strata boot. So,
returning '0' is ok here.

>
>
>> + =A0 =A0 /* S8-DIP-OFF =3D 1, S8-DIP-ON =3D 0 */
>> + =A0 =A0 cs =3D (u8) (__raw_readw(fpga_map_addr + REG_FPGA_DIP_SWIT=
CH_INPUT2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & 0xF);
>
> Do you need the cast here?
>
> Also, generally the hex numbers are written lower case in Linux.

I'll fix these.

>
>
>> + =A0 =A0 /* ES2.0 SDP's onwards 4 dip switches are provided for CS =
*/
>> + =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:4=3DDS-2:0) to (S8-4:1=3DD=
S-2:0) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 8) >> 3) | ((cs & 4) >> 1) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((cs & 2) << 1) | ((cs & 1=
) << 3);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* change (S8-1:3=3DDS-2:0) to (S8-3:1=3DD=
S-2:0) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 cs =3D ((cs & 4) >> 2) | (cs & 2) | ((cs &=
 1) << 2);
>> + =A0 =A0 iounmap(fpga_map_addr);
>> + =A0 =A0 return cs;
>> +}
>> +
>> +/**
>> + * sdp3430_flash_init - Identify devices connected to GPMC and regi=
ster.
>> + *
>> + * @return - void.
>> + */
>> +void __init sdp_flash_init(void)
>> +{
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs =3D 0;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0nandcs =3D GPMC_CS_NUM + 1;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0onenandcs =3D GPMC_CS_NUM + =
1;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0idx;
>> + =A0 =A0 unsigned char =A0 *config_sel =3D NULL;
>> +
>> + =A0 =A0 /* REVISIT: Is this return correct idx for 2430 SDP?
>> + =A0 =A0 =A0* for which cs configuration matches for 2430 SDP?
>> + =A0 =A0 =A0*/
>> + =A0 =A0 idx =3D get_gpmc0_type();
>> + =A0 =A0 if (idx >=3D MAX_SUPPORTED_GPMC_CONFIG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Invalid Chip select Selec=
tion..\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp3430_fl=
ash_init returned with error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>
> In general, you can have multiple format strings to printk:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Some text here "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"with =
more text here\n");
>
> But in this case, how about just use:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "sdp_flash: Invalid ch=
ip select: %d\n", cs);
>

OK.

>> + =A0 =A0 config_sel =3D (unsigned char *)(chip_sel_sdp[idx]);
>
> The casting here should not be needed?

Yes, 'chip_sel_sdp' is of type const.

>
>
>> +
>> + =A0 =A0 /* Configure start address and size of NOR device */
>> + =A0 =A0 if (omap_rev() >=3D OMAP3430_REV_ES1_0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BASE_S=
DPV2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_BASE=
_SDPV2
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV2 - 1;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.start =A0=3D FLASH_BASE_S=
DPV1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nor_resource.end =A0 =A0=3D FLASH_BASE=
_SDPV1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + FLASH_SIZE_SDPV1 - 1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (platform_device_register(&sdp_nor_device) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register NOR de=
vice\n");
>> +
>> + =A0 =A0 while (cs < GPMC_CS_NUM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (config_sel[cs]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PDC_NAND:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nandcs > GPMC_CS_NUM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nandcs =3D=
 cs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PDC_ONENAND:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (onenandcs > GPMC_CS_NU=
M)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 onenandcs =
=3D cs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> + =A0 =A0 =A0 =A0 =A0 =A0 cs++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (onenandcs > GPMC_CS_NUM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OneNAND: Unable to find =
configuration "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " in GPMC\=
n ");
>> + =A0 =A0 } else {
>> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
>> + =A0 =A0 =A0 =A0 =A0 =A0 defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 board_onenand_data.cs =3D onenandcs;
>> +#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODU=
LE */
>> + =A0 =A0 =A0 =A0 =A0 =A0 board_onenand_init();
>> + =A0 =A0 }
>
> To me it the ifdef above is not needed if you pass the cs to the func=
tion:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0board_onenand_init(cs);

OK.

>
>> +
>> + =A0 =A0 if (nandcs > GPMC_CS_NUM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "NAND: Unable to find con=
figuration "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " in GPMC\=
n ");
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nand_data.cs =3D nandcs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nand_data.gpmc_cs_baseaddr =3D (void *=
)(OMAP34XX_GPMC_VIRT +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdp_nand_data.gpmc_baseaddr =3D (void *) (=
OMAP34XX_GPMC_VIRT);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (platform_device_register(&sdp_nand_dev=
ice) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to=
 register NAND device\n");
>> +
>> + =A0 =A0 }
>
> This should be done in gpmc.c instead. If we don't have a function in=
 gpmc.c
> for doing this, let's rather add a function there.

I'll add a new function (board_nand_init) for this.


--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
