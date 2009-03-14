From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 1/1] Group and resource assignments for TWL4030 (v3)
Date: Fri, 13 Mar 2009 18:16:18 -0700
Message-ID: <200903131816.18507.david-b@pacbell.net>
References: <20090306001625.GF6784@atomide.com> <1236958391-17197-1-git-send-email-peter.de-schrijver@nokia.com> <1236958391-17197-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:37709 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750827AbZCNBQd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2009 21:16:33 -0400
In-Reply-To: <1236958391-17197-2-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Group and resource assignments for TWL4030

Introduce support for board specific group assignments of TWL4030
power resources.  The resource type and type2 fields can also be
specified.

Most such power resources are regulators; this hook can be used
to ensure regulators that will never be used get properly disabled,
regardless of what the bootloader does.  Other resources include
control signals like CLKREQ and REGEN; this can properly couple
TWL CLKREQ (out) to OMAP SYSCLK_REQ (in) so retention mode works.

[ dbrownell@users.sourceforge.net: cosmetic and doc updates;
  use the RES_* constants in the regulator driver; fix buildbug ]

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Removes the build bug ... and now depends on the VPLL2 patch
that I just posted (sorry).

 drivers/mfd/Kconfig                   |   14 +++-
 drivers/mfd/twl4030-power.c           |   94 ++++++++++++++++++++++++++++++++
 drivers/regulator/twl4030-regulator.c |   40 ++++++-------
 include/linux/i2c/twl4030.h           |   39 +++++++++++++
 4 files changed, 162 insertions(+), 25 deletions(-)

--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -107,13 +107,17 @@ config TWL4030_CORE
 	  versions) and many other features.
 
 config TWL4030_POWER
-	bool "Support power sequencing scripts on TWL4030/TPS659x0"
+	bool "Support power resources on TWL4030 family chips"
 	depends on TWL4030_CORE
 	help
-	  Say yes here if you want to use the power sequencing scripts on
-	  the TWL4030/TPS659x0. These scripts control which regulators or
-	  oscillators are switched off or on or reset when a sleep, wakeup
-	  or warm reset event occurs.
+	  Say yes here if you want to use the power resources on the
+	  TWL4030 family chips.  Most of these resources are regulators,
+	  which have a separate driver; some are control signals, such
+	  as clock request handshaking.
+
+	  This driver uses board-specific data to initialize the resources
+	  and load scripts controling which resources are switched off/on
+	  or reset when a sleep, wakeup or warm reset event occurs.
 
 config MFD_TMIO
 	bool
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -38,6 +38,8 @@ static u8 triton_next_free_address = 0x2
 #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
 #define PHY_TO_OFF_PM_RECEIVER(p)	(p - 0x5b)
 
+#define NUM_OF_RESOURCES	28
+
 /* resource - hfclk */
 #define R_HFCLKOUT_DEV_GRP 	PHY_TO_OFF_PM_RECEIVER(0xe6)
 
@@ -66,6 +68,42 @@ static u8 triton_next_free_address = 0x2
 #define KEY_1			0xC0
 #define KEY_2			0x0C
 
+/* resource configuration registers */
+
+#define DEVGROUP_OFFSET		0
+#define TYPE_OFFSET		1
+
+static u8 res_config_addrs[] = {
+	[RES_VAUX1]	= 0x17,
+	[RES_VAUX2]	= 0x1b,
+	[RES_VAUX3]	= 0x1f,
+	[RES_VAUX4]	= 0x23,
+	[RES_VMMC1]	= 0x27,
+	[RES_VMMC2]	= 0x2b,
+	[RES_VPLL1]	= 0x2f,
+	[RES_VPLL2]	= 0x33,
+	[RES_VSIM]	= 0x37,
+	[RES_VDAC]	= 0x3b,
+	[RES_VINTANA1]	= 0x3f,
+	[RES_VINTANA2]	= 0x43,
+	[RES_VINTDIG]	= 0x47,
+	[RES_VIO]	= 0x4b,
+	[RES_VDD1]	= 0x55,
+	[RES_VDD2]	= 0x63,
+	[RES_VUSB_1V5]	= 0x71,
+	[RES_VUSB_1V8]	= 0x74,
+	[RES_VUSB_3V1]	= 0x77,
+	[RES_VUSBCP]	= 0x7a,
+	[RES_REGEN]	= 0x7f,
+	[RES_NRES_PWRON] = 0x82,
+	[RES_CLKEN]	= 0x85,
+	[RES_SYSEN]	= 0x88,
+	[RES_HFCLKOUT]	= 0x8b,
+	[RES_32KCLKOUT]	= 0x8e,
+	[RES_RESET]	= 0x91,
+	[RES_Main_Ref]	= 0x94,
+};
+
 static int __init twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
