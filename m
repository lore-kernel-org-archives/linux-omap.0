From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 3/7] OMAP: DSS: Adding a picodlp panel driver
Date: Thu, 21 Apr 2011 16:36:18 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033D8839E3@dbde02.ent.ti.com>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-4-git-send-email-mayur@ti.com>
 <1303211384.32281.7.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52408 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab1DULGp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 07:06:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3LB6g7U026011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:06:44 -0500
In-Reply-To: <1303211384.32281.7.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Tuesday, April 19, 2011 4:40 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: Re: [PATCH 3/7] OMAP: DSS: Adding a picodlp panel driver
> 
> On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> > From: Mythri P K <mythripk@ti.com>
> >
> > A projector panel named picodlp is supported by OMAP.
> > panel driver is required to be added with the name picodlp_panel.
> >
> > It is a WVGA panel with resolution 864 X 480 and panel timing data
> > is defined in the panel driver.
> >
> > picodlp makes use of parallel (DPI) interface multiplexed with secondary
> lcd
> > in case of OMAP4.
> >
> > Signed-off-by: Mythri P K <mythripk@ti.com>
> > Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> > ---
> >  drivers/video/omap2/displays/panel-picodlp.c |  228
> ++++++++++++++++++++++++++
> >  1 files changed, 228 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
> >
> > diff --git a/drivers/video/omap2/displays/panel-picodlp.c
> b/drivers/video/omap2/displays/panel-picodlp.c
> > new file mode 100644
> > index 0000000..4f12903
> > --- /dev/null
> > +++ b/drivers/video/omap2/displays/panel-picodlp.c
> > @@ -0,0 +1,228 @@
> > +/*
> > + * picodlp panel driver
> > + *
> > + * Copyright (C) 2009-2011 Texas Instruments
> > + * Author: Mythri P K <mythripk@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> it
> > + * under the terms of the GNU General Public License version 2 as
> published by
> > + * the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/input.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/firmware.h>
> > +#include <linux/slab.h>
> > +#include <linux/mutex.h>
> > +#include <linux/delay.h>
> > +
> > +#include <plat/display.h>
> > +#include <plat/panel-picodlp.h>
> > +
> > +struct picodlp_data {
> > +	struct mutex lock;
> > +};
> > +
> > +static struct omap_video_timings pico_ls_timings = {
> > +	.x_res		= 864,
> > +	.y_res		= 480,
> > +	.hsw		= 7,
> > +	.hfp		= 11,
> > +	.hbp		= 7,
> > +
> > +	.pixel_clock	= 19200,
> > +
> > +	.vsw		= 2,
> > +	.vfp		= 3,
> > +	.vbp		= 14,
> > +};
> > +
> > +static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
> > +{
> > +	int r;
> > +
> > +	if (dssdev->platform_enable) {
> > +		r = dssdev->platform_enable(dssdev);
> > +		if (r)
> > +			return r;
> > +	}
> > +
> > +	r = omapdss_dpi_display_enable(dssdev);
> > +	if (r) {
> > +		dev_err(&dssdev->dev, "failed to enable DPI\n");
> > +		goto err;
> > +	}
> > +	/* after enabling, wait for some initialize sync interrupts */
> > +	msleep(675);
> > +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> > +
> > +	return 0;
> > +
> > +err:
> > +	if (dssdev->platform_disable)
> > +		dssdev->platform_disable(dssdev);
> > +
> > +	return r;
> > +}
> 
> Why is the msleep needed there? It's a huge sleep, and can't find
> information about it from the documents you gave links to. I think I've
> asked this three times already.
> 

It is practically observed that without this delay the pico panel does not get initialized.

> Also, it's rather strange to sleep at the end of the function. Normally
> you would sleep between two actions.

Some of the panels in drivers/video/omap2/displays sleep after dpi_display_enable.

I agree here the sleep is huge. But I could not minimize it below this value.
I can handle it in some other ways:
See if the i2c_pakcet is sent. If not sent wait for some time ~50ms and then resend.

> 
>  Tomi
> 

