From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 08/13] OMAP1: DMA: Introduce DMA driver as platform device
Date: Tue, 09 Nov 2010 14:23:47 -0800
Message-ID: <87bp5ykufg.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-9-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:39726 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab0KIWXu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 17:23:50 -0500
Received: by pxi15 with SMTP id 15so1476400pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 14:23:49 -0800 (PST)
In-Reply-To: <1288099513-1854-9-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Register OMAP1 DMA driver as platform device and add support
> for registering through platform device layer using resource
> structures.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap1/dma.c              |  182 ++++++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap1/include/mach/dma.h |   29 +++++
>  2 files changed, 211 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/dma.c
>  create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
>
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> new file mode 100644
> index 0000000..e756069
> --- /dev/null
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -0,0 +1,182 @@
> +/*
> + * dma.c - OMAP1/OMAP7xx-specific DMA code
> + *
> + * Copyright (C) 2003 - 2008 Nokia Corporation
> + * Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
> + * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.=
com>
> + * Graphics DMA and LCD DMA graphics tranformations
> + * by Imre Deak <imre.deak@nokia.com>
> + * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
> + * Some functions based on earlier dma-omap.c Copyright (C) 2001 Rid=
geRun, Inc.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Converted DMA library into platform driver
> + *                   - G, Manjunath Kondaiah <manjugk@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>

no pm_runtime API usage in this patch.    Please add only when needed.

> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>

why is sched.h needed?

> +#include <linux/spinlock.h>

ditto

> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/device.h>

When creating a new file like this, it's important to only include
headers that are actually used/needed.

> +#include <plat/dma.h>
> +#include <plat/tc.h>
> +
> +#define OMAP1_DMA_BASE			(0xfffed800)
> +
> +static struct resource res[] __initdata =3D {
> +	[0] =3D {
> +		.start	=3D OMAP1_DMA_BASE,
> +		.end	=3D OMAP1_DMA_BASE + SZ_2K - 1,
> +		.flags	=3D IORESOURCE_MEM,
> +	},
> +	[1] =3D {
> +		.name   =3D "0",
> +		.start  =3D INT_DMA_CH0_6,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[2] =3D {
> +		.name   =3D "1",
> +		.start  =3D INT_DMA_CH1_7,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[3] =3D {
> +		.name   =3D "2",
> +		.start  =3D INT_DMA_CH2_8,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[4] =3D {
> +		.name   =3D "3",
> +		.start  =3D INT_DMA_CH3,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[5] =3D {
> +		.name   =3D "4",
> +		.start  =3D INT_DMA_CH4,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[6] =3D {
> +		.name   =3D "5",
> +		.start  =3D INT_DMA_CH5,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[7] =3D {
> +		.name   =3D "6",
> +		.start  =3D INT_DMA_LCD,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	/* irq's for omap16xx and omap7xx */
> +	[8] =3D {
> +		.name   =3D "7",
> +		.start  =3D 53 + IH2_BASE,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[9] =3D {
> +		.name   =3D "8",
> +		.start  =3D 54 + IH2_BASE,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	[10] =3D {
> +		.name  =3D "9",
> +		.start =3D 55 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +	[11] =3D {
> +		.name  =3D "10",
> +		.start =3D 56 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +	[12] =3D {
> +		.name  =3D "11",
> +		.start =3D 57 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +	[13] =3D {
> +		.name  =3D "12",
> +		.start =3D 58 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +	[14] =3D {
> +		.name  =3D "13",
> +		.start =3D 59 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +	[15] =3D {
> +		.name  =3D "14",
> +		.start =3D 60 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +	[16] =3D {
> +		.name  =3D "15",
> +		.start =3D 61 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +	[17] =3D {
> +		.name  =3D "16",
> +		.start =3D 62 + IH2_BASE,
> +		.flags =3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +static int __init omap1_system_dma_init(void)
> +{
> +	struct omap_system_dma_plat_info	*p;
> +	struct platform_device			*pdev;
> +	int ret;
> +
> +	pdev =3D platform_device_alloc("omap_dma_system", 0);
> +	if (!pdev) {
> +		pr_err("%s: Unable to device alloc for dma\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
> +	if (ret) {
> +		pr_err("%s: Unable to add resources for %s%d\n",
> +			__func__, pdev->name, pdev->id);
> +		goto exit_device_del;
> +	}
> +
> +	p =3D kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL)=
;
> +	if (!p) {
> +		dev_err(&pdev->dev, "%s: Unable to allocate 'p' for %s\n",
> +			__func__, pdev->name);
> +		ret =3D -ENOMEM;
> +		goto exit_device_put;
> +	}
> +
> +	ret =3D platform_device_add_data(pdev, p, sizeof(*p));
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
> +			__func__, pdev->name, pdev->id);
> +		goto exit_device_put;
> +	}
> +	ret =3D platform_device_add(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
> +			__func__, pdev->name, pdev->id);
> +		goto exit_device_put;
> +	}
> +	return ret;
> +
> +exit_device_put:
> +	platform_device_put(pdev);
> +exit_device_del:
> +	platform_device_del(pdev);
> +
> +	return ret;
> +}
> +arch_initcall(omap1_system_dma_init);
> diff --git a/arch/arm/mach-omap1/include/mach/dma.h b/arch/arm/mach-o=
map1/include/mach/dma.h
> new file mode 100644
> index 0000000..7949e3f
> --- /dev/null
> +++ b/arch/arm/mach-omap1/include/mach/dma.h
> @@ -0,0 +1,29 @@
> +/*
> + *  OMAP DMA controller register offsets.
> + *
> + *  Copyright (C) 2003 Nokia Corporation
> + *  Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
> + *
> + *  Copyright (C) 2010 Texas Instruments
> + *  Converted DMA library into platform driver
> + *       by G, Manjunath Kondaiah <manjugk@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + */
> +
> +#ifndef __ASM_ARCH_OMAP1_DMA_H
> +#define __ASM_ARCH_OMAP1_DMA_H
> +
> +#endif /* __ASM_ARCH_OMAP1_DMA_H */

Please don't create an empty header.  Just create it in the series when
(if) it's needed.  Same goes for next patch.

I see you populate mach/dma.h later in the series, but I don't
understand why those values need to be in the header.   More comments o=
n
those patches...

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
