From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2]: OMAP: SDP: Introducing 'board-sdp-flash.c' for
 flash init
Date: Mon, 7 Dec 2009 10:36:01 -0800
Message-ID: <20091207183600.GF24013@atomide.com>
References: <ce9ab5790912030610y5608ed48t4635c8995623750@mail.gmail.com>
 <20091204221712.GL24013@atomide.com>
 <ce9ab5790912062240i1ca4d8eemcc46e6bc19ecb8f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64281 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758556AbZLGSf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 13:35:56 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5790912062240i1ca4d8eemcc46e6bc19ecb8f6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

* Vimal Singh <vimal.newwork@gmail.com> [091206 22:39]:
> On Sat, Dec 5, 2009 at 3:47 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > Hi,
> >
> > * Vimal Singh <vimal.newwork@gmail.com> [091203 06:09]:
> >> From 13d52884956a26f93826c443e2b8bd78615f74d6 Mon Sep 17 00:00:00 =
2001
> >> From: Vimal Singh <vimalsingh@ti.com>
> >> Date: Thu, 26 Nov 2009 16:10:24 +0530
> >> Subject: [PATCH] OMAP: SDP: Introducing 'board-sdp-flash.c' for fl=
ash init
> >>
> >> This patch adds 'board-sdp-flash.c', which could be utilized
> >> by boards similar to 3430SDP. (For ex: 2430sdp, 36030sdp).
> >>
> >> This file does initialization for all three flash devices present
> >> in SDP boards (NOR, NAND, OneNAND), by finding there 'cs' number
> >> dynamically using switch setting information (S8: 1-4).
> >> This also expects partition information from core board files (for
> >> ex: board-3430sdp.c). Which allows to choose different default
> >> partitions for different boards.
> >>
> >> A new structure is created for this purpose: 'flash_partitions'
> >> in 'mach/board-sdp.h'. This has two members:
> >> 1. struct mtd_partition *parts
> >> 2. int nr_parts
> >>
> >> A board file is expected to fill this structure and pass it to
> >> 'sdp-flsash-init'. Partition information should be passed in
> >> structure array of 'flash_partitions'. Partition information shoul=
d
> >> be passed in below sequence in array:
> >> NOR
> >> OneNAND
> >> NAND
> >>
> >> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> >> ---
> >> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 =A0| =A0246 +=
+++++++++++++++++++++++++
> >> =A0arch/arm/mach-omap2/include/mach/board-sdp.h | =A0 22 +++
> >> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 =A0 | =A0 =A02 +
> >> =A03 files changed, 270 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
> >> =A0create mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h
> >>
> >> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
> >> b/arch/arm/mach-omap2/board-sdp-flash.c
> >> new file mode 100644
> >> index 0000000..fbbcd0e
> >> --- /dev/null
> >> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
> >
> > <snip>
> >
> >> +__init board_nand_init(struct flash_partitions sdp_nand_parts, u8=
 cs)
> >> +{
> >> + =A0 =A0 sdp_nand_data.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D cs;
> >> + =A0 =A0 sdp_nand_data.parts =A0 =A0 =A0 =A0 =A0 =A0 =3D sdp_nand=
_parts.parts;
> >> + =A0 =A0 sdp_nand_data.nr_parts =A0 =A0 =A0 =A0 =A0=3D sdp_nand_p=
arts.nr_parts;
> >> +
> >> + =A0 =A0 sdp_nand_data.gpmc_cs_baseaddr =A0=3D (void *)(OMAP34XX_=
GPMC_VIRT +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS0_BASE +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs * GPMC_CS_SIZE);
> >> + =A0 =A0 sdp_nand_data.gpmc_baseaddr =A0 =A0 =A0=3D (void *) (OMA=
P34XX_GPMC_VIRT);
> >> +
> >> + =A0 =A0 gpmc_nand_init(&sdp_nand_data);
> >> +}
> >
> > This does not look right. You're supposed to use gpmc_cs_request()
> > for allocating the GPMC area based on the chip select and size.
>=20
> I guess you are getting confuse a bit here:
> gpmc_baseaddr: is the virtual address for GPMC_REVISION (which is als=
o
> base address for GPMC).
> gpmc_cs_baseaddr : This is offset from above to 'GPMC_CONFIG(cs)' for
> specified cs number.
>=20
> These are needed by nand driver.

Right.. Looks like drivers/mtd/nand/omap2.c needs to be fixed so we
can get rid of this.

And looks like we already are doing it all over the place anyways :(
=20
> While 'gpmc_cs_request' gives physical address to the device resource=
=2E
> And this is done in 'nand/omap2.c'. This is done in driver itself so
> that we don't allocate a resource even before driver gets loaded.

Yuk.. The nand driver should be generic.

> >> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> >> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> >> @@ -27,6 +27,8 @@
> >>
> >> =A0#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A00x50
> >> =A0#define GPMC_STATUS =A0 =A0 =A0 =A0 =A00x54
> >> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x60
> >> +#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 0x30
> >
> > The GPMC_CS0_BASE and GPMC_CS_SIZE seem to be values specic to
> > your board, not for the GPMC hardware.
>=20
> These are offsets and very much specific to GPMC hardware.
>=20
> GPMC_CS0_BASE: is offset from GPMC base to first cs GPMC_CONFIG1 regi=
ster.
> GPMC_CS_SIZE : is offset (gap) between next cs config registers, e.i.
> size for cs config registers.

Let's keep it local until drivers/mtd/nand/omap2.c is fixed.

Care to take a look at using some generic nand driver instead
if we merge this for now?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
