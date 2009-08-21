From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [DSPBRIGDE PATCH 4/6] dsp: bridge: always use dynamic major/minor numbers
Date: Fri, 21 Aug 2009 13:23:37 +0300
Message-ID: <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23750 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbZHUK0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:26:23 -0400
In-Reply-To: <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, x0095840@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

there's no reason to initialize that to 0 or use module parameters
if kernel will always get us dynamic numbers.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   25 ++++++-------------------
 1 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a283cd7..7763346 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -105,8 +105,6 @@
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
 #define DRIVER_NAME  "DspBridge"
-#define DRIVER_MAJOR 0		/* Linux assigns our Major device number */
-#define DRIVER_MINOR 0		/* Linux assigns our Major device number */
 s32 dsp_debug;
 
 /* This is a test variable used by Bridge to test different sleep states */
@@ -123,8 +121,8 @@ static u32 driverContext;
 #ifdef CONFIG_BRIDGE_DEBUG
 static char *GT_str;
 #endif /* CONFIG_BRIDGE_DEBUG */
-static s32 driver_major = DRIVER_MAJOR;
-static s32 driver_minor = DRIVER_MINOR;
+static s32 driver_major;
+static s32 driver_minor;
 static char *base_img;
 char *iva_img;
 static char *num_procs = "C55=1";
@@ -162,12 +160,6 @@ module_param(dsp_debug, int, 0);
 MODULE_PARM_DESC(dsp_debug, "Wait after loading DSP image. default = false");
 #endif
 
-module_param(driver_major, int, 0);	/* Driver's major number */
-MODULE_PARM_DESC(driver_major, "Major device number, default = 0 (auto)");
-
-module_param(driver_minor, int, 0);	/* Driver's major number */
-MODULE_PARM_DESC(driver_minor, "Minor device number, default = 0 (auto)");
-
 module_param(dsp_test_sleepstate, int, 0);
 MODULE_PARM_DESC(dsp_test_sleepstate, "DSP Sleep state = 0");
 
@@ -327,21 +319,16 @@ static int __init bridge_init(void)
 #endif
 
 	/* use 2.6 device model */
-	if (driver_major) {
-		dev = MKDEV(driver_major, driver_minor);
-		result = register_chrdev_region(dev, 1, driver_name);
-	} else {
-		result = alloc_chrdev_region(&dev, driver_minor, 1,
-					    driver_name);
-		driver_major = MAJOR(dev);
-	}
-
+	result = alloc_chrdev_region(&dev, driver_minor, 1,
+			driver_name);
 	if (result < 0) {
 		GT_1trace(driverTrace, GT_7CLASS, "bridge_init: "
 				"Can't get Major %d \n", driver_major);
 		return result;
 	}
 
+	driver_major = MAJOR(dev);
+
 	bridge_device = kmalloc(sizeof(struct bridge_dev), GFP_KERNEL);
 	if (!bridge_device) {
 		result = -ENOMEM;
-- 
1.6.3.3.385.g60647

