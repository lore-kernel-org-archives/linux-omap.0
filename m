From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/4]: OMAP: ZOOM: Introducing 'board-zoom-flash.c' for
	NAND init in ZOOM boards
Date: Thu, 3 Dec 2009 18:06:30 +0200
Message-ID: <6ed0b2680912030806n5bd6a358g640ec5e93accc5a8@mail.gmail.com>
References: <ce9ab5790912030615m37535ec2sdcc4ec9723f0f2f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:32777 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZLCQG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 11:06:27 -0500
Received: by ewy2 with SMTP id 2so688565ewy.28
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 08:06:32 -0800 (PST)
In-Reply-To: <ce9ab5790912030615m37535ec2sdcc4ec9723f0f2f2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, Dec 3, 2009 at 4:15 PM, Vimal Singh <vimal.newwork@gmail.com> w=
rote:
> From 948584f4157a9eb99ba085968d23add28cbfd160 Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 1 Dec 2009 11:36:56 +0530
> Subject: [PATCH] OMAP: ZOOM: Introducing 'board-zoom-flash.c'
>
> This patch adds 'board-zoom-flash.c', which could be utilized
> by boards similar to ZOOM2. (For ex: LDP, ZOOM2, ZOOM3).

So it's not really zoom specific, i.e. can be used by other boards
with NAND like beagleboard and pandora? If that's the case, perhaps
the file could be named something like omap3-nand.c or simply just
nand.c .

>
> This does initialization for NAND device based on the 'cs' number
> and partition information passed from board file (ex: board-zoom2.c).
>
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 =A0| =A0 59 +++=
++++++++++++++++++++++
> =A0arch/arm/mach-omap2/include/mach/board-zoom.h | =A0 11 +++++
> =A02 files changed, 70 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
>
> diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
> b/arch/arm/mach-omap2/board-zoom-flash.c
> new file mode 100644
> index 0000000..b3e66ca
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-zoom-flash.c
> @@ -0,0 +1,59 @@
> +/*
> + * board-zoom-flash.c
> + *
> + * Copyright (C) 2009 Texas Instruments Inc.
> + * Vimal Singh <vimalsingh@ti.com>
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
> +#include <linux/mtd/nand.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +
> +#include <asm/mach/flash.h>
> +#include <plat/board.h>
> +#include <plat/gpmc.h>
> +#include <plat/nand.h>
> +
> +#include <mach/board-zoom.h>
> +
> +#if defined(CONFIG_MTD_NAND_OMAP2) || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 defined(CONFIG_MTD_NAND_OMAP2_MODULE)
> +/* NAND chip access: 16 bit */
> +static struct omap_nand_platform_data zoom_nand_data =3D {
> + =A0 =A0 =A0 .nand_setup =A0 =A0 =3D NULL,
> + =A0 =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 /* disable DMA in OMAP =
NAND driver */
> + =A0 =A0 =A0 .dev_ready =A0 =A0 =A0=3D NULL,
> + =A0 =A0 =A0 .devsize =A0 =A0 =A0 =A0=3D 1, =A0 =A0/* '0' for 8-bit,=
 '1' for 16-bit device */
> +};
> +
> +/**
> + * zoom_flash_init - Identify devices connected to GPMC and register=
=2E
> + *
> + * @return - void.
> + */
> +void __init zoom_flash_init(struct flash_partitions zoom_nand_parts[=
], int cs)
> +{
> + =A0 =A0 =A0 u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
> +
> + =A0 =A0 =A0 zoom_nand_data.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D cs;
> + =A0 =A0 =A0 zoom_nand_data.parts =A0 =A0 =A0 =A0 =A0 =A0=3D zoom_na=
nd_parts[0].parts;
> + =A0 =A0 =A0 zoom_nand_data.nr_parts =A0 =A0 =A0 =A0 =3D zoom_nand_p=
arts[0].nr_parts;
> + =A0 =A0 =A0 zoom_nand_data.gpmc_baseaddr =A0 =A0=3D (void *)(gpmc_b=
ase_add);
> + =A0 =A0 =A0 zoom_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_base_=
add +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS0_BASE +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 cs * GPMC_CS_SIZE);
> + =A0 =A0 =A0 gpmc_nand_init(&zoom_nand_data);
> +}
> +#else
> +void __init zoom_flash_init(struct flash_partitions zoom_nand_parts[=
], int cs)
> +{
> +}
> +#endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
> +
> diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h
> b/arch/arm/mach-omap2/include/mach/board-zoom.h
> index c93b29e..f4469d3 100644
> --- a/arch/arm/mach-omap2/include/mach/board-zoom.h
> +++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
> @@ -1,5 +1,16 @@
> =A0/*
> =A0* Defines for zoom boards
> =A0*/
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +
> +struct flash_partitions {
> + =A0 =A0 =A0 struct mtd_partition *parts;
> + =A0 =A0 =A0 int nr_parts;
> +};
> +
> +#define ZOOM_NAND_CS =A0 0
> +
> +extern void __init zoom_flash_init(struct flash_partitions [], int);

These could have their include file, it would be odd to include
board-zoom.h and call zoom_flash_init() for pandora, for example.

> =A0extern int __init zoom_debugboard_init(void);
> =A0extern void __init zoom_peripherals_init(void);
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
