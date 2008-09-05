From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Thu, 4 Sep 2008 18:00:53 -0700
Message-ID: <20080905010052.GX23085@atomide.com>
References: <20080903221218.GD23085@atomide.com> <200809041620.06310.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50983 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYIEBA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 21:00:56 -0400
Content-Disposition: inline
In-Reply-To: <200809041620.06310.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080904 17:35]:
> Breaking this up into digestible chunks ...
> 
> This one for USB gadget.  I'll send parts of this upstream now,
> that seems simplest.
> 
> I'll review the patch for ehci-omap separately, when it's submitted.
> ISTR already commenting that the Kconfig stuff should become a
> platform_data issue.  Until that's all resolved, there's not a
> real point to more focussed review.

OK, once it's submitted to linux-usb, I'll drop it from l-o.

> I'll let Felipe deal with the MUSB stuff.

Sounds like the MUSB fixes are already queued up.

> The 15xx() bits in the OHCI glue seem fine, I'll send them too.

Thanks.

> - Dave
> 
> 
> 
> On Wednesday 03 September 2008, Tony Lindgren wrote:
> > --- a/drivers/usb/gadget/Kconfig        2008-09-01 11:13:34.000000000 -0700
> > +++ b/drivers/usb/gadget/Kconfig        2008-09-03 11:19:58.000000000 -0700
> > @@ -297,7 +297,7 @@
> >  config USB_GADGET_OMAP
> >         boolean "OMAP USB Device Controller"
> >         depends on ARCH_OMAP
> > -       select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
> > +       select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
> 
> fine ...
> 
> >         help
> >            Many Texas Instruments OMAP processors have flexible full
> >            speed USB device controllers, with support for up to 30
> > diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony /home/tmlind/src/kernel/linux-2.6/drivers/usb/gadget/omap_udc.c ./drivers/usb/gadget/omap_udc.c
> > --- a/drivers/usb/gadget/omap_udc.c     2008-09-01 11:13:35.000000000 -0700
> > +++ b/drivers/usb/gadget/omap_udc.c     2008-09-03 11:32:56.000000000 -0700
> > @@ -2313,6 +2313,13 @@
> >  
> >         tmp = omap_readl(OTG_REV);
> >         if (cpu_is_omap24xx()) {
> > +               /*
> > +                * REVISIT: Not clear how this works on OMAP2.  trans
> > +                * is ANDed to produce bits 7 and 8, which might make
> > +                * sense for USB_TRANSCEIVER_CTRL on OMAP1,
> > +                * but with CONTROL_DEVCONF, these bits have something to
> > +                * do with the frame adjustment counter and McBSP2.
> > +                */
> 
> ok ... the FAC is, ISTR, there to support hardware synch
> with isochronous data streams.  Linux doesn't use it now.
> 
> 
> >                 ctrl_name = "control_devconf";
> >                 trans = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> >         } else {
> > @@ -2597,7 +2604,9 @@
> >                  * and ignored for PIO-IN on newer chips
> >                  * (for more reliable behavior)
> >                  */
> > -               if (!use_dma || cpu_is_omap15xx() || cpu_is_omap24xx())
> > +               if ((!use_dma && (addr & USB_DIR_IN))
> > +                               || machine_is_omap_apollon()
> > +                               || cpu_is_omap15xx())
> 
> NAK.  The Apollon-specific bit should be done some other way,
> and whatever silicon issue it's covering up is not specific to
> that board ...
> 
> There is however an issue here.  The PIO-IN comment stopped
> matching the hardware at some point...
> 

I've dropped this from l-o tree, did not change the comments.

> >                         dbuf = 0;
> >  
> >                 switch (maxp) {
> > @@ -2687,7 +2696,7 @@
> >         udc->gadget.name = driver_name;
> >  
> >         device_initialize(&udc->gadget.dev);
> > -       dev_set_name(&udc->gadget.dev, "gadget");
> > +       strcpy (udc->gadget.dev.bus_id, "gadget");
> 
> As was previously commented:  this regression is a merge goof.  NAK.
> 
> >         udc->gadget.dev.release = omap_udc_release;
> >         udc->gadget.dev.parent = &odev->dev;
> >         if (use_dma)
> 
> 

This was already dropped yesterday.

Great, that only leaves the echi-omap patch then! Thanks for your help.

Tony

