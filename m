From: balajitk@ti.com
Subject: [PATCH v4 07/08] OMAP4: PMIC: Add support for twl6030 regulators
Date: Fri, 11 Dec 2009 21:36:42 +0530
Message-ID: <1260547602-24258-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59529 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932918AbZLKQGo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 11:06:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, Balaji T K <balajitk@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This version of patch series enables RUN TIME selection of TWL4030 or TWL6030.

This patch updates the regulator driver to add support
for TWL6030 PMIC specific LDO regulators.
SMPS resources are not yet supported for TWL6030 and
also .set_mode and .get_status for LDO's are yet to
be implemented for TWL6030.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
 drivers/regulator/Kconfig         |    2 +-
 drivers/regulator/twl-regulator.c |  116 ++++++++++++++++++++++++++++++-------
 include/linux/i2c/twl.h           |   34 +++++++++++
 3 files changed, 130 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index bcbb161..7cfdd65 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -70,7 +70,7 @@ config REGULATOR_MAX1586
 	  for PXA27x chips to control VCC_CORE and VCC_USIM voltages.
 
 config REGULATOR_TWL4030
-	bool "TI TWL4030/TWL5030/TPS695x0 PMIC"
+	bool "TI TWL4030/TWL5030/TWL6030/TPS695x0 PMIC"
 	depends on TWL4030_CORE
 	help
 	  This driver supports the voltage regulators provided by
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 8e1b68a..7ea1c3a 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -52,27 +52,38 @@ struct twlreg_info {
  * The first three registers of all power resource banks help hardware to
  * manage the various resource groups.
  */
+/* Common offset in TWL4030/6030 */
 #define VREG_GRP		0
+/* TWL4030 register offsets */
 #define VREG_TYPE		1
 #define VREG_REMAP		2
 #define VREG_DEDICATED		3	/* LDO control */
-
+/* TWL6030 register offsets */
+#define VREG_TRANS		1
+#define VREG_STATE		2
+#define VREG_VOLTAGE		3
+/* TWL6030 Misc register offsets */
+#define VREG_BC_ALL		1
+#define VREG_BC_REF		2
+#define VREG_BC_PROC		3
+#define VREG_BC_CLK_RST		4
 
 static inline int
-twlreg_read(struct twlreg_info *info, unsigned offset)
+twlreg_read(struct twlreg_info *info, unsigned slave_subgp, unsigned offset)
 {
 	u8 value;
 	int status;
 
-	status = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER,
+	status = twl_i2c_read_u8(slave_subgp,
 			&value, info->base + offset);
 	return (status < 0) ? status : value;
 }
 
 static inline int
-twlreg_write(struct twlreg_info *info, unsigned offset, u8 value)
+twlreg_write(struct twlreg_info *info, unsigned slave_subgp, unsigned offset,
+						 u8 value)
 {
-	return twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
+	return twl_i2c_write_u8(slave_subgp,
 			value, info->base + offset);
 }
 
@@ -82,17 +93,22 @@ twlreg_write(struct twlreg_info *info, unsigned offset, u8 value)
 
 static int twlreg_grp(struct regulator_dev *rdev)
 {
-	return twlreg_read(rdev_get_drvdata(rdev), VREG_GRP);
+	return twlreg_read(rdev_get_drvdata(rdev), TWL_MODULE_PM_RECEIVER,
+								 VREG_GRP);
 }
 
 /*
  * Enable/disable regulators by joining/leaving the P1 (processor) group.
  * We assume nobody else is updating the DEV_GRP registers.
  */
-
-#define P3_GRP		BIT(7)		/* "peripherals" */
-#define P2_GRP		BIT(6)		/* secondary processor, modem, etc */
-#define P1_GRP		BIT(5)		/* CPU/Linux */
+/* definition for 4030 family */
+#define P3_GRP_4030	BIT(7)		/* "peripherals" */
+#define P2_GRP_4030	BIT(6)		/* secondary processor, modem, etc */
+#define P1_GRP_4030	BIT(5)		/* CPU/Linux */
+/* definition for 6030 family */
+#define P3_GRP_6030	BIT(2)		/* secondary processor, modem, etc */
+#define P2_GRP_6030	BIT(1)		/* "peripherals" */
+#define P1_GRP_6030	BIT(0)		/* CPU/Linux */
 
 static int twlreg_is_enabled(struct regulator_dev *rdev)
 {
@@ -101,7 +117,11 @@ static int twlreg_is_enabled(struct regulator_dev *rdev)
 	if (state < 0)
 		return state;
 
-	return (state & P1_GRP) != 0;
+	if (twl_class_is_4030())
+		state &= P1_GRP_4030;
+	else
+		state &= P1_GRP_6030;
+	return state;
 }
 
 static int twlreg_enable(struct regulator_dev *rdev)
@@ -109,12 +129,16 @@ static int twlreg_enable(struct regulator_dev *rdev)
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
 
-	grp = twlreg_read(info, VREG_GRP);
+	grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
 	if (grp < 0)
 		return grp;
 
-	grp |= P1_GRP;
-	return twlreg_write(info, VREG_GRP, grp);
+	if (twl_class_is_4030())
+		grp |= P1_GRP_4030;
+	else
+		grp |= P1_GRP_6030;
+
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
 }
 
 static int twlreg_disable(struct regulator_dev *rdev)
