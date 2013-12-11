From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 00:56:07 +0100
Message-ID: <10507960.9DXH4TSv2E@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-7-git-send-email-tomi.valkeinen@ti.com> <37483030.ghHfzYFSnL@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46456 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab3LKXzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Dec 2013 18:55:54 -0500
In-Reply-To: <37483030.ghHfzYFSnL@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Tomi,

On Thursday 12 December 2013 00:13:01 Laurent Pinchart wrote:
> On Wednesday 04 December 2013 14:28:33 Tomi Valkeinen wrote:
> > To avoid the need for a "nickname" property for each display, change
> > the display registration so that the display's alias (i.e. "display0"
> > etc) will be used for the dssdev->name if the display driver didn't
> > provide a name.
> > 
> > This means that when booting with board files, we will have more
> > descriptive names for displays, like "lcd1", "hdmi".
> 
> Where are those names used ? Are they reported to userspace, or limited to
> kernel internal use only ?
> 
> > With DT we'll only have "display0", etc. But as there are no "nicknames"
> > for things like serials ports either, I hope we will do fine with this
>
> Just a random thought, maybe the aliases node could help here.

I should have read the next patches before replying, sorry :-)

> I'm not sure what rules govern its usage. Adding labels to display DT nodes
> could be an option too.

A label property is still an option.

> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> > 
> >  drivers/video/omap2/dss/display.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/video/omap2/dss/display.c
> > b/drivers/video/omap2/dss/display.c index 669a81fdf58e..a946cf7ed00f
> > 100644
> > --- a/drivers/video/omap2/dss/display.c
> > +++ b/drivers/video/omap2/dss/display.c
> > @@ -137,6 +137,9 @@ int omapdss_register_display(struct omap_dss_device
> > *dssdev)
> >  	snprintf(dssdev->alias, sizeof(dssdev->alias),
> >  			"display%d", disp_num_counter++);
> > 
> > +	if (dssdev->name == NULL)
> > +		dssdev->name = dssdev->alias;
> > +
> >  	if (drv && drv->get_resolution == NULL)
> >  		drv->get_resolution = omapdss_default_get_resolution;
> >  	if (drv && drv->get_recommended_bpp == NULL)
-- 
Regards,

Laurent Pinchart

