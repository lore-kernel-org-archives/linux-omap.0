From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/8] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in
 the DSS
Date: Sun, 27 Feb 2011 11:43:59 +0200
Message-ID: <1298799839.1977.31.camel@deskari>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	 <1298643715-21540-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab1B0JoD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 04:44:03 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1R9i3tP024106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:44:03 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1R9i2i1021999
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:44:02 -0600 (CST)
In-Reply-To: <1298643715-21540-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
> The panel driver(hdmi_omap4_panel.c) in dss file acts as a controller
> to manage the enable and disable requests and synchronize audio and video.
> Also the header file to export the hdmi registers is added in the
> plat-omap , so that it can be accessed by audio driver.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/Kconfig            |    8 ++
>  drivers/video/omap2/dss/Makefile           |    1 +
>  drivers/video/omap2/dss/hdmi_omap4_panel.c |  190 ++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c
> 
> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
> index fe1ab09..670a55d 100644
> --- a/drivers/video/omap2/dss/Kconfig
> +++ b/drivers/video/omap2/dss/Kconfig
> @@ -125,4 +125,12 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
>  	  Max FCK is 173MHz, so this doesn't work if your PCK
>  	  is very high.
>  
> +config OMAP4_PANEL_HDMI
> +	bool "HDMI panel support"
> +	depends on OMAP2_DSS_HDMI
> +        default n
> +	help
> +	  HDMI panel. This adds the High Definition Multimedia panel.
> +	  See http://www.hdmi.org/ for HDMI specification.
> +
>  endif
> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
> index 5998b69..95234d4 100644
> --- a/drivers/video/omap2/dss/Makefile
> +++ b/drivers/video/omap2/dss/Makefile
> @@ -6,3 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
>  omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
>  omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
>  omapdss-$(CONFIG_OMAP2_DSS_HDMI) += hdmi.o
> +obj-$(CONFIG_OMAP4_PANEL_HDMI) += hdmi_omap4_panel.o
> diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_omap4_panel.c
> new file mode 100644
> index 0000000..c28b1f6
> --- /dev/null
> +++ b/drivers/video/omap2/dss/hdmi_omap4_panel.c
> @@ -0,0 +1,190 @@
> +/*
> + * hdmi_omap4_panel.c
> + *
> + * HDMI library support functions for TI OMAP4 processors.
> + *
> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
> + * Authors:	MythriPk <mythripk@ti.com>
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
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define DSS_SUBSYS_NAME "HDMI"

This is not used.

> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <plat/display.h>

Most of these includes are not needed.

> +
> +#include "dss.h"
> +
> +static struct {
> +	struct mutex hdmi_lock;
> +} hdmi;

Static variables in panel drivers are not good, as they won't work if
there are two devices which use the same driver. In this case that
cannot happen, as there's only one HDMI module in DSS. However, it's
worth to mention here in a comment. Or, do it properly and create a per
device data structure.

> +
> +
> +static int hdmi_panel_probe(struct omap_dss_device *dssdev)
> +{
> +	DSSDBG("ENTER hdmi_panel_probe\n");
> +
> +	dssdev->panel.config = OMAP_DSS_LCD_TFT |
> +			OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
> +
> +	/*
> +	 * Initialize the timings to 1920 * 1080
> +	 * This is only for framebuffer update not for TV timing setting
> +	 * Setting TV timing will be done only on enable
> +	 */
> +	dssdev->panel.timings.x_res = 1920;
> +	dssdev->panel.timings.y_res = 1080;
> +
> +	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
> +		dssdev->panel.timings.x_res,
> +		dssdev->panel.timings.y_res);
> +	return 0;
> +}
> +
> +static void hdmi_panel_remove(struct omap_dss_device *dssdev)
> +{
> +
> +}
> +
> +static int hdmi_panel_enable(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +	DSSDBG("ENTER hdmi_panel_enable\n");
> +
> +	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
> +		return -EINVAL;
> +
> +	mutex_lock(&hdmi.hdmi_lock);

I commented about this in earlier mails already. You need to use the
locks consistently and have the dssdev->state reads also inside the
lock.

Think what happens if, say, two threads call hdmi_panel_enable at the
same time.

 Tomi


