From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Tue, 6 Mar 2012 08:01:29 -0600
Message-ID: <CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<1331040371.2059.113.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57102 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965171Ab2CFOBa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 09:01:30 -0500
Received: by vcqp1 with SMTP id p1so4393847vcq.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 06:01:29 -0800 (PST)
In-Reply-To: <1331040371.2059.113.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Tue, Mar 6, 2012 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Mon, 2012-03-05 at 10:54 -0600, Rob Clark wrote:
>> From: Andy Gross <andy.gross@ti.com>
>>
>> Register OMAP DRM/KMS platform device, and reserve a CMA region for
>> the device to use for buffer allocation. =A0DMM is split into a
>> separate device using hwmod.
>>
>> Signed-off-by: Andy Gross <andy.gross@ti.com>
>> Signed-off-by: Rob Clark <rob@ti.com>
>> ---
>> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
>> =A0arch/arm/plat-omap/drm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 83 ++++=
+++++++++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/drm.h | =A0 64 ++++++++++++++++++=
+++++++
>> =A04 files changed, 150 insertions(+), 2 deletions(-)
>> =A0create mode 100644 arch/arm/plat-omap/drm.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/drm.h
>>
>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefi=
le
>> index 9a58461..b86e6cb 100644
>> --- a/arch/arm/plat-omap/Makefile
>> +++ b/arch/arm/plat-omap/Makefile
>> @@ -4,7 +4,7 @@
>>
>> =A0# Common support
>> =A0obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
>> - =A0 =A0 =A0usb.o fb.o counter_32k.o
>> + =A0 =A0 =A0usb.o fb.o counter_32k.o drm.o
>> =A0obj-m :=3D
>> =A0obj-n :=3D
>> =A0obj- =A0:=3D
>> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common=
=2Ec
>> index 06383b5..0d87dab 100644
>> --- a/arch/arm/plat-omap/common.c
>> +++ b/arch/arm/plat-omap/common.c
>> @@ -21,10 +21,10 @@
>> =A0#include <plat/board.h>
>> =A0#include <plat/vram.h>
>> =A0#include <plat/dsp.h>
>> +#include <plat/drm.h>
>>
>> =A0#include <plat/omap-secure.h>
>>
>> -
>> =A0#define NO_LENGTH_CHECK 0xffffffff
>>
>> =A0struct omap_board_config_kernel *omap_board_config __initdata;
>> @@ -65,6 +65,7 @@ const void *__init omap_get_var_config(u16 tag, si=
ze_t *len)
>>
>> =A0void __init omap_reserve(void)
>> =A0{
>> + =A0 =A0 omapdrm_reserve_vram();
>> =A0 =A0 =A0 omapfb_reserve_sdram_memblock();
>> =A0 =A0 =A0 omap_vram_reserve_sdram_memblock();
>> =A0 =A0 =A0 omap_dsp_reserve_sdram_memblock();
>> diff --git a/arch/arm/plat-omap/drm.c b/arch/arm/plat-omap/drm.c
>
> As Tony said, mach-omap2 is probably a better place. fb.c is in
> plat-omap because it supports both OMAP1 and OMAP2+.
>
>> new file mode 100644
>> index 0000000..28279df
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/drm.c
>> @@ -0,0 +1,83 @@
>> +/*
>> + * DRM/KMS device registration for TI OMAP platforms
>> + *
>> + * Copyright (C) 2012 Texas Instruments
>> + * Author: Rob Clark <rob.clark@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mm.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#ifdef CONFIG_CMA
>> +# =A0include <linux/dma-contiguous.h>
>> +#endif
>> +
>> +#include <plat/omap_device.h>
>> +#include <plat/omap_hwmod.h>
>> +
>> +#include <plat/drm.h>
>> +
>> +#if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
>> +
>> +static struct omap_drm_platform_data omapdrm_platdata;
>> +
>> +static struct platform_device omap_drm_device =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dev =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .coherent_dma_mask =3D DMA=
_BIT_MASK(32),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &omapdr=
m_platdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omapdrm",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .id =3D 0,
>
> Can there be more than one omapdrm device? I guess not. If so, the id
> should be -1.

in the past, we have used multiple devices (using the platform-data to
divide up the dss resources), although this was sort of a
special-case.  But in theory you could have multiple.  (Think of a
multi-seat scenario, where multiple compositors need to run and each
need to be drm-master of their own device to do mode-setting on their
corresponding display.)

I think if we use .id =3D -1, then we'd end up with a funny looking
bus-id for the device: "platform:omapdrm:-1"

>> +};
>> +
>> +static int __init omap_init_gpu(void)
>> +{
>> + =A0 =A0 struct omap_hwmod *oh =3D NULL;
>> + =A0 =A0 struct platform_device *pdev;
>> +
>> + =A0 =A0 /* lookup and populate the DMM information, if present - O=
MAP4+ */
>> + =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
>> +
>> + =A0 =A0 if (oh) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D omap_device_build(oh->name, -1, o=
h, NULL, 0, NULL, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(IS_ERR(pdev), "Could not build omap_d=
evice for %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->name);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return platform_device_register(&omap_drm_device);
>> +
>> +}
>
> The function is called omap_init_gpu(), but it doesn't do anything
> related to the gpu... And aren't DMM and DRM totally separate things,
> why are they bunched together like that?

only legacy.. product branches also have sgx initialization here.  But
I can change that to omap_init_drm()

DMM is managed by the drm driver (and exposed to userspace as drm/gem
buffers, shared with other devices via dma-buf, etc).  It is only
split out to a separate device to play along with hwmod.

>> +arch_initcall(omap_init_gpu);
>> +
>> +void omapdrm_reserve_vram(void)
>> +{
>> +#ifdef CONFIG_CMA
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Create private 32MiB contiguous memory area for omapd=
rm.0 device
>> + =A0 =A0 =A0* TODO revisit size.. if uc/wc buffers are allocated fr=
om CMA pages
>> + =A0 =A0 =A0* then the amount of memory we need goes up..
>> + =A0 =A0 =A0*/
>> + =A0 =A0 dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1M, 0=
, 0);
>
> What does this actually do? Does it reserve the memory, i.e. it's not
> usable for others? If so, shouldn't there be a way for the user to
> configure it?

It can be re-used by others.. see http://lwn.net/Articles/479297/

BR,
-R

>> +#else
>> +# =A0warning "CMA is not enabled, there may be limitations about sc=
anout buffer allocations on OMAP3 and earlier"
>> +#endif
>> +}
>> +
>> +#endif
>> diff --git a/arch/arm/plat-omap/include/plat/drm.h b/arch/arm/plat-o=
map/include/plat/drm.h
>> new file mode 100644
>> index 0000000..df9bc41
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/drm.h
>> @@ -0,0 +1,64 @@
>> +/*
>> + * DRM/KMS device registration for TI OMAP platforms
>> + *
>> + * Copyright (C) 2012 Texas Instruments
>> + * Author: Rob Clark <rob.clark@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __PLAT_OMAP_DRM_H__
>> +#define __PLAT_OMAP_DRM_H__
>> +
>> +/*
>> + * Optional platform data to configure the default configuration of=
 which
>> + * pipes/overlays/CRTCs are used.. if this is not provided, then in=
stead the
>> + * first CONFIG_DRM_OMAP_NUM_CRTCS are used, and they are each conn=
ected to
>> + * one manager, with priority given to managers that are connected =
to
>> + * detected devices. =A0Remaining overlays are used as video planes=
=2E =A0This
>> + * should be a good default behavior for most cases, but yet there =
still
>> + * might be times when you wish to do something different.
>> + */
>> +struct omap_kms_platform_data {
>> + =A0 =A0 /* overlays to use as CRTCs: */
>> + =A0 =A0 int ovl_cnt;
>> + =A0 =A0 const int *ovl_ids;
>> +
>> + =A0 =A0 /* overlays to use as video planes: */
>> + =A0 =A0 int pln_cnt;
>> + =A0 =A0 const int *pln_ids;
>> +
>> + =A0 =A0 int mgr_cnt;
>> + =A0 =A0 const int *mgr_ids;
>> +
>> + =A0 =A0 int dev_cnt;
>> + =A0 =A0 const char **dev_names;
>> +};
>> +
>> +struct omap_drm_platform_data {
>> + =A0 =A0 struct omap_kms_platform_data *kms_pdata;
>> +};
>
> I don't know if there's need to add these... With device tree the
> plaform data will not be usable anyway.
>
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
