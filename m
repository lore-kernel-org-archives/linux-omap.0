From: "Gross, Andy" <andy.gross@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Tue, 19 Jun 2012 16:12:54 -0500
Message-ID: <CABT81PhCGAwFBgVCk7CJGg7_erVZjS0DUM9ajg9uaQh5wf6ZRQ@mail.gmail.com>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	<CAF6AEGs0OYSUg0uGi5y0HgsHzqJYUwWj7Hx1Tupzu7mxa3VvLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:33222 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752659Ab2FSVM6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 17:12:58 -0400
Received: by vbip1 with SMTP id p1so3471493vbi.10
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 14:12:55 -0700 (PDT)
In-Reply-To: <CAF6AEGs0OYSUg0uGi5y0HgsHzqJYUwWj7Hx1Tupzu7mxa3VvLQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com, tomi.valkeinen@ti.com, tony@atomide.com

Tony,

Please queue this patch at your earliest convenience.

We had some discussion on the splitting out of the DMM/Tiler driver
from the omapdrm driver.  There might be some interest in leveraging
the Tiler for omapfb.  However, we agreed this can be deferred until
some other device (omapfb or otherwise) needs to use the Tiler.

Regards,

Andy Gross


On Mon, Jun 11, 2012 at 10:51 AM, Rob Clark <rob.clark@linaro.org> wrot=
e:
>
> On Wed, May 23, 2012 at 3:08 PM, Andy Gross <andy.gross@ti.com> wrote=
:
> > Register OMAP DRM/KMS platform device. =A0DMM is split into a
> > separate device using hwmod.
> >
> > Signed-off-by: Andy Gross <andy.gross@ti.com>
>
> Signed-off-by: Rob Clark <rob.clark@linaro.org>
>
> > ---
> > =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++
> > =A0arch/arm/mach-omap2/drm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 61 ++=
++++++++++++++++++++++++++++++
> > =A0drivers/staging/omapdrm/omap_drv.h =A0 =A0 | =A0 =A02 +-
> > =A0drivers/staging/omapdrm/omap_priv.h =A0 =A0| =A0 55 ------------=
----------------
> > =A0include/linux/platform_data/omap_drm.h | =A0 52 ++++++++++++++++=
+++++++++++
> > =A05 files changed, 118 insertions(+), 56 deletions(-)
> > =A0create mode 100644 arch/arm/mach-omap2/drm.c
> > =A0delete mode 100644 drivers/staging/omapdrm/omap_priv.h
> > =A0create mode 100644 include/linux/platform_data/omap_drm.h
> >
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Mak=
efile
> > index 49f92bc..c301ab7 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -187,6 +187,10 @@ ifneq ($(CONFIG_TIDSPBRIDGE),)
> > =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0+=3D dsp.o
> > =A0endif
> >
> > +ifneq ($(CONFIG_DRM_OMAP),)
> > +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0+=3D drm.o
> > +endif
> > +
> > =A0# Specific board support
> > =A0obj-$(CONFIG_MACH_OMAP_GENERIC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D board-generic.o
> > =A0obj-$(CONFIG_MACH_OMAP_H4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D board-h4=
=2Eo
> > diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
> > new file mode 100644
> > index 0000000..72e0f01b
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/drm.c
> > @@ -0,0 +1,61 @@
> > +/*
> > + * DRM/KMS device registration for TI OMAP platforms
> > + *
> > + * Copyright (C) 2012 Texas Instruments
> > + * Author: Rob Clark <rob.clark@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify it
> > + * under the terms of the GNU General Public License version 2 as =
published by
> > + * the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,=
 but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public=
 License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public Licen=
se along with
> > + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/dma-mapping.h>
> > +
> > +#include <plat/omap_device.h>
> > +#include <plat/omap_hwmod.h>
> > +
> > +#if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
> > +
> > +static struct platform_device omap_drm_device =3D {
> > + =A0 =A0 =A0 .dev =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .coherent_dma_mask =3D DMA_BIT_MASK(3=
2),
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 .name =3D "omapdrm",
> > + =A0 =A0 =A0 .id =3D 0,
> > +};
> > +
> > +static int __init omap_init_drm(void)
> > +{
> > + =A0 =A0 =A0 struct omap_hwmod *oh =3D NULL;
> > + =A0 =A0 =A0 struct platform_device *pdev;
> > +
> > + =A0 =A0 =A0 /* lookup and populate the DMM information, if presen=
t - OMAP4+ */
> > + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
> > +
> > + =A0 =A0 =A0 if (oh) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D omap_device_build(oh->name, =
-1, oh, NULL, 0, NULL, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 false);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(IS_ERR(pdev), "Could not build o=
map_device for %s\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->name);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return platform_device_register(&omap_drm_device);
> > +
> > +}
> > +
> > +arch_initcall(omap_init_drm);
> > +
> > +#endif
> > diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/o=
mapdrm/omap_drv.h
> > index b7e0f07..96296e0 100644
> > --- a/drivers/staging/omapdrm/omap_drv.h
> > +++ b/drivers/staging/omapdrm/omap_drv.h
> > @@ -25,8 +25,8 @@
> > =A0#include <linux/types.h>
> > =A0#include <drm/drmP.h>
> > =A0#include <drm/drm_crtc_helper.h>
> > +#include <linux/platform_data/omap_drm.h>
> > =A0#include "omap_drm.h"
> > -#include "omap_priv.h"
> >
> > =A0#define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
> > =A0#define VERB(fmt, ...) if (0) DRM_DEBUG(fmt, ##__VA_ARGS__) /* v=
erbose debug */
> > diff --git a/drivers/staging/omapdrm/omap_priv.h b/drivers/staging/=
omapdrm/omap_priv.h
> > deleted file mode 100644
> > index ef64414..0000000
> > --- a/drivers/staging/omapdrm/omap_priv.h
> > +++ /dev/null
> > @@ -1,55 +0,0 @@
> > -/*
> > - * include/drm/omap_priv.h
> > - *
> > - * Copyright (C) 2011 Texas Instruments
> > - * Author: Rob Clark <rob@ti.com>
> > - *
> > - * This program is free software; you can redistribute it and/or m=
odify it
> > - * under the terms of the GNU General Public License version 2 as =
published by
> > - * the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful,=
 but WITHOUT
> > - * ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY or
> > - * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public=
 License for
> > - * more details.
> > - *
> > - * You should have received a copy of the GNU General Public Licen=
se along with
> > - * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> > - */
> > -
> > -#ifndef __OMAP_PRIV_H__
> > -#define __OMAP_PRIV_H__
> > -
> > -/* Non-userspace facing APIs
> > - */
> > -
> > -/* optional platform data to configure the default configuration o=
f which
> > - * pipes/overlays/CRTCs are used.. if this is not provided, then i=
nstead the
> > - * first CONFIG_DRM_OMAP_NUM_CRTCS are used, and they are each con=
nected to
> > - * one manager, with priority given to managers that are connected=
 to
> > - * detected devices. =A0Remaining overlays are used as video plane=
s. =A0This
> > - * should be a good default behavior for most cases, but yet there=
 still
> > - * might be times when you wish to do something different.
> > - */
> > -struct omap_kms_platform_data {
> > - =A0 =A0 =A0 /* overlays to use as CRTCs: */
> > - =A0 =A0 =A0 int ovl_cnt;
> > - =A0 =A0 =A0 const int *ovl_ids;
> > -
> > - =A0 =A0 =A0 /* overlays to use as video planes: */
> > - =A0 =A0 =A0 int pln_cnt;
> > - =A0 =A0 =A0 const int *pln_ids;
> > -
> > - =A0 =A0 =A0 int mgr_cnt;
> > - =A0 =A0 =A0 const int *mgr_ids;
> > -
> > - =A0 =A0 =A0 int dev_cnt;
> > - =A0 =A0 =A0 const char **dev_names;
> > -};
> > -
> > -struct omap_drm_platform_data {
> > - =A0 =A0 =A0 struct omap_kms_platform_data *kms_pdata;
> > - =A0 =A0 =A0 struct omap_dmm_platform_data *dmm_pdata;
> > -};
> > -
> > -#endif /* __OMAP_DRM_H__ */
> > diff --git a/include/linux/platform_data/omap_drm.h b/include/linux=
/platform_data/omap_drm.h
> > new file mode 100644
> > index 0000000..3da73bd
> > --- /dev/null
> > +++ b/include/linux/platform_data/omap_drm.h
> > @@ -0,0 +1,52 @@
> > +/*
> > + * DRM/KMS platform data for TI OMAP platforms
> > + *
> > + * Copyright (C) 2012 Texas Instruments
> > + * Author: Rob Clark <rob.clark@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify it
> > + * under the terms of the GNU General Public License version 2 as =
published by
> > + * the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,=
 but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public=
 License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public Licen=
se along with
> > + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef __PLATFORM_DATA_OMAP_DRM_H__
> > +#define __PLATFORM_DATA_OMAP_DRM_H__
> > +
> > +/*
> > + * Optional platform data to configure the default configuration o=
f which
> > + * pipes/overlays/CRTCs are used.. if this is not provided, then i=
nstead the
> > + * first CONFIG_DRM_OMAP_NUM_CRTCS are used, and they are each con=
nected to
> > + * one manager, with priority given to managers that are connected=
 to
> > + * detected devices. =A0Remaining overlays are used as video plane=
s. =A0This
> > + * should be a good default behavior for most cases, but yet there=
 still
> > + * might be times when you wish to do something different.
> > + */
> > +struct omap_kms_platform_data {
> > + =A0 =A0 =A0 /* overlays to use as CRTCs: */
> > + =A0 =A0 =A0 int ovl_cnt;
> > + =A0 =A0 =A0 const int *ovl_ids;
> > +
> > + =A0 =A0 =A0 /* overlays to use as video planes: */
> > + =A0 =A0 =A0 int pln_cnt;
> > + =A0 =A0 =A0 const int *pln_ids;
> > +
> > + =A0 =A0 =A0 int mgr_cnt;
> > + =A0 =A0 =A0 const int *mgr_ids;
> > +
> > + =A0 =A0 =A0 int dev_cnt;
> > + =A0 =A0 =A0 const char **dev_names;
> > +};
> > +
> > +struct omap_drm_platform_data {
> > + =A0 =A0 =A0 struct omap_kms_platform_data *kms_pdata;
> > +};
> > +
> > +#endif /* __PLATFORM_DATA_OMAP_DRM_H__ */
> > --
> > 1.7.5.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
