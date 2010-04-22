From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 03/11] mfd: Add support for remapping twl4030-power power states
Date: Thu, 22 Apr 2010 11:07:35 +0300
Message-ID: <1271923663-23668-4-git-send-email-eduardo.valentin@nokia.com>
References: <1271923663-23668-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21544 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab0DVII5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 04:08:57 -0400
In-Reply-To: <1271923663-23668-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Core-Review <core-review@ok.research.nokia.com>
Cc: "\\\"Hogander Jouni (Nokia-D/Tampere)\\\"" <jouni.hogander@nokia.com>, "\\\"Koskinen Aaro (Nokia-D/Helsinki)\\\"" <aaro.koskinen@nokia.com>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

From: Amit Kucheria <amit.kucheria@verdurent.com>

The <RESOURCE>_REMAP register allows configuration of the <RESOURCE> in case
of a sleep or off transition.

Allow this property of resources to be configured (through twl4030_resconfig)
and add code to parse these values to program the registers accordingly.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030.h |    3 +++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 2bec947..08bfe40 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -80,6 +80,8 @@ static u8 twl4030_start_script_address = 0x2b;
 */
 #define DEV_GRP_OFFSET		0
 #define TYPE_OFFSET		1
+#define REMAP_OFFSET		2
+#define DEDICATED_OFFSET	3
 
 /* Bit positions in the registers */
 
@@ -93,6 +95,12 @@ static u8 twl4030_start_script_address = 0x2b;
 #define TYPE2_SHIFT		3
 #define TYPE2_MASK		(3 << TYPE2_SHIFT)
 
+/* <RESOURCE>_REMAP */
+#define SLEEP_STATE_SHIFT	0
+#define SLEEP_STATE_MASK	(0xf << SLEEP_STATE_SHIFT)
+#define OFF_STATE_SHIFT		4
+#define OFF_STATE_MASK		(0xf << OFF_STATE_SHIFT)
+
 static u8 res_config_addrs[] = {
 	[RES_VAUX1]	= 0x17,
 	[RES_VAUX2]	= 0x1b,
@@ -330,6 +338,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	int err;
 	u8 type;
 	u8 grp;
+	u8 remap;
 
 	if (rconfig->resource > TOTAL_RESOURCES) {
 		pr_err("TWL4030 Resource %d does not exist\n",
@@ -385,6 +394,33 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 		return err;
 	}
 
+	/* Set remap states */
+	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &remap,
+				rconfig_addr + REMAP_OFFSET);
+	if (err < 0) {
+		pr_err("TWL4030 Resource %d remap could not be read\n",
+			rconfig->resource);
+		return err;
+	}
+
+	if (rconfig->remap_off >= 0) {
+		remap &= ~OFF_STATE_MASK;
+		remap |= rconfig->remap_off << OFF_STATE_SHIFT;
+	}
+
+	if (rconfig->remap_sleep >= 0) {
+		remap &= ~SLEEP_STATE_MASK;
+		remap |= rconfig->remap_off << SLEEP_STATE_SHIFT;
+	}
+
+	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				remap,
+				rconfig_addr + REMAP_OFFSET);
+	if (err < 0) {
+		pr_err("TWL4030 failed to program remap\n");
+		return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index a0be421..eabc1d7 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -298,6 +298,7 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
 #define RES_TYPE_ALL		0x7
 
+/* Resource states */
 #define RES_STATE_WRST		0xF
 #define RES_STATE_ACTIVE	0xE
 #define RES_STATE_SLEEP		0x8
@@ -449,6 +450,8 @@ struct twl4030_resconfig {
 	u8 devgroup;	/* Processor group that Power resource belongs to */
 	u8 type;	/* Power resource addressed, 6 / broadcast message */
 	u8 type2;	/* Power resource addressed, 3 / broadcast message */
+	u8 remap_off;	/* off state remapping */
+	u8 remap_sleep;	/* sleep state remapping */
 };
 
 struct twl4030_power_data {
-- 
1.7.0.4.361.g8b5fe.dirty

