From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 10/23] USB: MUSB: checkpatch.pl fixes to musb_gadget.c
Date: Fri, 11 Apr 2008 11:28:23 +0300
Message-ID: <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40666 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757408AbYDKIaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:10 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8U5RQ016374
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:08 +0300
In-Reply-To: <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_gadget.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 0fb9635..303b6f6 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -321,8 +321,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 					csr |= (MUSB_TXCSR_DMAENAB |
 							MUSB_TXCSR_MODE);
 					/* against programming guide */
-				}
-				else
+				} else
 					csr |= (MUSB_TXCSR_AUTOSET
 							| MUSB_TXCSR_DMAENAB
 							| MUSB_TXCSR_DMAMODE
@@ -812,7 +811,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		}
 
 		/* incomplete, and not short? wait for next IN packet */
-                if ((request->actual < request->length)
+		if ((request->actual < request->length)
 				&& (musb_ep->dma->actual_len
 					== musb_ep->packet_sz))
 			goto done;
@@ -1482,7 +1481,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 #if 0
 static int musb_gadget_vbus_session(struct usb_gadget *gadget, int is_active)
 {
-	DBG(2, "<= %s =>\n", __FUNCTION__);
+	DBG(2, "<= %s =>\n", __func__);
 
 	/*
 	 * FIXME iff driver's softconnect flag is set (as it is during probe,
@@ -1543,7 +1542,7 @@ static struct musb *the_gadget;
 static void musb_gadget_release(struct device *dev)
 {
 	/* kref_put(WHAT) */
-	dev_dbg(dev, "%s\n", __FUNCTION__);
+	dev_dbg(dev, "%s\n", __func__);
 }
 
 
@@ -1689,7 +1688,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	/* driver must be initialized to support peripheral mode */
 	if (!musb || !(musb->board_mode == MUSB_OTG
 				|| musb->board_mode != MUSB_OTG)) {
-		DBG(1,"%s, no dev??\n", __FUNCTION__);
+		DBG(1, "%s, no dev??\n", __func__);
 		return -ENODEV;
 	}
 
@@ -1803,7 +1802,7 @@ static void stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 		}
 
 		spin_unlock(&musb->lock);
-		driver->disconnect (&musb->g);
+		driver->disconnect(&musb->g);
 		spin_lock(&musb->lock);
 	}
 }
-- 
1.5.5.23.g2a5fe

