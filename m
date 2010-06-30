From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v5 0/3] omap3 nand: cleanup exiting platform related code
Date: Wed, 30 Jun 2010 20:12:13 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DFE9927@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1275637205-489-1-git-send-email-s-ghorai@ti.com>
 <AANLkTinf8OcvHbLggdEJNGLvlAtSeExKri-IqNlwLpYD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756527Ab0F3Om2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 10:42:28 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "mike@compulab.co.il" <mike@compulab.co.il>, Vimal Singh <vimal.newwork@gmail.com>

Tony,
Please let me know if any have input on following two series.=20

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30305.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30735.html

Regards,
Ghorai

> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Tuesday, June 15, 2010 6:57 PM
> To: 'Tony Lindgren'
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> tony@atomide.com; mike@compulab.co.il; 'Vimal Singh'
> Subject: RE: [PATCH v5 0/3] omap3 nand: cleanup exiting platform rela=
ted
> code
>=20
> Tony,
>=20
> > -----Original Message-----
> > From: Vimal Singh [mailto:vimal.newwork@gmail.com]
> > Sent: Tuesday, June 08, 2010 10:43 PM
> > To: Ghorai, Sukumar
> > Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> > tony@atomide.com; mike@compulab.co.il
> > Subject: Re: [PATCH v5 0/3] omap3 nand: cleanup exiting platform re=
lated
> > code
> >
> > Reviewed-by: Vimal Singh <vimal.newwork@gmail.com>
> >
> > On Fri, Jun 4, 2010 at 1:10 PM, Sukumar Ghorai <s-ghorai@ti.com> wr=
ote:
> > > =A0 The following set of patches applies on top of for-next branc=
h.
> > > =A0 =A0 =A0 =A0http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind=
/linux-omap-
> > 2.6.git
> > > =A0 Patches verified on: omap3430-SDP, omap3630-sdp, zoom3 and be=
agle
> > board
> > >
> > > =A0 And these are the patches required to address the following i=
nput -
> > > =A0 =A0 1. The NAND driver needs to stop tinkering with the GPMC =
registers
> > > =A0 =A0 =A0 =A0The omap General Purpose Memory Controller (GPMC) =
registers are
> > omap
> > > =A0 =A0 =A0 =A0specific, and not driver specific. Tinkering with =
these
> registers
> > can
> > > =A0 =A0 =A0 =A0cause issues with the other devices on the GPMC.
> > >
> > > =A0 =A0 2. Passing hardcoded GPMC_CS0_BASE needs to go from the b=
oard
> files
> > > =A0 =A0 =A0 =A0Passing hardcoded GPMC virtual addressess is sure =
way to mess
> up
> > things.
> > > =A0 =A0 =A0 =A0This should all become unnecessary once the NAND d=
rivers stops
> > messing
> > > =A0 =A0 =A0 =A0with the GPMC registers directly.
> > > =A0 =A0 Discussion: http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg27630.html
> > >
> > > =A0 Changes in this series -
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Unused function removed.
> > >
> > > =A0Functions related to ecc and prefetch engine are optimized.
> > > =A0v4: http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg29458.html
> > >
> > > =A0Few functionality was missing =A0like - There should be some l=
ocking as
> > only
> > > =A0 one chipselect can use the ECC or prefetch engine at a time. =
If you
> > have
> > > =A0 NAND in two chipselects, bad things would happen.
> > > =A0v3: http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg28715.html
> > >
> > > =A0Additionally, it was needed to implement more functions for th=
e
> > platform
> > > =A0init code to use.
> > > =A0v2: http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg28467.html
> > >
> > > =A0v1: http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg28164.html
> > >
> > >
> > > Sukumar Ghorai (3):
> > > =A0 =A0 =A0 =A0omap3 gpmc: functionality enhancement
> > > =A0 =A0 =A0 =A0omap3 nand: cleanup virtual address usages
> > > =A0 =A0 =A0 =A0omap3 nand: fix issue in board file to detect nand
> > > =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 | =A0 20 +-=
--
> > > =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 | =A0 25 +---
> > > =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0| =A0 24 +---
> > > =A0arch/arm/mach-omap2/board-omap3touchbook.c | =A0 25 +---
> > > =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0| =A0 24 =
+---
> > > =A0arch/arm/mach-omap2/board-sdp-flash.c =A0 =A0 =A0| =A0 =A05 -
> > > =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 3=
9 ++----
> > > =A0arch/arm/mach-omap2/gpmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
228
> > +++++++++++++++++++++++++---
> > > =A0arch/arm/plat-omap/include/plat/gpmc.h =A0 =A0 | =A0 36 ++++-
> > > =A0arch/arm/plat-omap/include/plat/nand.h =A0 =A0 | =A0 =A06 +-
> > > =A0drivers/mtd/nand/omap2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0229 ++++++++-----------
> --
> > -------
> > > =A011 files changed, 320 insertions(+), 341 deletions(-)
>=20
> [Ghorai] Any comments or input on these patch?
>=20
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-o=
map"
> in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
> > >
> >
> >
> >
> > --
> > Regards,
> > Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
