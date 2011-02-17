From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 11/12] usb: musb: OMAP4430: Fix usb device detection if connected during boot
Date: Thu, 17 Feb 2011 14:38:48 +0200
Message-ID: <1297946329-9353-12-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51193 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932092Ab1BQMjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:39:33 -0500
In-Reply-To: <1297946329-9353-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Hema HK <hemahk@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

OMAP4430 is embedded with UTMI PHY. This PHY does not support the
OTG features like ID pin detection and VBUS detection. This function
is exported to an external companion chip TWL6030. Software must retrieve
the OTG HNP and SRP status from the TWL6030 and configure the bits inside
the control module that drive the related USBOTGHS UTMI interface signals.
It must also read back the UTMI signals needed to configure the TWL6030
OTG module.

Can find more details in the TRM[1].
[1]:http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.0_Public_TRM_vJ.pdf

In OMAP4430 musb driver VBUS and ID notifications are received from the
transceiver driver. If the cable/device is connected during boot,
notifications from transceiver driver will be missed till musb driver
is loaded.
Patch to configure the transceiver in the platform_enable/disable
functions and enable the vbus in the gadget driver based on the
last_event of the otg_transceiver.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_gadget.c |    4 +++
 drivers/usb/musb/omap2430.c    |   53 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 0f59bf9..95fbacc 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1877,6 +1877,10 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 		if (retval < 0) {
 			DBG(1, "add_hcd failed, %d\n", retval);
 			goto err2;
+
+			if ((musb->xceiv->last_event == USB_EVENT_ID)
+						&& musb->xceiv->set_vbus)
+				otg_set_vbus(musb->xceiv, 1);
 		}
 
 		hcd->self.uses_pio_for_control = 1;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index bb6e6cd..64cf243 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -328,16 +328,56 @@ static int omap2430_musb_init(struct musb *musb)
 	if (status)
 		DBG(1, "notification register failed\n");
 
-	/* check whether cable is already connected */
-	if (musb->xceiv->state ==OTG_STATE_B_IDLE)
-		musb_otg_notifications(&musb->nb, 1,
-					musb->xceiv->gadget);
-
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
 	return 0;
 }
 
+static void omap2430_musb_enable(struct musb *musb)
+{
+	u8		devctl;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
+	struct omap_musb_board_data *data = pdata->board_data;
+
+	switch (musb->xceiv->last_event) {
+
+	case USB_EVENT_ID:
+		otg_init(musb->xceiv);
+		if (data->interface_type == MUSB_INTERFACE_UTMI) {
+			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+			/* start the session */
+			devctl |= MUSB_DEVCTL_SESSION;
+			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+			while (musb_readb(musb->mregs, MUSB_DEVCTL) &
+						MUSB_DEVCTL_BDEVICE) {
+				cpu_relax();
+
+				if (time_after(jiffies, timeout)) {
+					dev_err(musb->controller,
+					"configured as A device timeout");
+					break;
+				}
+			}
+		}
+		break;
+
+	case USB_EVENT_VBUS:
+		otg_init(musb->xceiv);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void omap2430_musb_disable(struct musb *musb)
+{
+	if (musb->xceiv->last_event)
+		otg_shutdown(musb->xceiv);
+}
+
 static int omap2430_musb_exit(struct musb *musb)
 {
 
@@ -355,6 +395,9 @@ static const struct musb_platform_ops omap2430_ops = {
 	.try_idle	= omap2430_musb_try_idle,
 
 	.set_vbus	= omap2430_musb_set_vbus,
+
+	.enable		= omap2430_musb_enable,
+	.disable	= omap2430_musb_disable,
 };
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
-- 
1.7.4.rc2

