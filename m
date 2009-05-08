From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Fri, 08 May 2009 07:10:21 +0300 (EEST)
Message-ID: <20090508.071021.123989594.Hiroshi.DOYU@nokia.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	<20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	<94a0d4530905071305i3f604b4am39f4c467e4df65a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33464 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbZEHEKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 00:10:49 -0400
In-Reply-To: <94a0d4530905071305i3f604b4am39f4c467e4df65a9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Hi Felipe,

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Thu, 7 May 2009 22:05:00 +0200

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
> > +#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)
>=20
> <snip/>
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D platform_device_add_resources=
(pdev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &omap3_iommu_res[2 * i], NR_IOMMU_RES);
>=20
> This is wrong. In this particular case NR_IOMMU_RES is 2, but not
> because there's 2 resources: MEM and IRQ, but because there's 2 iommu
> devices: isp and iva2.

Does the following make sense?

+#define NR_IOMMU_RES 2

=2E...

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D platform_device_add_resources(pde=
v,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 o=
map3_iommu_res +  i * NR_IOMMU_RES, NR_IOMMU_RES);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
