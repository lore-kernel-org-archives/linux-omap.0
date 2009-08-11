From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 6/9] OMAP2/3: Add support for flash on SDP boards
Date: Tue, 11 Aug 2009 20:03:42 +0530
Message-ID: <ce9ab5790908110733g6cedd036w792ea7bc30b8e227@mail.gmail.com>
References: <20090811094348.32577.81307.stgit@localhost> <20090811095315.32577.89520.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:46468 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZHKOeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 10:34:07 -0400
Received: by qyk34 with SMTP id 34so3261695qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 07:34:07 -0700 (PDT)
In-Reply-To: <20090811095315.32577.89520.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, Aug 11, 2009 at 3:23 PM, Tony Lindgren<tony@atomide.com> wrote:
> Add support for flash on SDP boards. Currently only onenand
> is supported.
>
> Only tested on 3430SDP, somebody please test on 2430SDP and
> check the chip select for 2430SDP.
>
> Also note that in the earlier 2430SDP code the kernel partition
> was set to only 1MB instead of 2MB on 3430SDP. If people want
> the old partition sizes back on 2430SDP, please provide a patch.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 | =A0 =A02 +
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 | =A0 =A02 +
> =A0arch/arm/mach-omap2/board-sdp-flash.c | =A0 78 +++++++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-omap2/board-sdp.h =A0 =A0 =A0 | =A0 =A09 ++++
> =A05 files changed, 93 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
> =A0create mode 100644 arch/arm/mach-omap2/board-sdp.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 735bae5..2a2361e 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
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
 board-omap3evm.o \
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
>
> =A0obj-$(CONFIG_MACH_NOKIA_RX51) =A0 =A0 =A0 =A0 =A0+=3D board-rx51.o=
 \
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap=
2/board-2430sdp.c
> index 03f0887..bea6f06 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -39,6 +39,7 @@
> =A0#include <mach/gpmc-smc91x.h>
>
> =A0#include "mmc-twl4030.h"
> +#include "board-sdp.h"
>
> =A0#define SDP2430_CS0_BASE =A0 =A0 =A0 0x04000000
> =A0#define SECONDARY_LCD_GPIO =A0 =A0 =A0 =A0 =A0 =A0 147
> @@ -210,6 +211,7 @@ static void __init omap_2430sdp_init(void)
> =A0 =A0 =A0 =A0twl4030_mmc_init(mmc);
> =A0 =A0 =A0 =A0usb_musb_init();
> =A0 =A0 =A0 =A0board_smc91x_init();
> + =A0 =A0 =A0 sdp_flash_init();
>
> =A0 =A0 =A0 =A0/* Turn off secondary LCD backlight */
> =A0 =A0 =A0 =A0ret =3D gpio_request(SECONDARY_LCD_GPIO, "Secondary LC=
D backlight");
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap=
2/board-3430sdp.c
> index 3f5c316..f5c8fa7 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -43,6 +43,7 @@
>
> =A0#include "sdram-qimonda-hyb18m512160af-6.h"
> =A0#include "mmc-twl4030.h"
> +#include "board-sdp.h"
>
> =A0#define CONFIG_DISABLE_HFCLK 1
>
> @@ -494,6 +495,7 @@ static void __init omap_3430sdp_init(void)
> =A0 =A0 =A0 =A0omap_serial_init(&sdp3430_uart_config);
> =A0 =A0 =A0 =A0usb_musb_init();
> =A0 =A0 =A0 =A0board_smc91x_init();
> + =A0 =A0 =A0 sdp_flash_init();
> =A0}
>
> =A0static void __init omap_3430sdp_map_io(void)
> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-om=
ap2/board-sdp-flash.c
> new file mode 100644
> index 0000000..1496d89
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
> @@ -0,0 +1,78 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-sdp-flash.c
> + *
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Copyright (C) 2007 Texas Instruments
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
> +
> +#include <mach/onenand.h>
> +
> +/* REVISIT: Add support for other flash memory types */
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
> + =A0 =A0 =A0 .cs =A0 =A0 =A0 =A0 =A0 =A0 =3D 2, =A0 =A0/* REVISIT: I=
s this the same for 2430 SDP? */

SDP3430 V2 Board CS organization is different from SDP3430 V1. Now 4
dip switches are used to specify CS configuration for flashes.

-vimal


> + =A0 =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D board_onenand_partitions,
> + =A0 =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(board_onenand_part=
itions),
> + =A0 =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 /* disable DMA in OMAP =
OneNAND driver */
> +};
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
> +
> +#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODUL=
E */
> +
> +void __init sdp_flash_init(void)
> +{
> + =A0 =A0 =A0 board_onenand_init();
> +}
> diff --git a/arch/arm/mach-omap2/board-sdp.h b/arch/arm/mach-omap2/bo=
ard-sdp.h
> new file mode 100644
> index 0000000..ad72189
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-sdp.h
> @@ -0,0 +1,9 @@
> +/*
> + * =A0arch/arm/plat-omap/include/mach/board-sdp.h
> + *
> + * =A0Information structures for SDP-specific board config data
> + *
> + * =A0Copyright (C) 2009 Nokia Corporation
> + */
> +
> +extern void sdp_flash_init(void);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
\/ | |\/| /-\ |_

____      __o
------   -\<,
-----  ( )/ ( )
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
