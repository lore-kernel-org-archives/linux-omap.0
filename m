From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Get rid of driver_minor global variable
Date: Mon,  1 Feb 2010 20:18:04 +0200
Message-ID: <8a14e4992a92e3bc31d518ca71b14f214cf0f764.1265048264.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38367 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab0BASSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 13:18:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, deepak.chitriki@ti.com

Since there is only 1 device there is no need of driver_minor global variable.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a02a32a..de79f26 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -93,7 +93,6 @@ static u32 driverContext;
 static char *GT_str;
 #endif /* CONFIG_BRIDGE_DEBUG */
 static s32 driver_major;
-static s32 driver_minor;
 static char *base_img;
 char *iva_img;
 static s32 shm_size = 0x500000;	/* 5 MB */
@@ -236,7 +235,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	omap_dspbridge_dev = pdev;
 
 	/* use 2.6 device model */
-	result = alloc_chrdev_region(&dev, driver_minor, 1, driver_name);
+	result = alloc_chrdev_region(&dev, 0, 1, driver_name);
 	if (result < 0) {
 		GT_1trace(driverTrace, GT_7CLASS, "bridge_init: "
 				"Can't get Major %d \n", driver_major);
@@ -268,7 +267,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 		GT_0trace(driverTrace, GT_7CLASS,
 				"Error creating bridge class \n");
 
-	device_create(bridge_class, NULL, MKDEV(driver_major, driver_minor),
+	device_create(bridge_class, NULL, MKDEV(driver_major, 0),
 			NULL, "DspBridge");
 
 	GT_init();
@@ -428,7 +427,7 @@ func_cont:
 	SERVICES_Exit();
 	GT_exit();
 
-	devno = MKDEV(driver_major, driver_minor);
+	devno = MKDEV(driver_major, 0);
 	if (bridge_device) {
 		cdev_del(&bridge_device->cdev);
 		kfree(bridge_device);
@@ -436,7 +435,7 @@ func_cont:
 	unregister_chrdev_region(devno, 1);
 	if (bridge_class) {
 		/* remove the device from sysfs */
-		device_destroy(bridge_class, MKDEV(driver_major, driver_minor));
+		device_destroy(bridge_class, MKDEV(driver_major, 0));
 		class_destroy(bridge_class);
 
 	}
-- 
1.6.3.3

