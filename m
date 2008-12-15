From: Tony Lindgren <tony@atomide.com>
Subject: Re: [REVIEW PATCH 07/14] OMAP: CAM: Add ISP CSI2 API
Date: Mon, 15 Dec 2008 08:16:27 -0800
Message-ID: <20081215161625.GR10664@atomide.com>
References: <A24693684029E5489D1D202277BE894415E6E19C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50688 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbYLOQQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 11:16:31 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894415E6E19C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [081211 12:41]:
> From c442f389de719b47f8ec63f0ae07b5e2c2ef7b9d Mon Sep 17 00:00:00 2001
> From: Sergio Aguirre <saaguirre@ti.com>
> Date: Thu, 11 Dec 2008 13:35:49 -0600
> Subject: [PATCH] OMAP: CAM: Add ISP CSI2 API
> 
> Add ISP CSI2 API for operating OMAP3430 CSI2 receiver registers
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  drivers/media/video/isp/ispcsi2.c | 2106 +++++++++++++++++++++++++++++++++++++
>  drivers/media/video/isp/ispcsi2.h |  232 ++++
>  2 files changed, 2338 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/isp/ispcsi2.c
>  create mode 100644 drivers/media/video/isp/ispcsi2.h
> 
> diff --git a/drivers/media/video/isp/ispcsi2.c b/drivers/media/video/isp/ispcsi2.c
> new file mode 100644
> index 0000000..423ea3a
> --- /dev/null
> +++ b/drivers/media/video/isp/ispcsi2.c
> @@ -0,0 +1,2106 @@
> +/*
> + * drivers/media/video/isp/ispcsi2.c
> + *
> + * Driver Library for ISP CSI Control module in TI's OMAP3 Camera ISP
> + * ISP CSI interface and IRQ related APIs are defined here.
> + *
> + * Copyright (C) 2008 Texas Instruments.
> + *
> + * Contributors:
> + *     Sergio Aguirre <saaguirre@ti.com>
> + *     Dominic Curran <dcurran@ti.com>
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/types.h>
> +#include <asm/mach-types.h>

This should not be needed.


> +#include <media/v4l2-common.h>
> +#include <media/v4l2-int-device.h>
> +#include <linux/io.h>
> +#include <mach/io.h>
> +
> +#include "isp.h"
> +#include "ispreg.h"
> +#include "ispcsi2.h"
> +

<snip>


> +/**
> + * isp_csi2_complexio_lanes_update - Applies CSI2 ComplexIO lanes configuration.
> + * @force_update: Flag to force rewrite of registers, even if they haven't been
> + *                updated with the isp_csi2_complexio_lanes_config() function.
> + *
> + * It only saves settings when they were previously updated using the
> + * isp_csi2_complexio_lanes_config() function, unless the force_update flag is
> + * set to true.
> + * Always returns 0.
> + **/
> +int isp_csi2_complexio_lanes_update(bool force_update)
> +{
> +       struct isp_csi2_lanes_cfg *currlanes = &current_csi2_cfg.lanes;
> +       struct isp_csi2_lanes_cfg_update *currlanes_u =
> +                                       &current_csi2_cfg_update.lanes;
> +       u32 reg;
> +       int i;
> +
> +       if ((update_complexio_cfg1 == false) && (force_update == false))
> +               return 0;
> +
> +       reg = omap_readl(ISPCSI2_COMPLEXIO_CFG1);
> +       for (i = 0; i < 4; i++) {
> +               if ((currlanes_u->data[i] == true) || (force_update == true)) {
> +                       reg &= ~(ISPCSI2_COMPLEXIO_CFG1_DATA_POL_MASK(i + 1) |
> +                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_MASK(i +
> +                                                                       1));
> +                       reg |= (currlanes->data[i].pol <<
> +                               ISPCSI2_COMPLEXIO_CFG1_DATA_POL_SHIFT(i + 1));
> +                       reg |= (currlanes->data[i].pos <<
> +                               ISPCSI2_COMPLEXIO_CFG1_DATA_POSITION_SHIFT(i +
> +                                                                       1));
> +                       currlanes_u->data[i] = false;
> +               }
> +       }
> +
> +       if ((currlanes_u->clk == true) || (force_update == true)) {
> +               reg &= ~(ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_MASK |
> +                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_MASK);
> +               reg |= (currlanes->clk.pol <<
> +                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POL_SHIFT);
> +               reg |= (currlanes->clk.pos <<
> +                               ISPCSI2_COMPLEXIO_CFG1_CLOCK_POSITION_SHIFT);
> +               currlanes_u->clk = false;
> +       }
> +       omap_writel(reg, ISPCSI2_COMPLEXIO_CFG1);

You should change this driver too to pass IORESOURCE from
platform_data, then ioremap it in the driver, and then use
__raw_read/write instead of __omap_read/write.

Regards,

Tony
