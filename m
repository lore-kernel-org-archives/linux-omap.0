From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2]: OMAP: SDP: Introducing 'board-sdp-flash.c' for
 flash init
Date: Mon, 14 Dec 2009 11:31:49 -0800
Message-ID: <20091214193149.GB4575@atomide.com>
References: <ce9ab5790912030610y5608ed48t4635c8995623750@mail.gmail.com>
 <20091204221712.GL24013@atomide.com>
 <ce9ab5790912062240i1ca4d8eemcc46e6bc19ecb8f6@mail.gmail.com>
 <20091207183600.GF24013@atomide.com>
 <ce9ab5790912140159o46280d86u5ceb2ba11978e388@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56004 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZLNTbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 14:31:53 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5790912140159o46280d86u5ceb2ba11978e388@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

* Vimal Singh <vimal.newwork@gmail.com> [091214 01:58]:
> On Tue, Dec 8, 2009 at 12:06 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Vimal Singh <vimal.newwork@gmail.com> [091206 22:39]:
> >> On Sat, Dec 5, 2009 at 3:47 AM, Tony Lindgren <tony@atomide.com> w=
rote:
> >> > Hi,
> >> >
> >> > * Vimal Singh <vimal.newwork@gmail.com> [091203 06:09]:
> >> >> From 13d52884956a26f93826c443e2b8bd78615f74d6 Mon Sep 17 00:00:=
00 2001
> >> >> From: Vimal Singh <vimalsingh@ti.com>
> >> >> Date: Thu, 26 Nov 2009 16:10:24 +0530
> >> >> Subject: [PATCH] OMAP: SDP: Introducing 'board-sdp-flash.c' for=
 flash init
> >> >>
> >> >> This patch adds 'board-sdp-flash.c', which could be utilized
> >> >> by boards similar to 3430SDP. (For ex: 2430sdp, 36030sdp).
> >> >>
> >> >> This file does initialization for all three flash devices prese=
nt
> >> >> in SDP boards (NOR, NAND, OneNAND), by finding there 'cs' numbe=
r
> >> >> dynamically using switch setting information (S8: 1-4).
> >> >> This also expects partition information from core board files (=
for
> >> >> ex: board-3430sdp.c). Which allows to choose different default
> >> >> partitions for different boards.
> >> >>
> >> >> A new structure is created for this purpose: 'flash_partitions'
> >> >> in 'mach/board-sdp.h'. This has two members:
> >> >> 1. struct mtd_partition *parts
> >> >> 2. int nr_parts
> >> >>
> >> >> A board file is expected to fill this structure and pass it to
> >> >> 'sdp-flsash-init'. Partition information should be passed in
> >> >> structure array of 'flash_partitions'. Partition information sh=
ould
> >> >> be passed in below sequence in array:
> >> >> NOR
> >> >> OneNAND
> >> >> NAND
> >> >>
> >> >> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> >> >> ---
> >> >> =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0 =A0| =A024=
6 ++++++++++++++++++++++++++
> >> >> =A0arch/arm/mach-omap2/include/mach/board-sdp.h | =A0 22 +++
> >> >> =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 =A0 | =A0 =A0=
2 +
> >> >> =A03 files changed, 270 insertions(+), 0 deletions(-)
> >> >> =A0create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
> >> >> =A0create mode 100644 arch/arm/mach-omap2/include/mach/board-sd=
p.h
> >> >>
> >> >> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
> >> >> b/arch/arm/mach-omap2/board-sdp-flash.c
> >> >> new file mode 100644
> >> >> index 0000000..fbbcd0e
> >> >> --- /dev/null
> >> >> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
> >> >
> >> > <snip>
> >> >
> >> >> +__init board_nand_init(struct flash_partitions sdp_nand_parts,=
 u8 cs)
> >> >> +{
> >> >> + =A0 =A0 sdp_nand_data.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D c=
s;
> >> >> + =A0 =A0 sdp_nand_data.parts =A0 =A0 =A0 =A0 =A0 =A0 =3D sdp_n=
and_parts.parts;
> >> >> + =A0 =A0 sdp_nand_data.nr_parts =A0 =A0 =A0 =A0 =A0=3D sdp_nan=
d_parts.nr_parts;
> >> >> +
> >> >> + =A0 =A0 sdp_nand_data.gpmc_cs_baseaddr =A0=3D (void *)(OMAP34=
XX_GPMC_VIRT +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS0_BASE +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs * GPMC_CS_SIZE);
> >> >> + =A0 =A0 sdp_nand_data.gpmc_baseaddr =A0 =A0 =A0=3D (void *) (=
OMAP34XX_GPMC_VIRT);
> >> >> +
> >> >> + =A0 =A0 gpmc_nand_init(&sdp_nand_data);
> >> >> +}
> >> >
> >> > This does not look right. You're supposed to use gpmc_cs_request=
()
> >> > for allocating the GPMC area based on the chip select and size.
> >>
> >> I guess you are getting confuse a bit here:
> >> gpmc_baseaddr: is the virtual address for GPMC_REVISION (which is =
also
> >> base address for GPMC).
> >> gpmc_cs_baseaddr : This is offset from above to 'GPMC_CONFIG(cs)' =
for
> >> specified cs number.
> >>
> >> These are needed by nand driver.
> >
> > Right.. Looks like drivers/mtd/nand/omap2.c needs to be fixed so we
> > can get rid of this.
> >
> > And looks like we already are doing it all over the place anyways :=
(
> >
> >> While 'gpmc_cs_request' gives physical address to the device resou=
rce.
> >> And this is done in 'nand/omap2.c'. This is done in driver itself =
so
> >> that we don't allocate a resource even before driver gets loaded.
> >
> > Yuk.. The nand driver should be generic.
> >
> >> >> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> >> >> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> >> >> @@ -27,6 +27,8 @@
> >> >>
> >> >> =A0#define GPMC_CONFIG =A0 =A0 =A0 =A0 =A00x50
> >> >> =A0#define GPMC_STATUS =A0 =A0 =A0 =A0 =A00x54
> >> >> +#define GPMC_CS0_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x60
> >> >> +#define GPMC_CS_SIZE =A0 =A0 =A0 =A0 0x30
> >> >
> >> > The GPMC_CS0_BASE and GPMC_CS_SIZE seem to be values specic to
> >> > your board, not for the GPMC hardware.
> >>
> >> These are offsets and very much specific to GPMC hardware.
> >>
> >> GPMC_CS0_BASE: is offset from GPMC base to first cs GPMC_CONFIG1 r=
egister.
> >> GPMC_CS_SIZE : is offset (gap) between next cs config registers, e=
=2Ei.
> >> size for cs config registers.
> >
> > Let's keep it local until drivers/mtd/nand/omap2.c is fixed.
> >
> > Care to take a look at using some generic nand driver instead
> > if we merge this for now?
>=20
> To me it seems ok, for now, to get this merged and later we can work
> on cleaning 'nand/omap2.c' driver.

OK, sounds good to me. Let's plan on moving to use the gpmc-nand.c as
posted on this list.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
