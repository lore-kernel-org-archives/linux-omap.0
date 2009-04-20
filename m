From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH] twl4030: Add some error checking to twl4030 init
Date: Tue, 21 Apr 2009 00:28:06 +0300
Message-ID: <1240262886-24538-1-git-send-email-amit.kucheria@verdurent.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CCA98FDA@dbde02.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:35946 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbZDTV2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 17:28:15 -0400
Received: by bwz7 with SMTP id 7so1451648bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 14:28:12 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CCA98FDA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Whitespace-fixed version and passed through checkpatch.pl

Check for return values of i2c read/write operations and size of scripts being
uploaded to TWL4030

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
---
 drivers/mfd/twl4030-core.c  |    2 +-
 drivers/mfd/twl4030-power.c |   49 ++++++++++++++++++++++++++++++------------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index 769b34b..067b02e 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -358,7 +358,7 @@ EXPORT_SYMBOL(twl4030_i2c_read);
 int twl4030_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
 {
 
-	/* 2 bytes offset 1 contains the data offset 0 is used by i2c_write */
+	/* 2 bytes: offset 1 contains the data, offset 0 is used by i2c_write */
 	u8 temp_buffer[2] = { 0 };
 	/* offset 1 contains the data */
 	temp_buffer[1] = value;
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 9dc493b..b4b636d 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -257,36 +257,38 @@ static int __init config_warmreset_sequence(u8 address)
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
+		printk(KERN_ERR "TWL4030 failed to program devgroup");
+		return err;
+	}
 
 	/* Set resource types */
-
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
-					&type,
-					rconfig_addr + TYPE_OFFSET) < 0) {
-		printk(KERN_ERR
-			"TWL4030 Resource %d type could not read\n",
+	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &type,
+				  rconfig_addr + TYPE_OFFSET);
+	if (err < 0) {
+		printk(KERN_ERR "TWL4030 Resource %d type could not be read\n",
 			rconfig->resource);
-		return;
+		return err;
 	}
 
 	if (rconfig->type >= 0) {
@@ -299,8 +301,14 @@ void twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 		type |= rconfig->type2 << 3;
 	}
 
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 				type, rconfig_addr + TYPE_OFFSET);
+	if (err < 0) {
+		printk(KERN_ERR "TWL4030 failed to program resource type");
+		return err;
+	}
+
+	return 0;
 
 }
 
@@ -309,6 +317,12 @@ static int __init load_triton_script(struct twl4030_script *tscript)
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
@@ -346,15 +360,22 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 
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
+					"TWL4030 failed to configure resource");
+				break;
+			}
 		}
 	}
 
-- 
1.6.0.4

