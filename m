From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] usb: musb: fix hanging when rmmod gadget driver
Date: Mon,  4 Aug 2008 13:53:52 +0300
Message-ID: <1217847232-1653-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65232 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbYHDKxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 06:53:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>

If we try to modprobe a second gadget driver before
rmmoding the first one, the reference for the first
gadget driver would get NULLed avoiding usb to change
gadget drivers later.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_gadget.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index b3773f1..d6a802c 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1710,17 +1710,15 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	if (retval == 0)
+	if (retval == 0) {
 		retval = driver->bind(&musb->g);
-	if (retval != 0) {
-		DBG(3, "bind to driver %s failed --> %d\n",
-			driver->driver.name, retval);
-		musb->gadget_driver = NULL;
-		musb->g.dev.driver = NULL;
-	}
+		if (retval != 0) {
+			DBG(3, "bind to driver %s failed --> %d\n",
+					driver->driver.name, retval);
+			musb->gadget_driver = NULL;
+			musb->g.dev.driver = NULL;
+		}
 
-	/* start peripheral and/or OTG engines */
-	if (retval == 0) {
 		spin_lock_irqsave(&musb->lock, flags);
 
 		/* REVISIT always use otg_set_peripheral(), handling
-- 
1.6.0.rc1.11.g1ce47

