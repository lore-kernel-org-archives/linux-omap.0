From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH][DSPBRIDGE] Add the device after driver initialization
Date: Tue, 28 Apr 2009 14:31:43 +0300
Message-ID: <1240918303-16888-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43857 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbZD1Lbm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 07:31:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, x00omar@ti.com

From: Ameya Palande <ameya.palande@nokia.com>

This prevents a panic caused by an IOCTL call before driver
completes its initialization.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 9466409..b562513 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -298,14 +298,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	bridge_device->cdev.owner = THIS_MODULE;
 	bridge_device->cdev.ops = &bridge_fops;
 
-	status = cdev_add(&bridge_device->cdev, dev, 1);
-
-	if (status) {
-		GT_0trace(driverTrace, GT_7CLASS,
-				"Failed to add the bridge device \n");
-		return status;
-	}
-
 	/* udev support */
 	bridge_class = class_create(THIS_MODULE, "ti_bridge");
 
@@ -429,6 +421,12 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 		} else {
 			GT_0trace(driverTrace, GT_5CLASS,
 					"DSP/BIOS Bridge driver loaded\n");
+			/* Announce to kernel that we are ready */
+			status = cdev_add(&bridge_device->cdev, dev, 1);
+			if (status) {
+				GT_0trace(driverTrace, GT_7CLASS,
+				"Failed to add the bridge device \n");
+			}
 		}
 	}
 
-- 
1.6.2.4

