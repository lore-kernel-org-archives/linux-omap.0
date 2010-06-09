From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: reorganize probe function
Date: Tue,  8 Jun 2010 19:48:13 -0500
Message-ID: <1276044493-23003-3-git-send-email-omar.ramirez@ti.com>
References: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756497Ab0FIAzc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jun 2010 20:55:32 -0400
In-Reply-To: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Renaming and deleting unused variables, few enhancement on
error path.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index f80b15b..16a74c4 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -335,9 +335,8 @@ err1:
 
 static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 {
-	int status;
+	int err;
 	dev_t dev = 0;
-	int result;
 #ifdef CONFIG_BRIDGE_DVFS
 	int i = 0;
 #endif
@@ -348,43 +347,46 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 	bridge = &omap_dspbridge_dev->dev;
 
 	/* Bridge low level initializations */
-	status = omap3_bridge_startup(pdev);
-	if (status)
+	err = omap3_bridge_startup(pdev);
+	if (err)
 		goto err1;
 
 	/* use 2.6 device model */
-	result = alloc_chrdev_region(&dev, 0, 1, driver_name);
-	if (result < 0) {
+	err = alloc_chrdev_region(&dev, 0, 1, driver_name);
+	if (err) {
 		pr_err("%s: Can't get major %d\n", __func__, driver_major);
 		goto err1;
 	}
 
-	driver_major = MAJOR(dev);
-
 	cdev_init(&bridge_cdev, &bridge_fops);
 	bridge_cdev.owner = THIS_MODULE;
 
-	status = cdev_add(&bridge_cdev, dev, 1);
-	if (status) {
+	err = cdev_add(&bridge_cdev, dev, 1);
+	if (err) {
 		pr_err("%s: Failed to add bridge device\n", __func__);
 		goto err2;
 	}
 
 	/* udev support */
 	bridge_class = class_create(THIS_MODULE, "ti_bridge");
-
-	if (IS_ERR(bridge_class))
+	if (IS_ERR(bridge_class)) {
 		pr_err("%s: Error creating bridge class\n", __func__);
+		goto err3;
+	}
 
+	driver_major = MAJOR(dev);
 	device_create(bridge_class, NULL, MKDEV(driver_major, 0),
 		      NULL, "DspBridge");
+	pr_info("DSP Bridge driver loaded\n");
 
 	return 0;
 
+err3:
+	cdev_del(&bridge_cdev);
 err2:
 	unregister_chrdev_region(dev, 1);
 err1:
-	return result;
+	return err;
 }
 
 static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
-- 
1.7.1

