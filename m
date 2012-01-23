From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Mon, 23 Jan 2012 18:24:31 +0100
Message-ID: <4F1D97CF.60306@ti.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2AWRYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 12:24:39 -0500
In-Reply-To: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

Hi Rob,

On 1/13/2012 9:41 PM, Rob Clark wrote:
> From: Rob Clark<rob@ti.com>

[...]

> +static int __init omap_init_gpu(void)

Why is the function to init drm device is named gpu?

> +{
> +	struct omap_hwmod *oh = NULL;
> +
> +	/* lookup and populate the DMM information, if present - OMAP4+ */
> +	oh = omap_hwmod_lookup("dmm");
> +
> +	if (oh) {
> +		dmm_platdata.base = omap_hwmod_get_mpu_rt_va(oh);
> +		dmm_platdata.irq = oh->mpu_irqs[0].irq;

These are internal hwmod attributes that should not be retrieved here. 
They are included in the device resources and this is up to the driver 
to get them using the platform_get_resource.

> +
> +		if (dmm_platdata.base)
> +			omapdrm_platdata.dmm_pdata =&dmm_platdata;

pdata is supposed to be used for storing board level information, and we 
are in the process of removing all of them for device tree adaptation. 
So you should not use that at all in this case if this is not strictly 
needed.

> +	}
> +
> +	return platform_device_register(&omap_drm_device);

This is not the proper way to init a device nowadays.

If you want to take advantage of the pm functionality, you should create 
an omap_device.
Please have a look at the other OMAP devices creation code (GPIO, UART...).

> +}
> +
> +arch_initcall(omap_init_gpu);
> +
> +void omapdrm_reserve_vram(void)
> +{
> +#ifdef CONFIG_CMA
> +	/*
> +	 * Create private 32MiB contiguous memory area for omapdrm.0 device
> +	 * TODO revisit size.. if uc/wc buffers are allocated from CMA pages
> +	 * then the amount of memory we need goes up..
> +	 */
> +	dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1M, 0, 0);
> +#else
> +#  warning "CMA is not enabled, there may be limitations about scanout buffer allocations on OMAP3 and earlier"
> +#endif
> +}
> +
> +#endif
> diff --git a/arch/arm/plat-omap/include/plat/drm.h b/arch/arm/plat-omap/include/plat/drm.h
> new file mode 100644
> index 0000000..e29be29
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/drm.h

Ideally, platform data should not exist anymore in a device tree world, 
but meanwhile there is a directory to store them:
include/linux/platform_data

> @@ -0,0 +1,70 @@
> +/*
> + * DRM/KMS device registration for TI OMAP platforms
> + *
> + * Copyright (C) 2012 Texas Instruments
> + * Author: Rob Clark<rob.clark@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see<http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __PLAT_OMAP_DRM_H__
> +#define __PLAT_OMAP_DRM_H__
> +
> +/*
> + * Optional platform data to configure the default configuration of which
> + * pipes/overlays/CRTCs are used.. if this is not provided, then instead the
> + * first CONFIG_DRM_OMAP_NUM_CRTCS are used, and they are each connected to
> + * one manager, with priority given to managers that are connected to
> + * detected devices.  Remaining overlays are used as video planes.  This
> + * should be a good default behavior for most cases, but yet there still
> + * might be times when you wish to do something different.
> + */
> +struct omap_kms_platform_data {
> +	/* overlays to use as CRTCs: */
> +	int ovl_cnt;
> +	const int *ovl_ids;
> +
> +	/* overlays to use as video planes: */
> +	int pln_cnt;
> +	const int *pln_ids;
> +
> +	int mgr_cnt;
> +	const int *mgr_ids;
> +
> +	int dev_cnt;
> +	const char **dev_names;
> +};
> +
> +struct omap_drm_platform_data {
> +	struct omap_kms_platform_data *kms_pdata;
> +	struct omap_dmm_platform_data *dmm_pdata;
> +};

Since the dmm_platform_data should not exist in theory, it should not be 
used by this structure either.

Where is the driver that will use these devices?

Regards,
Benoit
