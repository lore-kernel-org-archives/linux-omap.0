From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH] omap4: fb: Adds missing display update call when panning
Date: Wed, 21 Jul 2010 18:49:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C61C6395@dbde02.ent.ti.com>
References: <1279197422-23662-1-git-send-email-mayur@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C60874B1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45136 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500Ab0GUNUD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 09:20:03 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C60874B1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Diaz Prado, Gustavo" <gusdp@ti.com>

> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Thursday, July 15, 2010 6:19 PM
> To: Janorkar, Mayuresh; tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Diaz Prado, Gustavo
> Subject: RE: [PATCH] omap4: fb: Adds missing display update call when
> panning
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Janorkar, Mayuresh
> > Sent: Thursday, July 15, 2010 6:07 PM
> > To: tomi.valkeinen@nokia.com
> > Cc: linux-omap@vger.kernel.org; Diaz Prado, Gustavo; Janorkar, Mayuresh
> > Subject: [PATCH] omap4: fb: Adds missing display update call when
> panning
> >
> > From: Gustavo Diaz Prado <x0083741@ti.com>
> >
> > Adds the missing display update call when panning, this
> > is needed for the DSI panel when the auto-update feature is
> > not enabled.
> >
> > Signed-off-by: Gustavo Diaz Prado <x0083741@ti.com>
> > Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> > ---
> >  drivers/video/omap2/omapfb/omapfb-main.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> > b/drivers/video/omap2/omapfb/omapfb-main.c
> > index 4abb1d1..12d5382 100644
> > --- a/drivers/video/omap2/omapfb/omapfb-main.c
> > +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> > @@ -1068,7 +1068,8 @@ static int omapfb_pan_display(struct
> > fb_var_screeninfo *var,
> >  {
> >  	struct omapfb_info *ofbi = FB2OFB(fbi);
> >  	struct fb_var_screeninfo new_var;
> > -	int r;
> > +	int r = 0;
> > +	struct omap_dss_device *display = fb2display(fbi);
> >
> >  	DBG("pan_display(%d)\n", FB2OFB(fbi)->id);
> >
> > @@ -1086,6 +1087,11 @@ static int omapfb_pan_display(struct
> > fb_var_screeninfo *var,
> >
> >  	r = omapfb_apply_changes(fbi, 0);
> >
> > +	if (display && display->driver->update &&
> > +		display->driver->get_update_mode(display)
> > +			== OMAP_DSS_UPDATE_MANUAL)
> If the display dereference is checked, there is no need to check the base
> pointer (display), right ?
[Mayuresh]: That's correct. I would take it into account.
> > +		display->driver->update(display, 0, 0, var->xres, var->yres);
> > +
> >  	omapfb_put_mem_region(ofbi->region);
> >
> >  	return r;
> > --
> > 1.5.4.7
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


Are there any more comments?
If not can I resend the patch incorporating Santosh's comments?

-Thanks,
Mayuresh

