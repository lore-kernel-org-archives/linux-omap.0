From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: RFBI worked example
Date: Fri, 07 Jan 2011 17:13:58 +0200
Message-ID: <1294413238.3968.110.camel@nubuntu>
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com  <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:20122 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab1AGPOC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 10:14:02 -0500
In-Reply-To: <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ben Tucker <btucker@mpcdata.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-01-07 at 14:18 +0000, ext Ben Tucker wrote:
> With further experimentation it appears that I can call the
> omap_rfbi_update() from the call back, but as the callback is in interrupt
> context this could be dangerous. I would love to see an example of this
> elsewhere.

Did you get it working enough to get an image on the panel?

It's been long since I've touched the rfbi code, and I honestly don't
know the state of it, but basically it should work similarly as DSI
command mode:

The panel driver issues an update when the user space has requested it
via OMAPFB_UPDATE_WINDOW. So it's not meant to be triggered
automatically.

If you really want to update the display automatically (which you
shouldn't, as the point with panels with their own framebuffer is to
update only when necessary), you can do it either directly as you do, or
via workqueue or thread.

I don't know right away if calling omap_rfbi_update() from interrupt
context is dangerous, but it might well be so you should check if
carefully.

Also, remember that you may need to stop updates somehow when the panel
is blanked or the driver is unloaded.

> 
> static void framedone_callback(void *data)
> {
>     int r;
>     u16 dw, dh;
>     struct omap_dss_device *dssdev = (struct omap_dss_device *)data;
> 
>     /* Start the next update, triggered on the external H/VSync signals */
>     dssdev->driver->get_resolution(dssdev, &dw, &dh);
>     r = omap_rfbi_update(dssdev, 0, 0, dw, dh, framedone_callback,
> dssdev);
>     if (r < 0)
>         printk("omap_rfbi_update FAILED");
> }
> 
> static int generic_panel_power_on(struct omap_dss_device *dssdev)
> {
>     int r;
>     u16 dw, dh;
> 
>     r = omapdss_rfbi_display_enable(dssdev);
>     if (r < 0)
>         goto err0;
> 
>     /* Setup external HSYNC/VSYNC triggering */
>     r = omap_rfbi_setup_te(OMAP_DSS_RFBI_TE_MODE_2,
>                            4000000,     /* HSYNS pulse 4uS */
>                            1000000000,  /* VSYNC pulse 1ms */
>                            0, 0,       /* H/VSYNC not inverted */
>                            0);
>     if (r < 0)
>         goto err1;
> 
>     /* Enable external triggering */
>     r = omap_rfbi_enable_te(1, 0);
>     if (r < 0)
>         goto err1;
> 
> #if 0
>     /* At a guess I do not think we need to do the prepare_update
>      * if we are updating the whole area
>      */

I'm not sure if it's ok not to call it every time, but you should at
least call it once to be sure everything is configured properly.

 Tomi


