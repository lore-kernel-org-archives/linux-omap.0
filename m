From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH v2 3/7] OMAP: DSS: Adding a picodlp panel driver
Date: Wed, 4 May 2011 14:54:28 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DA7429D@dbde02.ent.ti.com>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
	 <1304347971-1504-4-git-send-email-mayur@ti.com>
 <1304447188.26126.25.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43396 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab1EDJYh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 05:24:37 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p449OXKE012172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 04:24:35 -0500
In-Reply-To: <1304447188.26126.25.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Tuesday, May 03, 2011 11:56 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: Re: [PATCH v2 3/7] OMAP: DSS: Adding a picodlp panel driver
> 
> On Mon, 2011-05-02 at 20:22 +0530, Mayuresh Janorkar wrote:
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
> > Changes since v1:
> > 	1. Removed msleep
> >
> >  drivers/video/omap2/displays/panel-picodlp.c |  226
> ++++++++++++++++++++++++++
> >  1 files changed, 226 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
> 
> <snip>
> 
> > +static void picodlp_panel_disable(struct omap_dss_device *dssdev)
> > +{
> > +	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
> > +
> > +	mutex_lock(&picod->lock);
> > +	/* Turn off DLP Power */
> > +	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
> > +		picodlp_panel_power_off(dssdev);
> > +
> > +	dev_dbg(&dssdev->dev, " disabling picodlp panel\n");
> > +	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
> > +
> > +	mutex_unlock(&picod->lock);
> 
> Many of the debug prints in this file have an extra space in the
> beginning of the string, like above.
> 
> You should try to keep the code inside lock and unlock as minimal as
> possible. Here the dev_dbg() could as well be outside the lock (granted,
> dev_dbg() is a null op if DEBUG is not defined, but still).
> 
> Additionally, usually it's good to print the debug print before doing
> the action, so here (and similar cases elsewhere in this file) it would
> make sense to move the dev_dbg() before the lock.

I will take care of this

> 
> > +}
> > +
> > +static int picodlp_panel_suspend(struct omap_dss_device *dssdev)
> > +{
> > +	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
> > +
> > +	mutex_lock(&picod->lock);
> > +	/* Turn off DLP Power */
> > +	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
> > +		dev_dbg(&dssdev->dev, " unable to suspend picodlp panel,"\
> > +						" panel is not ACTIVE\n");
> 
> This is not a debug print, but an error. Similar problem in the function
> below.

Fine

> 
>  Tomi
> 

