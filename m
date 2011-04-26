From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH 3/7] OMAP: DSS: Adding a picodlp panel driver
Date: Tue, 26 Apr 2011 13:42:03 +0300
Message-ID: <1303814523.4989.39.camel@deskari>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-4-git-send-email-mayur@ti.com>
	 <1303211384.32281.7.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033D8839E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57469 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753850Ab1DZKmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 06:42:09 -0400
Received: by mail-ew0-f45.google.com with SMTP id 24so157485ewy.32
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 03:42:08 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033D8839E3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>

On Thu, 2011-04-21 at 16:36 +0530, Janorkar, Mayuresh wrote:
> 
> > -----Original Message-----
> > From: Valkeinen, Tomi
> > Sent: Tuesday, April 19, 2011 4:40 PM
> > To: Janorkar, Mayuresh
> > Cc: linux-omap@vger.kernel.org; K, Mythri P
> > Subject: Re: [PATCH 3/7] OMAP: DSS: Adding a picodlp panel driver
> > 
> > On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:

> > > +static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
> > > +{
> > > +	int r;
> > > +
> > > +	if (dssdev->platform_enable) {
> > > +		r = dssdev->platform_enable(dssdev);
> > > +		if (r)
> > > +			return r;
> > > +	}
> > > +
> > > +	r = omapdss_dpi_display_enable(dssdev);
> > > +	if (r) {
> > > +		dev_err(&dssdev->dev, "failed to enable DPI\n");
> > > +		goto err;
> > > +	}
> > > +	/* after enabling, wait for some initialize sync interrupts */
> > > +	msleep(675);
> > > +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> > > +
> > > +	return 0;
> > > +
> > > +err:
> > > +	if (dssdev->platform_disable)
> > > +		dssdev->platform_disable(dssdev);
> > > +
> > > +	return r;
> > > +}
> > 
> > Why is the msleep needed there? It's a huge sleep, and can't find
> > information about it from the documents you gave links to. I think I've
> > asked this three times already.
> > 
> 
> It is practically observed that without this delay the pico panel does not get initialized.
> 
> > Also, it's rather strange to sleep at the end of the function. Normally
> > you would sleep between two actions.
> 
> Some of the panels in drivers/video/omap2/displays sleep after dpi_display_enable.

Yes, but the drivers sleep between dpi_display_enable and
platform_enable. They don't sleep at the end of a function, they sleep
between two actions because the second action requires the first action
to be stabilized. More exactly, the panel needs to get the pixel clock
for a few frames to initialize itself, so that the image is stable when
the panel is taken out of reset.

> I agree here the sleep is huge. But I could not minimize it below this value.
> I can handle it in some other ways:
> See if the i2c_pakcet is sent. If not sent wait for some time ~50ms and then resend.

You need to find the documentation describing the power-up times to
understand what is required and where.

Most likely the case here is that picodlp takes rather long to wake up
after it's taken out of reset (i.e. platform_enabl. dpi_display_enable
probably doesn't have anything to do with this), and you need to wait
that time before sending i2c messages.

And if that is the case, you don't need to sleep after platform_enable
or dpi_display_enable, but before sending the first i2c message. And as
the sleep here is such a long sleep, I think it warrants some
optimization. If the sending of the i2c message happens in some other
function, you can store the timestamp at the time when the reset is
removed, and before sending the i2c message use the timestamp to sleep
enough to be sure the picodlp is up and running.

 Tomi


