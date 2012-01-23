From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Mon, 23 Jan 2012 11:48:01 -0600
Message-ID: <CAF6AEGtLdQubMbERkr=5qpfe6LtoKS_NEzG2D7bBWS4cGT1+6A@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<4F1D97CF.60306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53280 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2AWRsC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 12:48:02 -0500
Received: by vbbfc26 with SMTP id fc26so500198vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 09:48:01 -0800 (PST)
In-Reply-To: <4F1D97CF.60306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>

On Mon, Jan 23, 2012 at 11:24 AM, Cousson, Benoit <b-cousson@ti.com> wr=
ote:
> Hi Rob,
>
> On 1/13/2012 9:41 PM, Rob Clark wrote:
>>
>> From: Rob Clark<rob@ti.com>
>
>
> [...]
>
>> +static int __init omap_init_gpu(void)
>
>
> Why is the function to init drm device is named gpu?
>

drm drivers are typically gpu drivers (although due to lack of opensrc
pvr userspace most of the actual gpu bits are stripped out)

The function can be renamed.. the name is really not too important
since it is only used within this file

>> +{
>> + =A0 =A0 =A0 struct omap_hwmod *oh =3D NULL;
>> +
>> + =A0 =A0 =A0 /* lookup and populate the DMM information, if present=
 - OMAP4+ */
>> + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("dmm");
>> +
>> + =A0 =A0 =A0 if (oh) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmm_platdata.base =3D omap_hwmod_get_m=
pu_rt_va(oh);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmm_platdata.irq =3D oh->mpu_irqs[0].i=
rq;
>
>
> These are internal hwmod attributes that should not be retrieved here=
=2E They
> are included in the device resources and this is up to the driver to =
get
> them using the platform_get_resource.
>


hmm, I don't claim to be a hwmod expert, but how is the platform
device mapped back to the needed resources then?

Andy looked more at that part so I'll let him comment.


>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmm_platdata.base)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omapdrm_platdata.dmm_p=
data =3D&dmm_platdata;
>
>
> pdata is supposed to be used for storing board level information, and=
 we are
> in the process of removing all of them for device tree adaptation. So=
 you
> should not use that at all in this case if this is not strictly neede=
d.
>
>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return platform_device_register(&omap_drm_device);
>
>
> This is not the proper way to init a device nowadays.
>
> If you want to take advantage of the pm functionality, you should cre=
ate an
> omap_device.
> Please have a look at the other OMAP devices creation code (GPIO, UAR=
T...).
>


Because omapdss is a separate layer below omapdrm, there really isn't
any PM in omapdrm (yet).  We do need to add support to restore the LUT
on resume although there are some complications when it comes to
correct sequence, ie. ensure LUT is reprogrammed before DSS overlays
are enabled, or IVAHD, etc, is allowed to start accessing buffer.
(But at least it should be possible to do correctly now, compared to
old state where there was a separate standalone tiler driver.)



>> +}
>> +
>> +arch_initcall(omap_init_gpu);
>> +
>> +void omapdrm_reserve_vram(void)
>> +{
>> +#ifdef CONFIG_CMA
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Create private 32MiB contiguous memory area for o=
mapdrm.0
>> device
>> + =A0 =A0 =A0 =A0* TODO revisit size.. if uc/wc buffers are allocate=
d from CMA
>> pages
>> + =A0 =A0 =A0 =A0* then the amount of memory we need goes up..
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1=
M, 0, 0);
>> +#else
>> +# =A0warning "CMA is not enabled, there may be limitations about sc=
anout
>> buffer allocations on OMAP3 and earlier"
>> +#endif
>> +}
>> +
>> +#endif
>> diff --git a/arch/arm/plat-omap/include/plat/drm.h
>> b/arch/arm/plat-omap/include/plat/drm.h
>> new file mode 100644
>> index 0000000..e29be29
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/drm.h
>
>
> Ideally, platform data should not exist anymore in a device tree worl=
d, but
> meanwhile there is a directory to store them:
> include/linux/platform_data
>
>
>> @@ -0,0 +1,70 @@
>> +/*
>> + * DRM/KMS device registration for TI OMAP platforms
>> + *
>> + * Copyright (C) 2012 Texas Instruments
>> + * Author: Rob Clark<rob.clark@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> it
>> + * under the terms of the GNU General Public License version 2 as
>> published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License
>> for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> along with
>> + * this program. =A0If not, see<http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __PLAT_OMAP_DRM_H__
>> +#define __PLAT_OMAP_DRM_H__
>> +
>> +/*
>> + * Optional platform data to configure the default configuration of=
 which
>> + * pipes/overlays/CRTCs are used.. if this is not provided, then in=
stead
>> the
>> + * first CONFIG_DRM_OMAP_NUM_CRTCS are used, and they are each conn=
ected
>> to
>> + * one manager, with priority given to managers that are connected =
to
>> + * detected devices. =A0Remaining overlays are used as video planes=
=2E =A0This
>> + * should be a good default behavior for most cases, but yet there =
still
>> + * might be times when you wish to do something different.
>> + */
>> +struct omap_kms_platform_data {
>> + =A0 =A0 =A0 /* overlays to use as CRTCs: */
>> + =A0 =A0 =A0 int ovl_cnt;
>> + =A0 =A0 =A0 const int *ovl_ids;
>> +
>> + =A0 =A0 =A0 /* overlays to use as video planes: */
>> + =A0 =A0 =A0 int pln_cnt;
>> + =A0 =A0 =A0 const int *pln_ids;
>> +
>> + =A0 =A0 =A0 int mgr_cnt;
>> + =A0 =A0 =A0 const int *mgr_ids;
>> +
>> + =A0 =A0 =A0 int dev_cnt;
>> + =A0 =A0 =A0 const char **dev_names;
>> +};
>> +
>> +struct omap_drm_platform_data {
>> + =A0 =A0 =A0 struct omap_kms_platform_data *kms_pdata;
>> + =A0 =A0 =A0 struct omap_dmm_platform_data *dmm_pdata;
>> +};
>
>
> Since the dmm_platform_data should not exist in theory, it should not=
 be
> used by this structure either.
>
> Where is the driver that will use these devices?

drivers/staging/omapdrm

BR,
-R

> Regards,
> Benoit
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
