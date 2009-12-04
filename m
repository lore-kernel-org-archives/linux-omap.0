From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4]: OMAP: ZOOM: Introducing 'board-zoom-flash.c' for
 NAND init in ZOOM boards
Date: Fri, 4 Dec 2009 14:19:18 -0800
Message-ID: <20091204221917.GM24013@atomide.com>
References: <ce9ab5790912030615m37535ec2sdcc4ec9723f0f2f2@mail.gmail.com>
 <6ed0b2680912030806n5bd6a358g640ec5e93accc5a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52349 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbZLDWTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 17:19:14 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680912030806n5bd6a358g640ec5e93accc5a8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [091203 08:05]:
> On Thu, Dec 3, 2009 at 4:15 PM, Vimal Singh <vimal.newwork@gmail.com>=
 wrote:
> > From 948584f4157a9eb99ba085968d23add28cbfd160 Mon Sep 17 00:00:00 2=
001
> > From: Vimal Singh <vimalsingh@ti.com>
> > Date: Tue, 1 Dec 2009 11:36:56 +0530
> > Subject: [PATCH] OMAP: ZOOM: Introducing 'board-zoom-flash.c'
> >
> > This patch adds 'board-zoom-flash.c', which could be utilized
> > by boards similar to ZOOM2. (For ex: LDP, ZOOM2, ZOOM3).
>=20
> So it's not really zoom specific, i.e. can be used by other boards
> with NAND like beagleboard and pandora? If that's the case, perhaps
> the file could be named something like omap3-nand.c or simply just
> nand.c .
>=20
> >
> > This does initialization for NAND device based on the 'cs' number
> > and partition information passed from board file (ex: board-zoom2.c=
).
> >
> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/board-zoom-flash.c =A0 =A0 =A0 =A0| =A0 59 +=
++++++++++++++++++++++++
> > =A0arch/arm/mach-omap2/include/mach/board-zoom.h | =A0 11 +++++
> > =A02 files changed, 70 insertions(+), 0 deletions(-)
> > =A0create mode 100644 arch/arm/mach-omap2/board-zoom-flash.c
> >
> > diff --git a/arch/arm/mach-omap2/board-zoom-flash.c
> > b/arch/arm/mach-omap2/board-zoom-flash.c
> > new file mode 100644
> > index 0000000..b3e66ca
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-zoom-flash.c

<snip>

> > +void __init zoom_flash_init(struct flash_partitions zoom_nand_part=
s[], int cs)
> > +{
> > + =A0 =A0 =A0 u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
> > +
> > + =A0 =A0 =A0 zoom_nand_data.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D cs;
> > + =A0 =A0 =A0 zoom_nand_data.parts =A0 =A0 =A0 =A0 =A0 =A0=3D zoom_=
nand_parts[0].parts;
> > + =A0 =A0 =A0 zoom_nand_data.nr_parts =A0 =A0 =A0 =A0 =3D zoom_nand=
_parts[0].nr_parts;
> > + =A0 =A0 =A0 zoom_nand_data.gpmc_baseaddr =A0 =A0=3D (void *)(gpmc=
_base_add);
> > + =A0 =A0 =A0 zoom_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_bas=
e_add +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_CS0_BASE +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 cs * GPMC_CS_SIZE);
> > + =A0 =A0 =A0 gpmc_nand_init(&zoom_nand_data);
> > +}

And here too you should use gpmc_cs_request().

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
