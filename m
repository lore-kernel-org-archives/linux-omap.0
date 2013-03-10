From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/7] usb: otg: twl4030-usb: don't enable PHY during init
Date: Sun, 10 Mar 2013 03:07:55 +0200
Message-ID: <1362877681-8102-2-git-send-email-notasas@gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:52787 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3CJBQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 20:16:21 -0500
In-Reply-To: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>

There is no need to do it, otg.set_suspend(false) (which itself
comes from runtime_pm OMAP glue calls) will enable it later anyway.
This used to be the place where things were enabled if booted with
cable connected before runtime_pm conversion, but now can be dropped.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/otg/twl4030-usb.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index a994715..1515c0b 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -522,19 +522,17 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 {
 	enum omap_musb_vbus_id_status status;
 
-	status = twl4030_usb_linkstat(twl);
-	if (status > 0) {
-		if (status == OMAP_MUSB_VBUS_OFF ||
-				status == OMAP_MUSB_ID_FLOAT) {
-			__twl4030_phy_power(twl, 0);
-			twl->asleep = 1;
-		} else {
-			__twl4030_phy_resume(twl);
-			twl->asleep = 0;
-		}
+	/*
+	 * Start in sleep state, we'll get called through set_suspend()
+	 * callback when musb is runtime resumed and it's time to start.
+	 */
+	__twl4030_phy_power(twl, 0);
+	twl->asleep = 1;
 
+	status = twl4030_usb_linkstat(twl);
+	if (status > 0)
 		omap_musb_mailbox(twl->linkstat);
-	}
+
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 }
 
@@ -649,9 +647,6 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	/* Power down phy or make it work according to
-	 * current link state.
-	 */
 	twl4030_usb_phy_init(twl);
 
 	dev_info(&pdev->dev, "Initialized TWL4030 USB module\n");
-- 
1.7.9.5

