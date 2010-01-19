From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 04/16] USB: musb: remove some of the never defined defines
Date: Tue, 19 Jan 2010 15:14:03 +0200
Message-ID: <1263906855-28341-5-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27294 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab0ASNOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:52 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

just makes the musb init code a bit cleaner.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_core.c |   24 ------------------------
 drivers/usb/musb/musb_core.h |   16 ++++------------
 2 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 52295bc..b7e2d1b 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1314,9 +1314,6 @@ enum { MUSB_CONTROLLER_MHDRC, MUSB_CONTROLLER_HDRC, };
  */
 static int __init musb_core_init(u16 musb_type, struct musb *musb)
 {
-#ifdef MUSB_AHB_ID
-	u32 data;
-#endif
 	u8 reg;
 	char *type;
 	char aInfo[90], aRevision[32], aDate[12];
@@ -1332,19 +1329,11 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 		strcat(aInfo, ", dyn FIFOs");
 	if (reg & MUSB_CONFIGDATA_MPRXE) {
 		strcat(aInfo, ", bulk combine");
-#ifdef C_MP_RX
 		musb->bulk_combine = true;
-#else
-		strcat(aInfo, " (X)");		/* no driver support */
-#endif
 	}
 	if (reg & MUSB_CONFIGDATA_MPTXE) {
 		strcat(aInfo, ", bulk split");
-#ifdef C_MP_TX
 		musb->bulk_split = true;
-#else
-		strcat(aInfo, " (X)");		/* no driver support */
-#endif
 	}
 	if (reg & MUSB_CONFIGDATA_HBRXE) {
 		strcat(aInfo, ", HB-ISO Rx");
@@ -1360,20 +1349,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	printk(KERN_DEBUG "%s: ConfigData=0x%02x (%s)\n",
 			musb_driver_name, reg, aInfo);
 
-#ifdef MUSB_AHB_ID
-	data = musb_readl(mbase, 0x404);
-	sprintf(aDate, "%04d-%02x-%02x", (data & 0xffff),
-		(data >> 16) & 0xff, (data >> 24) & 0xff);
-	/* FIXME ID2 and ID3 are unused */
-	data = musb_readl(mbase, 0x408);
-	printk(KERN_DEBUG "ID2=%lx\n", (long unsigned)data);
-	data = musb_readl(mbase, 0x40c);
-	printk(KERN_DEBUG "ID3=%lx\n", (long unsigned)data);
-	reg = musb_readb(mbase, 0x400);
-	musb_type = ('M' == reg) ? MUSB_CONTROLLER_MHDRC : MUSB_CONTROLLER_HDRC;
-#else
 	aDate[0] = 0;
-#endif
 	if (MUSB_CONTROLLER_MHDRC == musb_type) {
 		musb->is_multipoint = 1;
 		type = "M";
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 03d5090..2ac0e6f 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -412,21 +412,13 @@ struct musb {
 	unsigned		hb_iso_rx:1;	/* high bandwidth iso rx? */
 	unsigned		hb_iso_tx:1;	/* high bandwidth iso tx? */
 
-#ifdef C_MP_TX
-	unsigned bulk_split:1;
+	unsigned		bulk_split:1;
 #define	can_bulk_split(musb,type) \
-		(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_split)
-#else
-#define	can_bulk_split(musb, type)	0
-#endif
+	(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_split)
 
-#ifdef C_MP_RX
-	unsigned bulk_combine:1;
+	unsigned		bulk_combine:1;
 #define	can_bulk_combine(musb,type) \
-		(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_combine)
-#else
-#define	can_bulk_combine(musb, type)	0
-#endif
+	(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_combine)
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	/* is_suspended means USB B_PERIPHERAL suspend */
-- 
1.6.6.rc0

