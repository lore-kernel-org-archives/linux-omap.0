From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v2] OMAP: DSS2: Fix error path in omap_dsi_update()
Date: Sat, 17 Jul 2010 12:14:03 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305DC5F77@dbde02.ent.ti.com>
References: <1279109510-12992-1-git-send-email-archit@ti.com>
 <4C3DDF3D.7010609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38196 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354Ab0GQGoP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jul 2010 02:44:15 -0400
In-Reply-To: <4C3DDF3D.7010609@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> Taneja, Archit had written, on 07/14/2010 07:11 AM, the following:
> > In the case of an error on calling dsi_update_screen_l4(), a 
> > successful framedone callback is still sent to panel-taal. An error 
> > should be returned to taal_update() instead.
> > 
> > Signed-off-by: Archit Taneja <archit@ti.com>
> > ---
> > v2: This fixes a compilation warning seen after builing with v1.
> > 
> > v1:
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31715.html
> > 
> >  drivers/video/omap2/dss/dsi.c |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/video/omap2/dss/dsi.c 
> > b/drivers/video/omap2/dss/dsi.c index a6e0f64..b3fa3a7
> > --- a/drivers/video/omap2/dss/dsi.c
> > +++ b/drivers/video/omap2/dss/dsi.c
> > @@ -2920,7 +2920,12 @@ int omap_dsi_update(struct omap_dss_device 
> > *dssdev,
> >  
> >  		dsi_update_screen_dispc(dssdev, x, y, w, h);
> dont need the error check here?

No, there is a scheduled workqueue which notifies a failure if
this function doesn't do what it was supposed to.

> >  	} else {
> > -		dsi_update_screen_l4(dssdev, x, y, w, h);
> > +		int r;
> > +
> > +		r = dsi_update_screen_l4(dssdev, x, y, w, h);
> > +		if (r)
> no print for warning developer/user? is this error expected?

The failure or success of omap_dsi_update() is notified to the display
panel driver(panel-taal) by a callback , if this error check isn't put
here, the panel driver will receive the callback without any error. Hence
it is needed. The error arrives when we don't get the supported pixel size
and color mode.

I am not sure if a print is needed, I will wait for Tomi's comment for that,
this returned value will be checked by upper functuions though. It is the
responsibility of the caller of taal_update to handle the returned value
correctly.

Regards,

Archit