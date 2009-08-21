From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
Date: Fri, 21 Aug 2009 13:23:39 +0300
Message-ID: <1250850219-25545-7-git-send-email-felipe.balbi@nokia.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65335 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301AbZHUK0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:26:05 -0400
In-Reply-To: <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, x0095840@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

... and get rid of a possible memory leak.

in case of error while adding the chardev, probe()
would not kfree() bridge_device.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 559d14a..c37c5a0 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -324,7 +324,7 @@ static int __init bridge_init(void)
 	if (result < 0) {
 		GT_1trace(driverTrace, GT_7CLASS, "bridge_init: "
 				"Can't get Major %d \n", driver_major);
-		return result;
+		goto err1;
 	}
 
 	driver_major = MAJOR(dev);
@@ -332,19 +332,17 @@ static int __init bridge_init(void)
 	bridge_device = kmalloc(sizeof(struct bridge_dev), GFP_KERNEL);
 	if (!bridge_device) {
 		result = -ENOMEM;
-		unregister_chrdev_region(dev, 1);
-		return result;
+		goto err2;
 	}
 	cdev_init(&bridge_device->cdev, &bridge_fops);
 	bridge_device->cdev.owner = THIS_MODULE;
 	bridge_device->cdev.ops = &bridge_fops;
 
 	status = cdev_add(&bridge_device->cdev, dev, 1);
-
 	if (status) {
 		GT_0trace(driverTrace, GT_7CLASS,
 				"Failed to add the bridge device \n");
-		return status;
+		goto err3;
 	}
 
 	/* udev support */
@@ -474,7 +472,17 @@ static int __init bridge_init(void)
 	DBC_Assert(status == 0);
 	DBC_Assert(DSP_SUCCEEDED(initStatus));
 	GT_0trace(driverTrace, GT_ENTER, " <- driver_init\n");
-	return status;
+
+	return 0;
+
+err3:
+	kfree(bridge_device);
+
+err2:
+	unregister_chrdev_region(dev, 1);
+
+err1:
+	return result;
 }
 
 /*  This function is invoked during unlinking of the bridge module from the
-- 
1.6.3.3.385.g60647

