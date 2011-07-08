From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 1/4] twl-regulator: extend for SMPS regulators and external controllers
Date: Fri, 8 Jul 2011 18:56:25 +0300
Message-ID: <1310140588-26078-2-git-send-email-t-kristo@ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53859 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab1GHP5G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:57:06 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com, Thomas Petazzoni <t-petazzoni@ti.com>

This commit adds two things to the TWL regulator driver code :

 * It extends the twl4030_set_voltage() and twl4030_get_voltage()
   functions to understand that VDD1 and VDD2 are different regulators
   from all the other regulators: they don't support a fixed set of
   voltages, but a wide range of voltages between two minimum and
   maximum limits.

 * It creates a twlreg_ext_ctrl structure, which allows code outside
   of the TWL regulator driver to implement a regulator
   controller. Such a controller is attached using the new
   twlreg_attach_external_controller() function of the driver. When
   such a controller is attached to a regulator, the ->set_voltage()
   and ->get_voltage() calls made on the regulator will be forwarded
   to the external controller. This facility will later be used to
   integrate the Voltage Controller and SmartReflex features of the
   OMAP CPU with this regulator driver.

TODO:

 * Create a proper mechanism to handle SMPS regulators instead of
   special casing VDD1/VDD2. Probably by creating a new regulator
   type, next to FIXED_LDO and ADJUSTABLE_LDO.

 * See if other methods than ->set_voltage() and ->get_voltage() need
   to be captured by the external controller.

 * Extend to TWL6030.

 * See if instead of using a late-binding method using
   twlreg_attach_external_controller(), it could be possible to pass
   the twlreg_ext_ctrl structure through the
   regulator_init_data->driver_data field. For the moment, this isn't
   possible since the OMAP voltage layer isn't initialized when the
   regulator is instantiated.

 * Make the twl-regulator driver actually work with VDD1/VDD2 when no
   external controller is attached (i.e, when the OMAP voltage layer
   code is disabled).

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Thomas Petazzoni <t-petazzoni@ti.com>
---
 drivers/regulator/twl-regulator.c |   74 ++++++++++++++++++++++++++++++++++++-
 include/linux/regulator/twl.h     |   37 ++++++++++++++++++
 2 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/regulator/twl.h

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 87fe0f7..2d8546d 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
+#include <linux/regulator/twl.h>
 
 
 /*
@@ -58,6 +59,9 @@ struct twlreg_info {
 
 	/* chip specific features */
 	unsigned long 		features;
+
+	/* external controller */
+	struct twlreg_ext_ctrl	*ext_ctrl;
 };
 
 
@@ -71,6 +75,7 @@ struct twlreg_info {
 #define VREG_TYPE		1
 #define VREG_REMAP		2
 #define VREG_DEDICATED		3	/* LDO control */
+#define VREG_VSEL		9	/* SMPS voltage */
 /* TWL6030 register offsets */
 #define VREG_TRANS		1
 #define VREG_STATE		2
@@ -465,6 +470,22 @@ twl4030ldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			vsel;
 
+	/* An external controller is controlling us */
+	if (info->ext_ctrl && info->ext_ctrl->set_voltage) {
+		*selector = 0;
+		return info->ext_ctrl->set_voltage(info->ext_ctrl, min_uV,
+			max_uV);
+	}
+
+	/* Handle SMPS regulators separatly */
+	if (info->desc.id == TWL4030_REG_VDD1 ||
+	    info->desc.id == TWL4030_REG_VDD2) {
+		int vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
+		twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VSEL, vsel);
+		*selector = 0;
+		return 0;
+	}
+
 	for (vsel = 0; vsel < info->table_len; vsel++) {
 		int mV = info->table[vsel];
 		int uV;
@@ -489,8 +506,22 @@ twl4030ldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
 static int twl4030ldo_get_voltage(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int		vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
-								VREG_VOLTAGE);
+	int vsel;
+
+	/* An external controller is controlling us */
+	if (info->ext_ctrl && info->ext_ctrl->get_voltage)
+		return info->ext_ctrl->get_voltage(info->ext_ctrl);
+
+	/* Handle SMPS regulators separatly */
+	if (info->desc.id == TWL4030_REG_VDD1 ||
+	    info->desc.id == TWL4030_REG_VDD2) {
+		vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
+				   VREG_VSEL);
+		return (((vsel * 125) + 6000)) * 100;
+	}
+
+	vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
+			   VREG_VOLTAGE);
 
 	if (vsel < 0)
 		return vsel;
@@ -1007,6 +1038,45 @@ static u8 twl_get_smps_mult(void)
 	return value;
 }
 
+int twlreg_attach_external_controller(const char *name,
+				      struct twlreg_ext_ctrl *ext_ctrl)
+{
+	struct twlreg_info *info = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(twl_regs); i++) {
+		if (!strcmp(twl_regs[i].desc.name, name)) {
+			info = twl_regs + i;
+			break;
+		}
+	}
+
+	if (!info)
+		return -ENOENT;
+
+	info->ext_ctrl = ext_ctrl;
+	return 0;
+}
+
+int twlreg_remove_external_controller(const char *name)
+{
+	struct twlreg_info *info = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(twl_regs); i++) {
+		if (!strcmp(twl_regs[i].desc.name, name)) {
+			info = twl_regs + i;
+			break;
+		}
+	}
+
+	if (!info)
+		return -ENOENT;
+
+	info->ext_ctrl = NULL;
+	return 0;
+}
+
 static int __devinit twlreg_probe(struct platform_device *pdev)
 {
 	int				i;
diff --git a/include/linux/regulator/twl.h b/include/linux/regulator/twl.h
new file mode 100644
index 0000000..a27a8e9
--- /dev/null
+++ b/include/linux/regulator/twl.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2008 Thomas Petazzoni
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_REGULATOR_TWL_H
+#define __LINUX_REGULATOR_TWL_H
+
+/*
+ * twlreg_ext_ctrl allows to define an external controller for TWL
+ * regulators. Such an external controller can be attached to the
+ * .driver_data field of the regulator_init_data structure when
+ * instantiating a TWL regulator. It is useful in situations where the
+ * TWL regulator is not directly controlled by software, but is
+ * controlled by another separate piece of hardware. The TWL regulator
+ * driver will forward the set_voltage/get_voltage calls to the
+ * external controller driver, so that from a regulator consumer
+ * perspective, the fact that the regulator is controlled is a special
+ * way remains transparent.
+ */
+struct twlreg_ext_ctrl {
+	int (*set_voltage)(struct twlreg_ext_ctrl *twl_ext_ctrl,
+			   int min_uV, int max_uV);
+	int (*get_voltage)(struct twlreg_ext_ctrl *twl_ext_ctrl);
+	void *data;
+};
+
+int twlreg_attach_external_controller(const char *name,
+				      struct twlreg_ext_ctrl *ext_ctrl);
+int twlreg_remove_external_controller(const char *name);
+
+#endif /* __LINUX_REGULATOR_TWL_H */
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

