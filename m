From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Fri, 13 Jan 2012 13:51:52 -0600
Message-ID: <CAKnK67RcftwfUYRb+U6xqMPt9jXkHo_rdWjrpwUjUAqq7HpMnA@mail.gmail.com>
References: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53216 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753335Ab2AMTwO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 14:52:14 -0500
Received: by mail-qy0-f182.google.com with SMTP id e15so564585qcs.41
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 11:52:13 -0800 (PST)
In-Reply-To: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

Hi Rob,

Minor nitpicks.

On Fri, Jan 13, 2012 at 1:41 PM, Rob Clark <rob.clark@linaro.org> wrote=
:
> From: Rob Clark <rob@ti.com>
>
> Register OMAP DRM/KMS platform device, and reserve a CMA region for
> the device to use for buffer allocation.
>
> Signed-off-by: Rob Clark <rob@ti.com>
> ---
> =A0arch/arm/plat-omap/Makefile | =A0 =A02 +-
> =A0arch/arm/plat-omap/common.c | =A0 =A02 +
> =A0arch/arm/plat-omap/drm.c =A0 =A0| =A0 88 +++++++++++++++++++++++++=
++++++++++++++++++
> =A0arch/arm/plat-omap/drm.h =A0 =A0| =A0 37 ++++++++++++++++++
> =A04 files changed, 128 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/plat-omap/drm.c
> =A0create mode 100644 arch/arm/plat-omap/drm.h
>
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefil=
e
> index 9a58461..b86e6cb 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -4,7 +4,7 @@
>
> =A0# Common support
> =A0obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
> - =A0 =A0 =A0 =A0usb.o fb.o counter_32k.o
> + =A0 =A0 =A0 =A0usb.o fb.o counter_32k.o drm.o
> =A0obj-m :=3D
> =A0obj-n :=3D
> =A0obj- =A0:=3D
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.=
c
> index 06383b5..caf6082 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -24,6 +24,7 @@
>
> =A0#include <plat/omap-secure.h>
>
> +#include "drm.h"
>
> =A0#define NO_LENGTH_CHECK 0xffffffff
>
> @@ -65,6 +66,7 @@ const void *__init omap_get_var_config(u16 tag, siz=
e_t *len)
>
> =A0void __init omap_reserve(void)
> =A0{
> + =A0 =A0 =A0 omapdrm_reserve_vram();
> =A0 =A0 =A0 =A0omapfb_reserve_sdram_memblock();
> =A0 =A0 =A0 =A0omap_vram_reserve_sdram_memblock();
> =A0 =A0 =A0 =A0omap_dsp_reserve_sdram_memblock();
> diff --git a/arch/arm/plat-omap/drm.c b/arch/arm/plat-omap/drm.c
> new file mode 100644
> index 0000000..5d8588f
> --- /dev/null
> +++ b/arch/arm/plat-omap/drm.c
> @@ -0,0 +1,88 @@
> +/*
> + * File: arch/arm/plat-omap/drm.c

I believe keeping a file path is frowned upon.

> + *
> + * DRM/KMS device registration for TI OMAP platforms
> + *
> + * Copyright (C) 2011 Texas Instruments

Happy new year! (2012?) :)

> + * Author: Rob Clark <rob.clark@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public L=
icense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#ifdef CONFIG_CMA
> +# =A0include <linux/dma-contiguous.h>
> +#endif
> +
> +#include <plat/omap_device.h>
> +#include <plat/omap_hwmod.h>
> +
> +#include "drm.h"
> +
> +/* files from staging that contain platform data structure definitio=
ns */
> +#include "../../../drivers/staging/omapdrm/omap_priv.h"
> +#include "../../../drivers/staging/omapdrm/omap_dmm_tiler.h"
> +
> +#if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
> +
> +static struct omap_drm_platform_data omapdrm_platdata;
> +static struct omap_dmm_platform_data dmm_platdata;
> +
> +static struct platform_device omap_drm_device =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .coherent_dma_mask =3D =
DMA_BIT_MASK(32),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &oma=
pdrm_platdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omapdrm",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .id =3D 0,
> +};
> +
> +static int __init omap_init_gpu(void)
> +{
> + =A0 =A0 =A0 struct omap_hwmod *oh =3D NULL;
> +
> + =A0 =A0 =A0 /* lookup and populate the DMM information, if present =
- OMAP4+ */
> + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
> +
> + =A0 =A0 =A0 if (oh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmm_platdata.base =3D omap_hwmod_get_mp=
u_rt_va(oh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmm_platdata.irq =3D oh->mpu_irqs[0].ir=
q;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmm_platdata.base)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omapdrm_platdata.dmm_pd=
ata =3D &dmm_platdata;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return platform_device_register(&omap_drm_device);
> +}
> +
> +arch_initcall(omap_init_gpu);
> +
> +void omapdrm_reserve_vram(void)
> +{
> +#ifdef CONFIG_CMA
> + =A0 =A0 =A0 /* Create private 32MiB contiguous memory area for omap=
drm.0 device
> + =A0 =A0 =A0 =A0* TODO revisit size.. if uc/wc buffers are allocated=
 from CMA pages
> + =A0 =A0 =A0 =A0* then the amount of memory we need goes up..
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dma_declare_contiguous(&omap_drm_device.dev, 32*SZ_1M, =
0, 0);
> +#else
> +# =A0warning "CMA is not enabled, there may be limitations about sca=
nout buffer allocations on OMAP3 and earlier"
> +#endif
> +}
> +
> +#endif
> diff --git a/arch/arm/plat-omap/drm.h b/arch/arm/plat-omap/drm.h
> new file mode 100644
> index 0000000..56e0c0e
> --- /dev/null
> +++ b/arch/arm/plat-omap/drm.h
> @@ -0,0 +1,37 @@
> +/*
> + * File: arch/arm/plat-omap/drm.c

Again here. (The path is incorrect anyways)

> + *
> + * DRM/KMS device registration for TI OMAP platforms
> + *
> + * Copyright (C) 2011 Texas Instruments

2012 also here.

> + * Author: Rob Clark <rob.clark@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public L=
icense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __PLAT_OMAP_DRM_H__
> +#define __PLAT_OMAP_DRM_H__
> +
> +#if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
> +
> +void omapdrm_reserve_vram(void);
> +
> +#else
> +
> +static inline void omapdrm_reserve_vram(void)
> +{
> +}
> +
> +#endif
> +
> +#endif /* __PLAT_OMAP_DRM_H__ */
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