@@ -122,18 +146,25 @@ static int twlreg_disable(struct regulator_dev *rdev)
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
 
-	grp = twlreg_read(info, VREG_GRP);
+	grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
 	if (grp < 0)
 		return grp;
 
-	grp &= ~P1_GRP;
-	return twlreg_write(info, VREG_GRP, grp);
+	if (twl_class_is_4030())
+		grp &= ~P1_GRP_4030;
+	else
+		grp &= ~P1_GRP_6030;
+
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
 }
 
 static int twlreg_get_status(struct regulator_dev *rdev)
 {
 	int	state = twlreg_grp(rdev);
 
+	if (twl_class_is_6030())
+		return 0; /* FIXME return for 6030 regulator */
+
 	if (state < 0)
 		return state;
 	state &= 0x0f;
@@ -152,6 +183,9 @@ static int twlreg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	unsigned		message;
 	int			status;
 
+	if (twl_class_is_6030())
+		return 0; /* FIXME return for 6030 regulator */
+
 	/* We can only set the mode through state machine commands... */
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
@@ -168,7 +202,7 @@ static int twlreg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	status = twlreg_grp(rdev);
 	if (status < 0)
 		return status;
-	if (!(status & (P3_GRP | P2_GRP | P1_GRP)))
+	if (!(status & (P3_GRP_4030 | P2_GRP_4030 | P1_GRP_4030)))
 		return -EACCES;
 
 	status = twl_i2c_write_u8(TWL_MODULE_PM_MASTER,
@@ -260,7 +294,29 @@ static const u16 VSIM_VSEL_table[] = {
 static const u16 VDAC_VSEL_table[] = {
 	1200, 1300, 1800, 1800,
 };
-
+static const u16 VAUX1_6030_VSEL_table[] = {
+	1000, 1300, 1800, 2500,
+	2800, 2900, 3000, 3000,
+};
+static const u16 VAUX2_6030_VSEL_table[] = {
+	1200, 1800, 2500, 2750,
+	2800, 2800, 2800, 2800,
+};
+static const u16 VAUX3_6030_VSEL_table[] = {
+	1000, 1200, 1300, 1800,
+	2500, 2800, 3000, 3000,
+};
+static const u16 VMMC_VSEL_table[] = {
+	1200, 1800, 2800, 2900,
+	3000, 3000, 3000, 3000,
+};
+static const u16 VPP_VSEL_table[] = {
+	1800, 1900, 2000, 2100,
+	2200, 2300, 2400, 2500,
+};
+static const u16 VUSIM_VSEL_table[] = {
+	1200, 1800, 2500, 2900,
+};
 
 static int twlldo_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
@@ -288,7 +344,8 @@ twlldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 
 		/* use the first in-range value */
 		if (min_uV <= uV && uV <= max_uV)
-			return twlreg_write(info, VREG_DEDICATED, vsel);
+			return twlreg_write(info, TWL_MODULE_PM_RECEIVER,
+							VREG_VOLTAGE, vsel);
 	}
 
 	return -EDOM;
@@ -297,7 +354,8 @@ twlldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 static int twlldo_get_voltage(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int			vsel = twlreg_read(info, VREG_DEDICATED);
+	int		vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
+								VREG_VOLTAGE);
 
 	if (vsel < 0)
 		return vsel;
@@ -360,6 +418,10 @@ static struct regulator_ops twlfixed_ops = {
 		TWL_ADJUSTABLE_LDO(label, offset, num, TWL4030)
 #define TWL4030_FIXED_LDO(label, offset, mVolts, num) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, TWL4030)
+#define TWL6030_ADJUSTABLE_LDO(label, offset, num) \
+		TWL_ADJUSTABLE_LDO(label, offset, num, TWL6030)
+#define TWL6030_FIXED_LDO(label, offset, mVolts, num) \
+		TWL_FIXED_LDO(label, offset, mVolts, num, TWL6030)
 
 #define TWL_ADJUSTABLE_LDO(label, offset, num, family) { \
 	.base = offset, \
@@ -420,6 +482,18 @@ static struct twlreg_info twl_regs[] = {
 	TWL4030_FIXED_LDO(VUSB1V8, 0x74, 1800, 18),
 	TWL4030_FIXED_LDO(VUSB3V1, 0x77, 3100, 19),
 	/* VUSBCP is managed *only* by the USB subchip */
+
+	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
+	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1),
+	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 2),
+	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 3),
+	TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 4),
+	TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 5),
+	TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 7),
+	TWL6030_FIXED_LDO(VANA, 0x50, 2100, 15),
+	TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 16),
+	TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 17),
+	TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 18)
 };
 
 static int twlreg_probe(struct platform_device *pdev)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 3c91ee3..dce4c22 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -391,6 +391,12 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 #define MSG_SINGULAR(devgrp, id, state) \
 	((devgrp) << 13 | 0 << 12 | (id) << 4 | (state))
 
