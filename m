From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/1] Group and resource assignments for TWL4030
Date: Fri, 13 Mar 2009 17:33:11 +0200
Message-ID: <1236958391-17197-2-git-send-email-peter.de-schrijver@nokia.com>
References: <20090306001625.GF6784@atomide.com>
 <1236958391-17197-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46979 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744AbZCMPd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 11:33:27 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2DFX6QN010471
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 10:33:24 -0500
In-Reply-To: <1236958391-17197-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/mfd/twl4030-power.c |   96 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/twl4030.h |   41 ++++++++++++++++++-
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index d9d1655..f1d416c 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -38,6 +38,8 @@ static u8 triton_next_free_address = 0x2b;
 #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
 #define PHY_TO_OFF_PM_RECEIVER(p)	(p - 0x5b)
 
+#define NUM_OF_RESOURCES	28
+
 /* resource - hfclk */
 #define R_HFCLKOUT_DEV_GRP 	PHY_TO_OFF_PM_RECEIVER(0xe6)
 
@@ -66,6 +68,42 @@ static u8 triton_next_free_address = 0x2b;
 #define KEY_1			0xC0
 #define KEY_2			0x0C
 
+/* resource configuration registers */
+
+#define DEVGROUP_OFFSET		0
+#define TYPE_OFFSET		1
+
+static int res_config_addrs[] = {
+	[RES_VAUX1] = 0x17,
+	[RES_VAUX2] = 0x1b,
+	[RES_VAUX3] = 0x1f,
+	[RES_VAUX4] = 0x23,
+	[RES_VMMC1] = 0x27,
+	[RES_VMMC2] = 0x2b,
+	[RES_VPLL1] = 0x2f,
+	[RES_VPLL2] = 0x33,
+	[RES_VSIM] = 0x37,
+	[RES_VDAC] = 0x3b,
+	[RES_VINTANA1] = 0x3f,
+	[RES_VINTANA2] = 0x43,
+	[RES_VINTDIG] = 0x47,
+	[RES_VIO] = 0x4b,
+	[RES_VDD1] = 0x55,
+	[RES_VDD2] = 0x63,
+	[RES_VUSB_1v5] = 0x71,
+	[RES_VUSB_1v8] = 0x74,
+	[RES_VUSB_3v1] = 0x77,
+	[RES_VUSBCP] = 0x7a,
+	[RES_REGEN] = 0x7f,
+	[RES_NRES_PWRON] = 0x82,
+	[RES_CLKEN] = 0x85,
+	[RES_SYSEN] = 0x88,
+	[RES_HFCLKOUT] = 0x8b,
+	[RES_32KCLKOUT] = 0x8e,
+	[RES_RESET] = 0x91,
+	[RES_Main_Ref] = 0x94,
+};
+
 static int __init twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
@@ -219,6 +257,53 @@ static int __init config_warmreset_sequence(u8 address)
 	return err;
 }
 
+void twl4030_configure_resource(struct twl4030_resconfig *rconfig)
+{
+	int rconfig_addr;
+	u8 type;
+
+	if (rconfig->resource > NUM_OF_RESOURCES) {
+		printk(KERN_ERR
+			"TWL4030 Resource %d does not exist\n",
+			rconfig->resource);
+		return;
+	}
+
+	rconfig_addr = res_config_addrs[rconfig->resource];
+
+	/* Set resource group */
+
+	if (rconfig->devgroup >= 0)
+		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+					rconfig->devgroup << 5,
+					rconfig_addr + DEVGROUP_OFFSET);
+
+	/* Set resource types */
+
+	if (twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
+					&type,
+					rconfig_addr + TYPE_OFFSET) < 0) {
+		printk(KERN_ERR
+			"TWL4030 Resource %d type could not read\n",
+			rconfig->resource);
+		return;
+	}
+
+	if (rconfig->type >= 0) {
+		type &= ~7;
+		type |= rconfig->type;
+	}
+
+	if (rconfig->type2 >= 0) {
+		type &= ~(3 << 3);
+		type |= rconfig->type2 << 3;
+	}
+
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				type, rconfig_addr + TYPE_OFFSET);
+
+}
+
 static int __init load_triton_script(struct twl4030_script *tscript)
 {
 	u8 address = triton_next_free_address;
@@ -249,6 +334,7 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 {
 	int err = 0;
 	int i;
+	struct twl4030_resconfig *resconfig;
 
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_1,
 				R_PROTECT_KEY);
@@ -258,12 +344,20 @@ void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 		printk(KERN_ERR
 			"TWL4030 Unable to unlock registers\n");
 
-	for (i = 0; i < triton2_scripts->size; i++) {
+	for (i = 0; i < triton2_scripts->scripts_size; i++) {
 		err = load_triton_script(triton2_scripts->scripts[i]);
 		if (err)
 			break;
 	}
 
+	resconfig = triton2_scripts->resource_config;
+	if (resconfig) {
+		while (resconfig->resource) {
+			twl4030_configure_resource(resconfig);
+			resconfig++;
+		}
+	}
+
 	if (twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY))
 		printk(KERN_ERR
 			"TWL4030 Unable to relock registers\n");
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 17bd400..efa7af1 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -243,6 +243,37 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 #define RES_STATE_SLEEP		0x8
 #define RES_STATE_OFF		0x0
 
+/* Power resources */
+
+#define RES_VAUX1               1
+#define RES_VAUX2               2
+#define RES_VAUX3               3
+#define RES_VAUX4               4
+#define RES_VMMC1               5
+#define RES_VMMC2               6
+#define RES_VPLL1               7
+#define RES_VPLL2               8
+#define RES_VSIM                9
+#define RES_VDAC                10
+#define RES_VINTANA1            11
+#define RES_VINTANA2            12
+#define RES_VINTDIG             13
+#define RES_VIO                 14
+#define RES_VDD1                15
+#define RES_VDD2                16
+#define RES_VUSB_1v5            17
+#define RES_VUSB_1v8            18
+#define RES_VUSB_3v1            19
+#define RES_VUSBCP              20
+#define RES_REGEN               21
+#define RES_NRES_PWRON          22
+#define RES_CLKEN               23
+#define RES_SYSEN               24
+#define RES_HFCLKOUT            25
+#define RES_32KCLKOUT           26
+#define RES_RESET               27
+#define RES_Main_Ref            28
+
 /*
  * Power Bus Message Format ... these can be sent individually by Linux,
  * but are usually part of downloaded scripts that are run when various
@@ -334,9 +365,17 @@ struct twl4030_script {
 #define TRITON_SLEEP_SCRIPT	(1<<3)
 };
 
+struct twl4030_resconfig {
+	u8 resource;
+	u8 devgroup;
+	u8 type;
+	u8 type2;
+};
+
 struct twl4030_power_data {
 	struct twl4030_script **scripts;
-	unsigned size;
+	unsigned scripts_size;
+	struct twl4030_resconfig *resource_config;
 };
 
 struct twl4030_platform_data {
-- 
1.5.6.3

