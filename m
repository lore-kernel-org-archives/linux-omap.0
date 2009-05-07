From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Thu, 7 May 2009 23:05:00 +0300
Message-ID: <94a0d4530905071305i3f604b4am39f4c467e4df65a9@mail.gmail.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	 <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:62578 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZEGUFB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:05:01 -0400
Received: by fxm2 with SMTP id 2so1010520fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 13:05:00 -0700 (PDT)
In-Reply-To: <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Tue, May 5, 2009 at 3:47 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> w=
rote:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>
> =C2=A0arch/arm/mach-omap2/omap3-iommu.c | =C2=A0105 +++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 105 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/arm/mach-omap2/omap3-iommu.c
>
> diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/=
omap3-iommu.c
> new file mode 100644
> index 0000000..367f36a
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap3-iommu.c
> @@ -0,0 +1,105 @@
> +/*
> + * omap iommu: omap3 device registration
> + *
> + * Copyright (C) 2008-2009 Nokia Corporation
> + *
> + * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/platform_device.h>
> +
> +#include <mach/iommu.h>
> +
> +#define OMAP3_MMU1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A00x480bd400
> +#define OMAP3_MMU2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A00x5d000000
> +#define OMAP3_MMU1_IRQ 24
> +#define OMAP3_MMU2_IRQ 28
> +
> +static struct resource omap3_iommu_res[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { /* Camera ISP MMU */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_BASE + MMU_REG_SIZE - 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_MEM,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 { /* IVA2.2 MMU */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_BASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_BASE + MMU_REG_SIZE - 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_MEM,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)

<snip/>

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D platform_d=
evice_add_resources(pdev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &omap3_iommu_res[2 * =
i], NR_IOMMU_RES);

This is wrong. In this particular case NR_IOMMU_RES is 2, but not
because there's 2 resources: MEM and IRQ, but because there's 2 iommu
devices: isp and iva2.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
