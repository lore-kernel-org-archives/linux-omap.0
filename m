From: Peter Barada <peterb@logicpd.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Mon, 10 Aug 2009 10:33:19 -0400
Message-ID: <1249914799.25044.4.camel@blitz>
References: <1249589441.10885.75.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
	 <1249665817.11736.21.camel@blitz>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
	 <1249672953.11736.76.camel@blitz> <20090807201712.GB9780@nokia.com>
	 <20090808064313.GA11613@nokia.com>  <20090808071705.GA11844@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:42020 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753920AbZHJO3U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Aug 2009 10:29:20 -0400
In-Reply-To: <20090808071705.GA11844@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Sat, 2009-08-08 at 10:17 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Sat, Aug 08, 2009 at 09:43:13AM +0300, Felipe Balbi wrote:
> > On Fri, Aug 07, 2009 at 10:17:12PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> > > On Fri, Aug 07, 2009 at 09:22:33PM +0200, ext Peter Barada wrote:
> > > > Someting strange is going on.  If I boot with the MUSB->OTG adapter ->
> > > > thumbdrive plugged in, and then modprobe the driver, it finds the
> > > > thumbdrive.  I can then remove/reinsert the OTG adapter -> thumbdrive
> > > > multiple times, and each time it is enumerated.
> > > > 
> > > > If I boot w/o the OTG adapter -> thumbdrive plugged in, modprobe the
> > > > musb driver, and then plug in the OTG adaptor ->thumbdrive, it is not
> > > > enumerated.
> > > > 
> > > > Any idea why I need the OTG adapter -> thumbdrive plugged in at kernel
> > > > boot for it to enumerate the thumbdrive?
> > > 
> > > which board are you using ?
> > 
> > ok, got you. it's 35xx-based with twl4030.
> > 
> > when you plug the micro-a cable, see on drivers/usb/otg/twl4030-usb.c
> > what happens. You should have a print about the link status, see if that
> > is ID.
> > 
> > Then try something like this patch:
> > 
> > diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> > index 9e3e7a5..4bc5b7f 100644
> > --- a/drivers/usb/otg/twl4030-usb.c
> > +++ b/drivers/usb/otg/twl4030-usb.c

Felipe,

Thanks for the patch.  With the following modified patch (to fit my tree
as my pull was from the Kevin's PM tree, commit
7c5cb7862d32cb344be7831d466535d5255e35ac) it worked like a charm:

diff --exclude CVS -uNr linux-2.6.28-rc8/drivers/usb/otg/twl4030-usb.c
linux-2.6.28-rc8.modified/drivers/usb/otg/twl4030-usb.c
--- linux-2.6.28-rc8/drivers/usb/otg/twl4030-usb.c	2009-08-09
12:52:51.000000000 -0400
+++ linux-2.6.28-rc8.modified/drivers/usb/otg/twl4030-usb.c	2009-08-09
03:38:20.000000000 -0400
@@ -250,6 +250,8 @@
 };
 
 struct twl4030_usb {
+	/* used for driving or not vbus */
+	struct work_struct      vbus_work;
 	struct otg_transceiver	otg;
 	struct device		*dev;
 
@@ -263,6 +265,7 @@
 	u8			linkstat;
 	u8			asleep;
 	bool			irq_enabled;
+        bool                    drive_vbus;
 };
 
 /* internal define on top of container_of */
@@ -344,6 +347,18 @@
 	return twl4030_usb_write(twl, reg + 2, bits);
 }
 
+static void twl4030_vbus_work(struct work_struct *work)
+{
+       struct twl4030_usb      *twl = container_of(work, struct
twl4030_usb, vbus_work);
+
+       if (twl->drive_vbus)
+               (void) twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
+                               TWL4030_OTG_CTRL_DRVVBUS);
+       else
+               (void) twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
+                               TWL4030_OTG_CTRL_DRVVBUS);
+}
+
 /*-------------------------------------------------------------------------*/
 
 static enum linkstat twl4030_usb_linkstat(struct twl4030_usb *twl)
@@ -374,12 +389,16 @@
 	if (linkstat == USB_LINK_ID) {
 		twl->otg.default_a = true;
 		twl->otg.state = OTG_STATE_A_IDLE;
+		twl->drive_vbus = true;
 	} else {
 		twl->otg.default_a = false;
 		twl->otg.state = OTG_STATE_B_IDLE;
+		twl->drive_vbus = false;
 	}
 	spin_unlock_irq(&twl->lock);
 
+	schedule_work(&twl->vbus_work);
+
 	return linkstat;
 }
 
@@ -657,6 +676,8 @@
 	if (!twl)
 		return -ENOMEM;
 
+	INIT_WORK(&twl->vbus_work, twl4030_vbus_work);
+
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
 	twl->otg.dev		= twl->dev;

With it I can enumerate my OTG adapter/thumbdrive on insertion.

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
