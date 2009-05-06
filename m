From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Wed, 06 May 2009 09:00:24 +0300 (EEST)
Message-ID: <20090506.090024.232761548.Hiroshi.DOYU@nokia.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	<20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	<94a0d4530905051232m1fe23987q8fee8cbcfa8f1854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23176 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZEFGA5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 02:00:57 -0400
In-Reply-To: <94a0d4530905051232m1fe23987q8fee8cbcfa8f1854@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Tue, 5 May 2009 21:32:34 +0200

> On Tue, May 5, 2009 at 3:47 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > ---
> >
> > =A0arch/arm/mach-omap2/omap3-iommu.c | =A0105 +++++++++++++++++++++=
++++++++++++++++
> > =A01 files changed, 105 insertions(+), 0 deletions(-)
> > =A0create mode 100644 arch/arm/mach-omap2/omap3-iommu.c
> >
> > diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap=
2/omap3-iommu.c
> > new file mode 100644
> > index 0000000..367f36a
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap3-iommu.c
> > @@ -0,0 +1,105 @@
> > +/*
> > + * omap iommu: omap3 device registration
> > + *
> > + * Copyright (C) 2008-2009 Nokia Corporation
> > + *
> > + * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +
> > +#include <mach/iommu.h>
> > +
> > +#define OMAP3_MMU1_BASE =A0 =A0 =A0 =A00x480bd400
> > +#define OMAP3_MMU2_BASE =A0 =A0 =A0 =A00x5d000000
> > +#define OMAP3_MMU1_IRQ 24
> > +#define OMAP3_MMU2_IRQ 28
> > +
> > +static struct resource omap3_iommu_res[] =3D {
> > + =A0 =A0 =A0 { /* Camera ISP MMU */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_M=
MU1_BASE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3=
_MMU1_BASE + MMU_REG_SIZE - 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOU=
RCE_MEM,
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_M=
MU1_IRQ,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOU=
RCE_IRQ,
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 { /* IVA2.2 MMU */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_M=
MU2_BASE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3=
_MMU2_BASE + MMU_REG_SIZE - 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOU=
RCE_MEM,
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_M=
MU2_IRQ,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOU=
RCE_IRQ,
> > + =A0 =A0 =A0 },
> > +};
>=20
> This will break TI's bridgedriver, right?

Working around is easy, but let's go forward, correcting TI's bridgedri=
ver;-)

http://marc.info/?l=3Dlinux-omap&m=3D124148814309478&w=3D2


>=20
> Can camera ISP and IVA request the registration of their respective
> IOMMU's from their codebase?
>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
