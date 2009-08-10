From: Peter Barada <peterb@logicpd.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Mon, 10 Aug 2009 13:00:07 -0400
Message-ID: <1249923607.31495.13.camel@blitz>
References: <1249589441.10885.75.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
	 <1249665817.11736.21.camel@blitz>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
	 <1249672953.11736.76.camel@blitz> <20090807201712.GB9780@nokia.com>
	 <20090808064313.GA11613@nokia.com> <20090808071705.GA11844@nokia.com>
	 <1249914799.25044.4.camel@blitz>  <20090810161605.GA4357@gandalf>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:4116 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932092AbZHJQ4H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Aug 2009 12:56:07 -0400
In-Reply-To: <20090810161605.GA4357@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2009-08-10 at 19:16 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Aug 10, 2009 at 10:33:19AM -0400, Peter Barada wrote:
> > On Sat, 2009-08-08 at 10:17 +0300, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Sat, Aug 08, 2009 at 09:43:13AM +0300, Felipe Balbi wrote:
> > > > On Fri, Aug 07, 2009 at 10:17:12PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> > > > > On Fri, Aug 07, 2009 at 09:22:33PM +0200, ext Peter Barada wrote:
> > > > > > Someting strange is going on.  If I boot with the MUSB->OTG adapter ->
> > > > > > thumbdrive plugged in, and then modprobe the driver, it finds the
> > > > > > thumbdrive.  I can then remove/reinsert the OTG adapter -> thumbdrive
> > > > > > multiple times, and each time it is enumerated.
> > > > > > 
> > > > > > If I boot w/o the OTG adapter -> thumbdrive plugged in, modprobe the
> > > > > > musb driver, and then plug in the OTG adaptor ->thumbdrive, it is not
> > > > > > enumerated.
> > > > > > 
> > > > > > Any idea why I need the OTG adapter -> thumbdrive plugged in at kernel
> > > > > > boot for it to enumerate the thumbdrive?
> > > > > 
> > > > > which board are you using ?
> > > > 
> > > > ok, got you. it's 35xx-based with twl4030.
> > > > 
> > > > when you plug the micro-a cable, see on drivers/usb/otg/twl4030-usb.c
> > > > what happens. You should have a print about the link status, see if that
> > > > is ID.
> > > > 
> > > > Then try something like this patch:
> > > > 
> > > > diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> > > > index 9e3e7a5..4bc5b7f 100644
> > > > --- a/drivers/usb/otg/twl4030-usb.c
> > > > +++ b/drivers/usb/otg/twl4030-usb.c
> > 
> > Felipe,
> > 
> > Thanks for the patch.  With the following modified patch (to fit my tree
> > as my pull was from the Kevin's PM tree, commit
> > 7c5cb7862d32cb344be7831d466535d5255e35ac) it worked like a charm:
> 
> Great, I'll clean it up and send it to Greg for mainline integration.

Actually, not quite.  I noticed that twl4030_vbus_work only sets Vbus,
never clears it. 
With that change and the driver configured for OTG mode (I had it host
when I tested), it doesn't enumerate.

I added code to decipher the link state, and on startup I now see:

Jan  1 00:00:13 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
HW_CONDITIONS 0x72/114; link 1 (None)

Then when I load the driver:

Jan  1 00:01:30 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
HW_CONDITIONS 0xf2/242; link 2 (Vbus)
Jan  1 00:01:30 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
HW_CONDITIONS 0x72/114; link 1 (None)

And when I plug in the OTG adapter/thumbdrive:

Jan  1 00:02:24 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
HW_CONDITIONS 0x76/118; link 3 (ID)

and Vbus goes to +5V 30mS after ID grounds, and stays at 5V for only
30mS then goes back to ground.  Pulling out and reinserting repeast the
cycle.

During this total time, only two interrupts occur ont he MUSB
controller.  It looks like the connect interrupt is not occuring.

I'm adding more code to track the interrupts for both the twl4030-usb
and musb_hdrc so I can understand better what's happening (and more
importantly what's not).



-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
