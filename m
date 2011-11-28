From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 6/7] regulator: twl: add support for external controller
Date: Mon, 28 Nov 2011 16:53:24 +0200
Message-ID: <1322492005-27741-7-git-send-email-t-kristo@ti.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38542 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab1K1Oy2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 09:54:28 -0500
In-Reply-To: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

TWL regulator now has two alternative control paths: the default
I2C path or an optional voltage processor path for OMAP chips.
If the voltage processor path should be used, this can be
indicated within the platform data by adding flag TWL_VP_SMPS_MODE
to regulator_init_data->driver_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 drivers/regulator/twl-regulator.c |   39 ++++++++++++++++++++++++++++++------
 include/linux/i2c/twl.h           |    1 +
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 11cc308..b674ae4 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 
+#include <plat/voltage.h>
 
 /*
  * The TWL4030/TW5030/TPS659x0/TWL6030 family chips include power management, a
@@ -37,6 +38,12 @@ struct twlreg_info {
 	/* twl resource ID, for resource control state machine */
 	u8			id;
 
+	/* voltagedomain, only used for VP controlled smps regulators */
+	union {
+		const char		*name;
+		struct voltagedomain	*ptr;
+	} voltdm;
+
 	/* voltage in mV = table[VSEL]; table_len must be a power-of-two */
 	u8			table_len;
 	const u16		*table;
@@ -520,17 +527,28 @@ twl4030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
 			unsigned *selector)
 {
 	struct twlreg_info *info = rdev_get_drvdata(rdev);
-	int vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
 
-	twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS_4030,
-		vsel);
+	if (info->voltdm.ptr)
+		voltdm_scale(info->voltdm.ptr, min_uV);
+	else {
+		int vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
+
+		twlreg_write(info, TWL_MODULE_PM_RECEIVER,
+			VREG_VOLTAGE_SMPS_4030, vsel);
+	}
+
 	return 0;
 }
 
 static int twl4030smps_get_voltage(struct regulator_dev *rdev)
 {
 	struct twlreg_info *info = rdev_get_drvdata(rdev);
-	int vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
+	int vsel;
+
+	if (info->voltdm.ptr)
+		return voltdm_get_voltage(info->voltdm.ptr);
+
+	vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
 		VREG_VOLTAGE_SMPS_4030);
 
 	return vsel * 12500 + 600000;
@@ -883,9 +901,13 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
-#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf) \
+#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, voltdm_name, turnon_delay, \
+	remap_conf) \
 	{ \
 	.base = offset, \
+	.voltdm = { \
+		.name = #voltdm_name, \
+	}, \
 	.id = num, \
 	.delay = turnon_delay, \
 	.remap = remap_conf, \
@@ -989,8 +1011,8 @@ static struct twlreg_info twl_regs[] = {
 	TWL4030_ADJUSTABLE_LDO(VINTANA2, 0x43, 12, 100, 0x08),
 	TWL4030_FIXED_LDO(VINTDIG, 0x47, 1500, 13, 100, 0x08),
 	TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08),
-	TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08),
-	TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08),
+	TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, mpu_iva, 1000, 0x08),
+	TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, core, 1000, 0x08),
 	TWL4030_FIXED_LDO(VUSB1V5, 0x71, 1500, 17, 100, 0x08),
 	TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18, 100, 0x08),
 	TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19, 150, 0x08),
@@ -1091,6 +1113,9 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
 		break;
 	}
 
+	if (info->voltdm.name && info->features & TWL_VP_SMPS_MODE)
+		info->voltdm.ptr = voltdm_lookup(info->voltdm.name);
+
 	switch (pdev->id) {
 	case TWL6025_REG_SMPS3:
 		if (twl_get_smps_mult() & SMPS_MULTOFFSET_SMPS3)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 114c0f6..17000e2 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -172,6 +172,7 @@ TWL_CLASS_IS(4030, TWL4030_CLASS_ID)
 TWL_CLASS_IS(6030, TWL6030_CLASS_ID)
 
 #define TWL6025_SUBCLASS	BIT(4)  /* TWL6025 has changed registers */
+#define TWL_VP_SMPS_MODE	BIT(5)	/* Use VP control path for SMPS regs */
 
 /*
  * Read and write single 8-bit registers
-- 
1.7.4.1

