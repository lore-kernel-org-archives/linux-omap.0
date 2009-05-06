From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH] [PATCH] twl4030: Add some error checking to twl4030 init
Date: Wed,  6 May 2009 15:03:38 +0300
Message-ID: <1241611418-19730-1-git-send-email-amit.kucheria@verdurent.com>
References: <200904231416.37219.david-b@pacbell.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61651 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZEFMD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 08:03:56 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n46C3iTn026537
	for <linux-omap@vger.kernel.org>; Wed, 6 May 2009 15:03:50 +0300
Received: from localhost.localdomain (esdhcp041167.research.nokia.com [172.21.41.167])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n46C3clO011754
	for <linux-omap@vger.kernel.org>; Wed, 6 May 2009 15:03:39 +0300
In-Reply-To: <200904231416.37219.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Check for return values of i2c read/write operations and size of scripts being
uploaded to TWL4030

(Removed the unrelated string changes based on David Brownell's comment)

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
---
 drivers/mfd/twl4030-power.c |   52 +++++++++++++++++++++++++++++++-----------
 1 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 9dc493b..8f5d149 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -257,36 +257,40 @@ static int __init config_warmreset_sequence(u8 address)
 	return err;
 }
 
-void twl4030_configure_resource(struct twl4030_resconfig *rconfig)
+static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 {
 	int rconfig_addr;
+	int err;
 	u8 type;
 
 	if (rconfig->resource > NUM_OF_RESOURCES) {
 		printk(KERN_ERR
 			"TWL4030 Resource %d does not exist\n",
 			rconfig->resource);
-		return;
+		return -EINVAL;
 	}
 
 	rconfig_addr = res_config_addrs[rconfig->resource];
 
 	/* Set resource group */
-
 	if (rconfig->devgroup >= 0)
-		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+		err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					rconfig->devgroup << 5,
 					rconfig_addr + DEVGROUP_OFFSET);
+	if (err < 0) {
+		printk(KERN_ERR
+		       "TWL4030 failed to program devgroup");
+		return err;
+	}
 
 	/* Set resource types */
-
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
-					&type,
-					rconfig_addr + TYPE_OFFSET) < 0) {
+	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &type,
+				  rconfig_addr + TYPE_OFFSET);
+	if (err < 0) {
 		printk(KERN_ERR
-			"TWL4030 Resource %d type could not read\n",
-			rconfig->resource);
-		return;
+		       "TWL4030 Resource %d type could not be read\n",
+		       rconfig->resource);
+		return err;
 	}
 
 	if (rconfig->type >= 0) {
@@ -299,8 +303,15 @@ void twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 		type |= rconfig->type2 << 3;
 	}
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				type, rconfig_addr + TYPE_OFFSET);
+	if (err < 0) {
+		printk(KERN_ERR
+		       "TWL4030 failed to program resource type");
+		return err;
+	}
+
+	return 0;
 
 }
 
@@ -309,6 +320,12 @@ static int __init load_triton_script(struct twl4030_script *tscript)
 	u8 address = triton_next_free_address;
 	int err;
 
+	/* Make sure the script isn't going beyond last valid address */
+	if ((address + tscript->size) > (END_OF_SCRIPT-1)) {
+		printk(KERN_ERR "TWL4030 script too big error\n");
+		return -EINVAL;
+	}
+
 	err = twl4030_write_script(address, tscript->script, tscript->size);
 	if (err)
 		return err;
@@ -346,15 +363,22 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 
 	for (i = 0; i < triton2_scripts->size; i++) {
 		err = load_triton_script(triton2_scripts->scripts[i]);
-		if (err)
+		if (err < 0) {
+			printk(KERN_ERR "TWL4030 failed to load scripts");
 			break;
+		}
 	}
 
 	resconfig = triton2_scripts->resource_config;
 	if (resconfig) {
 		while (resconfig->resource) {
-			twl4030_configure_resource(resconfig);
+			err = twl4030_configure_resource(resconfig);
 			resconfig++;
+			if (err < 0) {
+				printk(KERN_ERR
+				       "TWL4030 failed to configure resource");
+				break;
+			}
 		}
 	}
 
-- 
1.6.0.4