@@ -219,6 +257,53 @@ static int __init config_warmreset_seque
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
@@ -249,6 +334,7 @@ void __init twl4030_power_init(struct tw
 {
 	int err = 0;
 	int i;
+	struct twl4030_resconfig *resconfig;
 
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_1,
 				R_PROTECT_KEY);
@@ -264,6 +350,14 @@ void __init twl4030_power_init(struct tw
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
--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -395,30 +395,30 @@ static struct regulator_ops twl4030fixed
  * software control over them after boot.
  */
 static struct twlreg_info twl4030_regs[] = {
-	TWL_ADJUSTABLE_LDO(VAUX1, 0x17, 1),
-	TWL_ADJUSTABLE_LDO(VAUX2_4030, 0x1b, 2),
-	TWL_ADJUSTABLE_LDO(VAUX2, 0x1b, 2),
-	TWL_ADJUSTABLE_LDO(VAUX3, 0x1f, 3),
-	TWL_ADJUSTABLE_LDO(VAUX4, 0x23, 4),
-	TWL_ADJUSTABLE_LDO(VMMC1, 0x27, 5),
-	TWL_ADJUSTABLE_LDO(VMMC2, 0x2b, 6),
+	TWL_ADJUSTABLE_LDO(VAUX1, 0x17, RES_VAUX1),
+	TWL_ADJUSTABLE_LDO(VAUX2_4030, 0x1b, RES_VAUX2),
+	TWL_ADJUSTABLE_LDO(VAUX2, 0x1b, RES_VAUX2),
+	TWL_ADJUSTABLE_LDO(VAUX3, 0x1f, RES_VAUX3),
+	TWL_ADJUSTABLE_LDO(VAUX4, 0x23, RES_VAUX4),
+	TWL_ADJUSTABLE_LDO(VMMC1, 0x27, RES_VMMC1),
+	TWL_ADJUSTABLE_LDO(VMMC2, 0x2b, RES_VMMC2),
 	/*
-	TWL_ADJUSTABLE_LDO(VPLL1, 0x2f, 7),
+	TWL_ADJUSTABLE_LDO(VPLL1, 0x2f, RES_VPLL1),
 	*/
-	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, 8),
-	TWL_ADJUSTABLE_LDO(VSIM, 0x37, 9),
-	TWL_ADJUSTABLE_LDO(VDAC, 0x3b, 10),
+	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, RES_VPLL2),
+	TWL_ADJUSTABLE_LDO(VSIM, 0x37, RES_VSIM),
+	TWL_ADJUSTABLE_LDO(VDAC, 0x3b, RES_VDAC),
 	/*
-	TWL_ADJUSTABLE_LDO(VINTANA1, 0x3f, 11),
-	TWL_ADJUSTABLE_LDO(VINTANA2, 0x43, 12),
-	TWL_ADJUSTABLE_LDO(VINTDIG, 0x47, 13),
-	TWL_SMPS(VIO, 0x4b, 14),
-	TWL_SMPS(VDD1, 0x55, 15),
-	TWL_SMPS(VDD2, 0x63, 16),
+	TWL_ADJUSTABLE_LDO(VINTANA1, 0x3f, RES_VINTANA1),
+	TWL_ADJUSTABLE_LDO(VINTANA2, 0x43, RES_VINTANA1),
+	TWL_ADJUSTABLE_LDO(VINTDIG, 0x47, RES_VINTDIG),
+	TWL_SMPS(VIO, 0x4b, RES_VIO),
+	TWL_SMPS(VDD1, 0x55, RES_VDD1),
+	TWL_SMPS(VDD2, 0x63, RES_VDD2),
 	 */
-	TWL_FIXED_LDO(VUSB1V5, 0x71, 1500, 17),
-	TWL_FIXED_LDO(VUSB1V8, 0x74, 1800, 18),
-	TWL_FIXED_LDO(VUSB3V1, 0x77, 3100, 19),
+	TWL_FIXED_LDO(VUSB1V5, 0x71, 1500, RES_VUSB_1V5),
+	TWL_FIXED_LDO(VUSB1V8, 0x74, 1800, RES_VUSB_1V8),
+	TWL_FIXED_LDO(VUSB3V1, 0x77, 3100, RES_VUSB_3V1),
 	/* VUSBCP is managed *only* by the USB subchip */
 };
 
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -243,6 +243,37 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
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
+#define RES_VUSB_1V5            17
+#define RES_VUSB_1V8            18
+#define RES_VUSB_3V1            19
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
@@ -342,9 +373,17 @@ struct twl4030_script {
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
 	unsigned size;
+	const struct twl4030_resconfig *resource_config;
 };
 
 struct twl4030_platform_data {
