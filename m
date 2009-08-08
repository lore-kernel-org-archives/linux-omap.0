From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Sat, 8 Aug 2009 09:43:13 +0300
Message-ID: <20090808064313.GA11613@nokia.com>
References: <1249589441.10885.75.camel@blitz>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
 <1249665817.11736.21.camel@blitz>
 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
 <1249672953.11736.76.camel@blitz>
 <20090807201712.GB9780@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39089 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbZHHGmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Aug 2009 02:42:08 -0400
Content-Disposition: inline
In-Reply-To: <20090807201712.GB9780@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: ext Peter Barada <peterb@logicpd.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Aug 07, 2009 at 10:17:12PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> On Fri, Aug 07, 2009 at 09:22:33PM +0200, ext Peter Barada wrote:
> > Someting strange is going on.  If I boot with the MUSB->OTG adapter ->
> > thumbdrive plugged in, and then modprobe the driver, it finds the
> > thumbdrive.  I can then remove/reinsert the OTG adapter -> thumbdrive
> > multiple times, and each time it is enumerated.
> > 
> > If I boot w/o the OTG adapter -> thumbdrive plugged in, modprobe the
> > musb driver, and then plug in the OTG adaptor ->thumbdrive, it is not
> > enumerated.
> > 
> > Any idea why I need the OTG adapter -> thumbdrive plugged in at kernel
> > boot for it to enumerate the thumbdrive?
> 
> which board are you using ?

ok, got you. it's 35xx-based with twl4030.

when you plug the micro-a cable, see on drivers/usb/otg/twl4030-usb.c
what happens. You should have a print about the link status, see if that
is ID.

Then try something like this patch:

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 9e3e7a5..4bc5b7f 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -246,6 +246,8 @@ enum linkstat {
 };
 
 struct twl4030_usb {
+	/* used for driving or not vbus */
+	struct work_struct	work;
 	struct otg_transceiver	otg;
 	struct device		*dev;
 
@@ -347,6 +349,18 @@ twl4030_usb_clear_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
 
 /*-------------------------------------------------------------------------*/
 
+static void twl4030_vbus_work(struct work_struct *work)
+{
+	struct twl4030_usb	*twl = container_of(work, twl4030_usb, work);
+
+	if (twl->driver_vbus)
+		(void) twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
+				TWL4030_OTG_DRVVBUS);
+	else
+		(void) twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
+				TWL4030_OTG_DRVVBUS);
+}
+
 static enum linkstat twl4030_usb_linkstat(struct twl4030_usb *twl)
 {
 	int	status;
@@ -386,12 +400,16 @@ static enum linkstat twl4030_usb_linkstat(struct twl4030_usb *twl)
 	if (linkstat == USB_LINK_ID) {
 		twl->otg.default_a = true;
 		twl->otg.state = OTG_STATE_A_IDLE;
+		twl->drive_vbus = true;
 	} else {
 		twl->otg.default_a = false;
 		twl->otg.state = OTG_STATE_B_IDLE;
+		twl->driver_vbus = false;
 	}
 	spin_unlock_irq(&twl->lock);
 
+	schedule_work(&twl->vbus_work);
+
 	return linkstat;
 }
 
@@ -668,6 +686,8 @@ static int __devinit twl4030_usb_probe(struct platform_device *pdev)
 	if (!twl)
 		return -ENOMEM;
 
+	INIT_WORK(&twl->work, twl4030_vbus_work);
+
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
 	twl->otg.dev		= twl->dev;
-- 
balbi
