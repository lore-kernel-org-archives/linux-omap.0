From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH][DSPBRIDGE][v2] Add the device after driver initialization
Date: Tue, 28 Apr 2009 16:15:54 +0300
Message-ID: <1240924554-26025-1-git-send-email-ameya.palande@nokia.com>
References: <1240918303-16888-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26786 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785AbZD1NP5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 09:15:57 -0400
In-Reply-To: <1240918303-16888-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com

From: Ameya Palande <ameya.palande@nokia.com>

This prevents a panic caused by an IOCTL call before driver completes its
initialization.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 9466409..79f75c9 100755
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
 
@@ -328,14 +320,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_init\n");
 
-#ifdef CONFIG_PM
-	/* Initialize the wait queue */
-	if (!status) {
-		bridge_suspend_data.suspended = 0;
-		init_waitqueue_head(&bridge_suspend_data.suspend_wq);
-	}
-#endif
-
 	SERVICES_Init();
 
 	/*  Autostart flag.  This should be set to true if the DSP image should
@@ -429,6 +413,19 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 		} else {
 			GT_0trace(driverTrace, GT_5CLASS,
 					"DSP/BIOS Bridge driver loaded\n");
+			/* Announce to kernel that we are ready */
+			status = cdev_add(&bridge_device->cdev, dev, 1);
+			if (status) {
+				GT_0trace(driverTrace, GT_7CLASS,
+				"Failed to add the bridge device \n");
+			}
+			else {
+				#ifdef CONFIG_PM
+				/* Initialize the wait queue */
+				bridge_suspend_data.suspended = 0;
+				init_waitqueue_head(&bridge_suspend_data.suspend_wq);
+				#endif
+			}
 		}
 	}
 
-- 
1.6.2.4

