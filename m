From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/7] OMAP: DSS: Adding a picodlp panel driver
Date: Tue, 19 Apr 2011 14:09:44 +0300
Message-ID: <1303211384.32281.7.camel@deskari>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-4-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36988 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754616Ab1DSLJv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 07:09:51 -0400
Received: by wyb32 with SMTP id 32so6223332wyb.2
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 04:09:48 -0700 (PDT)
In-Reply-To: <1303107350-22747-4-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org, Mythri P K <mythripk@ti.com>

On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> A projector panel named picodlp is supported by OMAP.
> panel driver is required to be added with the name picodlp_panel.
> 
> It is a WVGA panel with resolution 864 X 480 and panel timing data
> is defined in the panel driver.
> 
> picodlp makes use of parallel (DPI) interface multiplexed with secondary lcd
> in case of OMAP4.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> ---
>  drivers/video/omap2/displays/panel-picodlp.c |  228 ++++++++++++++++++++++++++
>  1 files changed, 228 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
> 
> diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
> new file mode 100644
> index 0000000..4f12903
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-picodlp.c
> @@ -0,0 +1,228 @@
> +/*
> + * picodlp panel driver
> + *
> + * Copyright (C) 2009-2011 Texas Instruments
> + * Author: Mythri P K <mythripk@ti.com>
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
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/firmware.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +
> +#include <plat/display.h>
> +#include <plat/panel-picodlp.h>
> +
> +struct picodlp_data {
> +	struct mutex lock;
> +};
> +
> +static struct omap_video_timings pico_ls_timings = {
> +	.x_res		= 864,
> +	.y_res		= 480,
> +	.hsw		= 7,
> +	.hfp		= 11,
> +	.hbp		= 7,
> +
> +	.pixel_clock	= 19200,
> +
> +	.vsw		= 2,
> +	.vfp		= 3,
> +	.vbp		= 14,
> +};
> +
> +static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
> +{
> +	int r;
> +
> +	if (dssdev->platform_enable) {
> +		r = dssdev->platform_enable(dssdev);
> +		if (r)
> +			return r;
> +	}
> +
> +	r = omapdss_dpi_display_enable(dssdev);
> +	if (r) {
> +		dev_err(&dssdev->dev, "failed to enable DPI\n");
> +		goto err;
> +	}
> +	/* after enabling, wait for some initialize sync interrupts */
> +	msleep(675);
> +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> +
> +	return 0;
> +
> +err:
> +	if (dssdev->platform_disable)
> +		dssdev->platform_disable(dssdev);
> +
> +	return r;
> +}

Why is the msleep needed there? It's a huge sleep, and can't find
information about it from the documents you gave links to. I think I've
asked this three times already.

Also, it's rather strange to sleep at the end of the function. Normally
you would sleep between two actions.

 Tomi


