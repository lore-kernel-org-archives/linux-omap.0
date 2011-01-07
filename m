From: Ben Tucker <btucker@mpcdata.com>
Subject: RE: RFBI worked example
Date: Fri, 7 Jan 2011 17:25:19 -0000
Message-ID: <78677181845a6577fe0955a1984ac16a@mail.gmail.com>
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com
  <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com> <1294413238.3968.110.camel@nubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58585 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab1AGRY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 12:24:26 -0500
Received: by iyi12 with SMTP id 12so15964267iyi.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 09:24:25 -0800 (PST)
In-Reply-To: <1294413238.3968.110.camel@nubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: 07 January 2011 15:14
> To: ext Ben Tucker
> Cc: linux-omap@vger.kernel.org
> Subject: RE: RFBI worked example
>
> On Fri, 2011-01-07 at 14:18 +0000, ext Ben Tucker wrote:
> > With further experimentation it appears that I can call the
> > omap_rfbi_update() from the call back, but as the callback is in
> interrupt
> > context this could be dangerous. I would love to see an example of
> this
> > elsewhere.
>
> Did you get it working enough to get an image on the panel?

The panel in this case is under development so (it's actually an FPGA) so we
have some way to go before we have an image.

>
> It's been long since I've touched the rfbi code, and I honestly don't
> know the state of it, but basically it should work similarly as DSI
> command mode:

It appears to be working. As a test I tried using internal triggering with
my panel code (below). Pixel data appears to flow out of the port (the
RFBI_PIXEL_CNT register is decrementing).

>
> The panel driver issues an update when the user space has requested it
> via OMAPFB_UPDATE_WINDOW. So it's not meant to be triggered
> automatically.

OK, that helps my understanding.

>
> If you really want to update the display automatically (which you
> shouldn't, as the point with panels with their own framebuffer is to
> update only when necessary), you can do it either directly as you do,
> or
> via workqueue or thread.

The primary reason for using RFBI in this design is to allow the RFB to
control the H/VSync's and thus the delivery of pixel data. This is not the
traditional RFBI design.

I am concerned that a thread or workqueue may introduce an unacceptable
delay between FRAMEDONE and re-arming the DSS/RFBI for the next frame. I
guess it depends on the rate that the panel requests frames.

>
> I don't know right away if calling omap_rfbi_update() from interrupt
> context is dangerous, but it might well be so you should check if
> carefully.

OK, thankyou. I will check.

>
> Also, remember that you may need to stop updates somehow when the panel
> is blanked or the driver is unloaded.
>

I *think* this is OK because the FRAMEDONE interrupt is deregistered in
omapdss_rfbi_display_disable().

> >
> > static void framedone_callback(void *data)
> > {
> >     int r;
> >     u16 dw, dh;
> >     struct omap_dss_device *dssdev = (struct omap_dss_device *)data;
> >
> >     /* Start the next update, triggered on the external H/VSync
> signals */
> >     dssdev->driver->get_resolution(dssdev, &dw, &dh);
> >     r = omap_rfbi_update(dssdev, 0, 0, dw, dh, framedone_callback,
> > dssdev);
> >     if (r < 0)
> >         printk("omap_rfbi_update FAILED");
> > }
> >
> > static int generic_panel_power_on(struct omap_dss_device *dssdev)
> > {
> >     int r;
> >     u16 dw, dh;
> >
> >     r = omapdss_rfbi_display_enable(dssdev);
> >     if (r < 0)
> >         goto err0;
> >
> >     /* Setup external HSYNC/VSYNC triggering */
> >     r = omap_rfbi_setup_te(OMAP_DSS_RFBI_TE_MODE_2,
> >                            4000000,     /* HSYNS pulse 4uS */
> >                            1000000000,  /* VSYNC pulse 1ms */
> >                            0, 0,       /* H/VSYNC not inverted */
> >                            0);
> >     if (r < 0)
> >         goto err1;
> >
> >     /* Enable external triggering */
> >     r = omap_rfbi_enable_te(1, 0);
> >     if (r < 0)
> >         goto err1;
> >
> > #if 0
> >     /* At a guess I do not think we need to do the prepare_update
> >      * if we are updating the whole area
> >      */
>
> I'm not sure if it's ok not to call it every time, but you should at
> least call it once to be sure everything is configured properly.

Thanks. I will add this call.

>
>  Tomi
>

Ben