+#define MSG_BROADCAST_ALL(devgrp, state) \
+	((devgrp) << 5 | (state))
+
+#define MSG_BROADCAST_REF MSG_BROADCAST_ALL
+#define MSG_BROADCAST_PROV MSG_BROADCAST_ALL
+#define MSG_BROADCAST__CLK_RST MSG_BROADCAST_ALL
 /*----------------------------------------------------------------------*/
 
 struct twl4030_bci_platform_data {
@@ -554,6 +560,7 @@ int twl4030_sih_setup(int module);
  * VIO is generally fixed.
  */
 
+/* TWL4030 SMPS/LDO's */
 /* EXTERNAL dc-to-dc buck converters */
 #define TWL4030_REG_VDD1	0
 #define TWL4030_REG_VDD2	1
@@ -580,4 +587,31 @@ int twl4030_sih_setup(int module);
 #define TWL4030_REG_VUSB1V8	18
 #define TWL4030_REG_VUSB3V1	19
 
+/* TWL6030 SMPS/LDO's */
+/* EXTERNAL dc-to-dc buck convertor contollable via SR */
+#define TWL6030_REG_VDD1	30
+#define TWL6030_REG_VDD2	31
+#define TWL6030_REG_VDD3	32
+
+/* Non SR compliant dc-to-dc buck convertors */
+#define	TWL6030_REG_VMEM	33
+#define TWL6030_REG_V2V1	34
+#define	TWL6030_REG_V1V29	35
+#define TWL6030_REG_V1V8	36
+
+/* EXTERNAL LDOs */
+#define TWL6030_REG_VAUX1_6030	37
+#define TWL6030_REG_VAUX2_6030	38
+#define TWL6030_REG_VAUX3_6030	39
+#define TWL6030_REG_VMMC	40
+#define TWL6030_REG_VPP		41
+#define TWL6030_REG_VUSIM	42
+#define TWL6030_REG_VANA	43
+#define TWL6030_REG_VCXIO	44
+#define TWL6030_REG_VDAC	45
+#define TWL6030_REG_VUSB	46
+
+/* INTERNAL LDOs */
+#define TWL6030_REG_VRTC	47
+
 #endif /* End of __TWL4030_H */
-- 
1.5.4.7

