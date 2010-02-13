From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v2 1/3] OMAP: ZOOM: Introducing 'board-zoom-flash.c'
Date: Sat, 13 Feb 2010 15:12:39 +0530
Message-ID: <ce9ab5791002130142p7f57ce1bwe33a650e3de3464d@mail.gmail.com>
References: <ce9ab5791002102119k6eb32e97gfac21762a71843f3@mail.gmail.com>
	<20100211204703.GI21755@atomide.com> <20100211211914.GJ21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:60009 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab0BMJnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Feb 2010 04:43:06 -0500
Received: by bwz22 with SMTP id 22so93606bwz.1
        for <linux-omap@vger.kernel.org>; Sat, 13 Feb 2010 01:43:01 -0800 (PST)
In-Reply-To: <20100211211914.GJ21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Feb 12, 2010 at 2:49 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tony Lindgren <tony@atomide.com> [100211 12:43]:
>> * Vimal Singh <vimal.newwork@gmail.com> [100210 21:16]:
>> > From: Vimal Singh <vimalsingh@ti.com>
>> >
>> > This patch adds 'board-zoom-flash.c', which could be utilized
>> > by boards similar to ZOOM2. (For ex: LDP, ZOOM2, ZOOM3).
>> >
>> > This does initialization for NAND device based on the 'cs' number
>> > and partition information passed from board file (ex: board-zoom2.=
c).
>> >
>> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 =A0| =A0 85 =
+++++++++++++++++++++++++
>> > =A0arch/arm/mach-omap2/include/mach/board-zoom.h | =A0 11 +++
>> > =A02 files changed, 96 insertions(+), 0 deletions(-)
>> > =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
>> >
>> > diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
>> > b/arch/arm/mach-omap2/board-zoom-flash.c
>> > new file mode 100644
>> > index 0000000..f2328a4
>> > --- /dev/null
>> > +++ b/arch/arm/mach-omap2/board-zoom-flash.c
>> > @@ -0,0 +1,85 @@
>> > +/*
>> > + * board-zoom-flash.c
>> > + *
>> > + * Copyright (C) 2009 Texas Instruments Inc.
>> > + * Vimal Singh <vimalsingh@ti.com>
>> > + *
>> > + * This program is free software; you can redistribute it and/or =
modify
>> > + * it under the terms of the GNU General Public License version 2=
 as
>> > + * published by the Free Software Foundation.
>> > + */
>> > +
>> > +#include <linux/kernel.h>
>> > +#include <linux/delay.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/mtd/nand.h>
>> > +#include <linux/types.h>
>> > +#include <linux/io.h>
>> > +
>> > +#include <asm/mach/flash.h>
>> > +#include <plat/board.h>
>> > +#include <plat/gpmc.h>
>> > +#include <plat/nand.h>
>> > +
>> > +#include <mach/board-zoom.h>
>> > +
>> > +#if defined(CONFIG_MTD_NAND_OMAP2) || \
>> > + =A0 =A0 =A0 =A0 =A0 defined(CONFIG_MTD_NAND_OMAP2_MODULE)
>> > +
>> > +/* Note that all values in this struct are in nanoseconds */
>> > +static struct gpmc_timings nand_timings =3D {
>> > +
>> > + =A0 .sync_clk =3D 0,
>> > +
>> > + =A0 .cs_on =3D 0,
>> > + =A0 .cs_rd_off =3D 36,
>> > + =A0 .cs_wr_off =3D 36,
>> > +
>> > + =A0 .adv_on =3D 6,
>> > + =A0 .adv_rd_off =3D 24,
>> > + =A0 .adv_wr_off =3D 36,
>> > +
>> > + =A0 .we_off =3D 30,
>> > + =A0 .oe_off =3D 48,
>> > +
>> > + =A0 .access =3D 54,
>> > + =A0 .rd_cycle =3D 72,
>> > + =A0 .wr_cycle =3D 72,
>> > +
>> > + =A0 .wr_access =3D 30,
>> > + =A0 .wr_data_mux_bus =3D 0,
>> > +};
>> > +
>> > +/* NAND chip access: 16 bit */
>> > +static struct omap_nand_platform_data zoom_nand_data =3D {
>> > + =A0 .nand_setup =A0 =A0 =3D NULL,
>> > + =A0 .gpmc_t =A0 =A0 =A0 =A0 =3D &nand_timings,
>> > + =A0 .dma_channel =A0 =A0=3D -1, =A0 /* disable DMA in OMAP NAND =
driver */
>> > + =A0 .dev_ready =A0 =A0 =A0=3D NULL,
>> > + =A0 .devsize =A0 =A0 =A0 =A0=3D 1, =A0 =A0/* '0' for 8-bit, '1' =
for 16-bit device */
>> > +};
>> > +
>> > +/**
>> > + * zoom_flash_init - Identify devices connected to GPMC and regis=
ter.
>> > + *
>> > + * @return - void.
>> > + */
>> > +void __init zoom_flash_init(struct flash_partitions zoom_nand_par=
ts[], int cs)
>> > +{
>> > + =A0 u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
>> > +
>> > + =A0 zoom_nand_data.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D cs;
>> > + =A0 zoom_nand_data.parts =A0 =A0 =A0 =A0 =A0 =A0=3D zoom_nand_pa=
rts[0].parts;
>> > + =A0 zoom_nand_data.nr_parts =A0 =A0 =A0 =A0 =3D zoom_nand_parts[=
0].nr_parts;
>> > + =A0 zoom_nand_data.gpmc_baseaddr =A0 =A0=3D (void *)(gpmc_base_a=
dd);
>> > + =A0 zoom_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_base_add +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 GPMC_CS0_BASE +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 cs * GPMC_CS_SIZE);
>>
>> The gpmc_baseaddr and gpmc_cs_baseaddr should no longer be
>> needed with gpmc-nand.c, right?

As said earlier too these are needed by 'nand/omap2.c' driver not for
gpmc.-nand.c, we still need to pass these.

>
> Yeah.. For now, I suggest you set the gpmc_baseaddr and
> gpmc_cs_baseaddr in gpmc_nand_init() based on the results from
> gpmc_cs_request.
>
> That will allow us to remove the insane hardcoded gpmc virtual
> addresses from all board-*.c files.

OK

>
> And then we can finally fix gpmc-nand.c driver not to go tinker
You mean omap2.c nand driver?

> with the GPMC registers directly. All of that should be in
> gpmc-nand.c using gpmc.c. The driver should be just a generic
> NAND driver.

Yes, but that will take complete clean-up of omap2.c nand driver by
moving all functions accessing GPMC registers from 'nand/omap2.c' to
'gpmc-nand.c'. And we can take that work later.
Once everything is working fine and is at proper place, clean-up will
have more visibility.

IMHO, you can still take patches for now. As, this is how already done
for sdp boards too.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
