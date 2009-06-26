From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] usb: musb: Check for NULL pointers when no OTG transceiver used
Date: Fri, 26 Jun 2009 16:23:26 +0300
Message-ID: <1246022606-25923-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17600 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbZFZNYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 09:24:13 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n5QDNk8Q014351
	for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2009 08:24:18 -0500
Received: from localhost.localdomain (esdhcp036212.research.nokia.com [172.21.36.212])
	by mgw-da01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n5QDNtcU004772
	for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2009 16:23:55 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add checks to prevent NULL pointer exception in case no
OTG transceiver has been selected. i.e. musb->xceiv == NULL

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 drivers/usb/musb/musb_core.c |    3 ++-
 drivers/usb/musb/omap2430.c  |    7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 554a414..2dd6fa9 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1861,7 +1861,8 @@ static void musb_free(struct musb *musb)
 	}
 
 #ifdef CONFIG_USB_MUSB_OTG
-	put_device(musb->xceiv->dev);
+	if(musb->xceiv)
+		put_device(musb->xceiv->dev);
 #endif
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3487520..3eb8d1c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -312,9 +312,12 @@ int musb_platform_exit(struct musb *musb)
 
 	omap_vbus_power(musb, 0 /*off*/, 1);
 
-	musb_platform_suspend(musb);
+	if(musb->xceiv)
+		musb_platform_suspend(musb);
+
+	if(musb->clock)
+		clk_put(musb->clock);
 
-	clk_put(musb->clock);
 	musb->clock = 0;
 
 	return 0;
-- 
1.6.0.4

