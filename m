From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] cbus: tahvo: Remove dead code from tahvo-usb.c
Date: Tue, 19 Apr 2011 11:19:53 +0300
Message-ID: <1303201193-11516-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64623 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab1DSIR4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 04:17:56 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1619314eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 01:17:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

Looks like this code was ever used. It was added by commit
fe3702054f6412aea04373ceb9d27a4a417ff3f0 "OMAP: Fix USB on Nokia 770"
that can be found from linux-omap history if needed.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 drivers/cbus/tahvo-usb.c |   48 +---------------------------------------------
 1 files changed, 1 insertions(+), 47 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index f6b3c1a..be0333f 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -236,47 +236,6 @@ static DEVICE_ATTR(vbus_state, 0444, vbus_state_show, NULL);
 
 int vbus_active = 0;
 
-#if 0
-
-static int host_suspend(struct tahvo_usb *tu)
-{
-	struct device	*dev;
-
-	if (!tu->otg.host)
-		return -ENODEV;
-
-	/* Currently ASSUMES only the OTG port matters;
-	 * other ports could be active...
-	 */
-	dev = tu->otg.host->controller;
-	return dev->driver->suspend(dev, PMSG_SUSPEND);
-}
-
-static int host_resume(struct tahvo_usb *tu)
-{
-	struct device	*dev;
-
-	if (!tu->otg.host)
-		return -ENODEV;
-
-	dev = tu->otg.host->controller;
-	return dev->driver->resume(dev);
-}
-
-#else
-
-static int host_suspend(struct tahvo_usb *tu)
-{
-	return 0;
-}
-
-static int host_resume(struct tahvo_usb *tu)
-{
-	return 0;
-}
-
-#endif
-
 static void check_vbus_state(struct tahvo_usb *tu)
 {
 	int reg, prev_state;
@@ -303,7 +262,6 @@ static void check_vbus_state(struct tahvo_usb *tu)
 		case OTG_STATE_A_IDLE:
 			/* Session is now valid assuming the USB hub is driving Vbus */
 			tu->otg.state = OTG_STATE_A_HOST;
-			host_resume(tu);
 			break;
 		default:
 			break;
@@ -355,7 +313,6 @@ static void tahvo_usb_become_host(struct tahvo_usb *tu)
 
 static void tahvo_usb_stop_host(struct tahvo_usb *tu)
 {
-	host_suspend(tu);
 	tu->otg.state = OTG_STATE_A_IDLE;
 }
 
@@ -403,8 +360,6 @@ static void tahvo_usb_power_off(struct tahvo_usb *tu)
 	if (tu->otg.gadget)
 		usb_gadget_vbus_disconnect(tu->otg.gadget);
 
-	host_suspend(tu);
-
 	/* Disable OTG and interrupts */
 	if (TAHVO_MODE(tu) == TAHVO_MODE_PERIPHERAL)
 		id = OTG_ID;
@@ -521,8 +476,7 @@ static int tahvo_usb_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 	if (TAHVO_MODE(tu) == TAHVO_MODE_HOST) {
 		tu->otg.host = NULL;
 		tahvo_usb_become_host(tu);
-	} else
-		host_suspend(tu);
+	}
 
 	tu->otg.host = host;
 
-- 
1.7.4.1

