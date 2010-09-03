From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Fri, 03 Sep 2010 13:59:32 -0700
Message-ID: <87lj7iv8zv.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-8-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35765 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab0ICU7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 16:59:38 -0400
Received: by yxp4 with SMTP id 4so877999yxp.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 13:59:37 -0700 (PDT)
In-Reply-To: <1282647866-6918-8-git-send-email-manjugk@ti.com> (Manjunatha
	GK's message of "Tue, 24 Aug 2010 16:34:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> This patch converts omap2/3/4 dma driver into platform
> devices through using omap hwmod, omap device and runtime pm
> frameworks.
>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/dma.c              |  134 ++++++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap2/include/mach/dma.h |   80 +++++++++++++++++++
>  2 files changed, 214 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dma.c
>  create mode 100644 arch/arm/mach-omap2/include/mach/dma.h
>
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> new file mode 100644
> index 0000000..f369bee
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -0,0 +1,134 @@
> +/*
> + * dma.c - OMAP2 specific DMA code
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
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Converted DMA library into platform driver by Manjunatha GK <manj=
ugk@ti.com>
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
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/device.h>
> +
> +#include <plat/irqs.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +#include <plat/dma.h>
> +
> +#define dma_read(reg)							\
> +({									\
> +	u32 __val;							\
> +	__val =3D __raw_readl(dma_base + OMAP_DMA4_##reg);		\
> +	__val;								\
> +})
> +
> +#define dma_write(val, reg)						\
> +({									\
> +	__raw_writel((val), dma_base + OMAP_DMA4_##reg);		\
> +})

I know these are copy paste from the original code, but please convert
into static inline functions.

Also, I don't see dma_write() used in this patch.

> +static struct omap_dma_dev_attr *d;
> +static void __iomem *dma_base;
> +static struct omap_system_dma_plat_info *omap2_pdata;
> +static int dma_caps0_status;
> +
> +static struct omap_device_pm_latency omap2_dma_latency[] =3D {
> +	{
> +	.deactivate_func =3D omap_device_idle_hwmods,
> +	.activate_func	 =3D omap_device_enable_hwmods,
> +	.flags		 =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,

missing indentation

> +	},
> +};

[...]

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
