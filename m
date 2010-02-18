From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] OMAP: ZOOM: Introducing 'board-zoom-flash.c'
Date: Wed, 17 Feb 2010 16:40:51 -0800
Message-ID: <20100218004051.GJ21755@atomide.com>
References: <ce9ab5791002102119k6eb32e97gfac21762a71843f3@mail.gmail.com>
 <20100211204703.GI21755@atomide.com>
 <20100211211914.GJ21755@atomide.com>
 <ce9ab5791002130142p7f57ce1bwe33a650e3de3464d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64162 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab0BRAkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 19:40:03 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5791002130142p7f57ce1bwe33a650e3de3464d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

* Vimal Singh <vimal.newwork@gmail.com> [100213 01:40]:
> On Fri, Feb 12, 2010 at 2:49 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Tony Lindgren <tony@atomide.com> [100211 12:43]:
> >> * Vimal Singh <vimal.newwork@gmail.com> [100210 21:16]:
> >> > From: Vimal Singh <vimalsingh@ti.com>
> >> >
> >> > This patch adds 'board-zoom-flash.c', which could be utilized
> >> > by boards similar to ZOOM2. (For ex: LDP, ZOOM2, ZOOM3).
> >> >
> >> > This does initialization for NAND device based on the 'cs' numbe=
r
> >> > and partition information passed from board file (ex: board-zoom=
2.c).
> >> >
> >> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> >> > ---
> >> > =C2=A0arch/arm/mach-omap2/board-zoom-flash.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 85 +++++++++++++++++++++++++
> >> > =C2=A0arch/arm/mach-omap2/include/mach/board-zoom.h | =C2=A0 11 =
+++
> >> > =C2=A02 files changed, 96 insertions(+), 0 deletions(-)
> >> > =C2=A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
> >> >
> >> > diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
> >> > b/arch/arm/mach-omap2/board-zoom-flash.c
> >> > new file mode 100644
> >> > index 0000000..f2328a4
> >> > --- /dev/null
> >> > +++ b/arch/arm/mach-omap2/board-zoom-flash.c
> >> > @@ -0,0 +1,85 @@
> >> > +/*
> >> > + * board-zoom-flash.c
> >> > + *
> >> > + * Copyright (C) 2009 Texas Instruments Inc.
> >> > + * Vimal Singh <vimalsingh@ti.com>
> >> > + *
> >> > + * This program is free software; you can redistribute it and/o=
r modify
> >> > + * it under the terms of the GNU General Public License version=
 2 as
> >> > + * published by the Free Software Foundation.
> >> > + */
> >> > +
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/delay.h>
> >> > +#include <linux/platform_device.h>
> >> > +#include <linux/mtd/nand.h>
> >> > +#include <linux/types.h>
> >> > +#include <linux/io.h>
> >> > +
> >> > +#include <asm/mach/flash.h>
> >> > +#include <plat/board.h>
> >> > +#include <plat/gpmc.h>
> >> > +#include <plat/nand.h>
> >> > +
> >> > +#include <mach/board-zoom.h>
> >> > +
> >> > +#if defined(CONFIG_MTD_NAND_OMAP2) || \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defined(CONFIG_MTD_NAND_OMA=
P2_MODULE)
> >> > +
> >> > +/* Note that all values in this struct are in nanoseconds */
> >> > +static struct gpmc_timings nand_timings =3D {
> >> > +
> >> > + =C2=A0 .sync_clk =3D 0,
> >> > +
> >> > + =C2=A0 .cs_on =3D 0,
> >> > + =C2=A0 .cs_rd_off =3D 36,
> >> > + =C2=A0 .cs_wr_off =3D 36,
> >> > +
> >> > + =C2=A0 .adv_on =3D 6,
> >> > + =C2=A0 .adv_rd_off =3D 24,
> >> > + =C2=A0 .adv_wr_off =3D 36,
> >> > +
> >> > + =C2=A0 .we_off =3D 30,
> >> > + =C2=A0 .oe_off =3D 48,
> >> > +
> >> > + =C2=A0 .access =3D 54,
> >> > + =C2=A0 .rd_cycle =3D 72,
> >> > + =C2=A0 .wr_cycle =3D 72,
> >> > +
> >> > + =C2=A0 .wr_access =3D 30,
> >> > + =C2=A0 .wr_data_mux_bus =3D 0,
> >> > +};
> >> > +
> >> > +/* NAND chip access: 16 bit */
> >> > +static struct omap_nand_platform_data zoom_nand_data =3D {
> >> > + =C2=A0 .nand_setup =C2=A0 =C2=A0 =3D NULL,
> >> > + =C2=A0 .gpmc_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &nand_timings,
> >> > + =C2=A0 .dma_channel =C2=A0 =C2=A0=3D -1, =C2=A0 /* disable DMA=
 in OMAP NAND driver */
> >> > + =C2=A0 .dev_ready =C2=A0 =C2=A0 =C2=A0=3D NULL,
> >> > + =C2=A0 .devsize =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1, =C2=A0 =C2=A0=
/* '0' for 8-bit, '1' for 16-bit device */
> >> > +};
> >> > +
> >> > +/**
> >> > + * zoom_flash_init - Identify devices connected to GPMC and reg=
ister.
> >> > + *
> >> > + * @return - void.
> >> > + */
> >> > +void __init zoom_flash_init(struct flash_partitions zoom_nand_p=
arts[], int cs)
> >> > +{
> >> > + =C2=A0 u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
> >> > +
> >> > + =C2=A0 zoom_nand_data.cs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D cs;
> >> > + =C2=A0 zoom_nand_data.parts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D zoom_nand_parts[0].parts;
> >> > + =C2=A0 zoom_nand_data.nr_parts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 zoom_nand_parts[0].nr_parts;
> >> > + =C2=A0 zoom_nand_data.gpmc_baseaddr =C2=A0 =C2=A0=3D (void *)(=
gpmc_base_add);
> >> > + =C2=A0 zoom_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_base_=
add +
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 GPMC_CS0_BASE +
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 cs * GPMC_CS_SIZE);
> >>
> >> The gpmc_baseaddr and gpmc_cs_baseaddr should no longer be
> >> needed with gpmc-nand.c, right?
>=20
> As said earlier too these are needed by 'nand/omap2.c' driver not for
> gpmc.-nand.c, we still need to pass these.

Right..
=20
> >
> > Yeah.. For now, I suggest you set the gpmc_baseaddr and
> > gpmc_cs_baseaddr in gpmc_nand_init() based on the results from
> > gpmc_cs_request.
> >
> > That will allow us to remove the insane hardcoded gpmc virtual
> > addresses from all board-*.c files.
>=20
> OK

This change you can already make without changing the driver.
=20
> >
> > And then we can finally fix gpmc-nand.c driver not to go tinker
> You mean omap2.c nand driver?
>=20
> > with the GPMC registers directly. All of that should be in
> > gpmc-nand.c using gpmc.c. The driver should be just a generic
> > NAND driver.
>=20
> Yes, but that will take complete clean-up of omap2.c nand driver by
> moving all functions accessing GPMC registers from 'nand/omap2.c' to
> 'gpmc-nand.c'. And we can take that work later.
> Once everything is working fine and is at proper place, clean-up will
> have more visibility.
>=20
> IMHO, you can still take patches for now. As, this is how already don=
e
> for sdp boards too.

I'd rather get things fixed rather than merge obviously broken stuff.

The thing is that unless it's fixed to start with, nobody bothers to
fix it afterwards and then I need to deal with cleaning up the mess.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
