From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Get rid of bridge_dev and bridge_device pointer
Date: Mon,  1 Feb 2010 21:00:16 +0200
Message-ID: <8b0800ea64a6f9cced4d0b3e1c0771b2a5cc6993.1265050008.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44174 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab0BATA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 14:00:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, deepak.chitriki@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   28 ++++++----------------------
 1 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index de79f26..d745b45 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -80,11 +80,8 @@ struct platform_device *omap_dspbridge_dev;
 
 /* This is a test variable used by Bridge to test different sleep states */
 s32 dsp_test_sleepstate;
-struct bridge_dev {
-	struct cdev cdev;
-};
 
-static struct bridge_dev *bridge_device;
+static struct cdev bridge_cdev;
 
 static struct class *bridge_class;
 
@@ -244,20 +241,14 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 	driver_major = MAJOR(dev);
 
-	bridge_device = kzalloc(sizeof(struct bridge_dev), GFP_KERNEL);
-	if (!bridge_device) {
-		result = -ENOMEM;
-		goto err2;
-	}
-	cdev_init(&bridge_device->cdev, &bridge_fops);
-	bridge_device->cdev.owner = THIS_MODULE;
-	bridge_device->cdev.ops = &bridge_fops;
+	cdev_init(&bridge_cdev, &bridge_fops);
+	bridge_cdev.owner = THIS_MODULE;
 
-	status = cdev_add(&bridge_device->cdev, dev, 1);
+	status = cdev_add(&bridge_cdev, dev, 1);
 	if (status) {
 		GT_0trace(driverTrace, GT_7CLASS,
 				"Failed to add the bridge device \n");
-		goto err3;
+		goto err2;
 	}
 
 	/* udev support */
@@ -376,12 +367,8 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 	return 0;
 
-err3:
-	kfree(bridge_device);
-
 err2:
 	unregister_chrdev_region(dev, 1);
-
 err1:
 	return result;
 }
@@ -428,10 +415,7 @@ func_cont:
 	GT_exit();
 
 	devno = MKDEV(driver_major, 0);
-	if (bridge_device) {
-		cdev_del(&bridge_device->cdev);
-		kfree(bridge_device);
-	}
+	cdev_del(&bridge_cdev);
 	unregister_chrdev_region(devno, 1);
 	if (bridge_class) {
 		/* remove the device from sysfs */
-- 
1.6.3.3

