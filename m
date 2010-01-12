From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCHv2 1/4] Regulator: OMAP: Creating TWL4030 file having supplies & init data
Date: Tue, 12 Jan 2010 14:43:52 +0530
Message-ID: <1263287632-10135-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55266 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665Ab0ALJOB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jan 2010 04:14:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

A new file for TWL4030/TPS65950 is created which has common supplies
and regulator init data structures. They will be referenced from the
various board-evm files depending upon the EVM requirements, using
the twl4030-pmic.h header file.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/twl4030-pmic.c |  175 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030-pmic.h |   34 +++++++
 2 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-pmic.c
 create mode 100644 arch/arm/mach-omap2/twl4030-pmic.h

diff --git a/arch/arm/mach-omap2/twl4030-pmic.c b/arch/arm/mach-omap2/twl4030-pmic.c
new file mode 100644
index 0000000..0c0a860
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030-pmic.c
@@ -0,0 +1,175 @@
+/*
+ * twl4030-pmic.c
+ *
+ * Common regulator supplies and init data structs for TWL4030/TPS65950
+ * PMIC for OMAP3 based EVMs. They can be used in various board-evm
+ * files for OMAP3 based platforms using TWL4030.
+ *
+ * Copyright (C) 2010 Texas Instrument Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/regulator/machine.h>
+
+/* VDAC */
+struct regulator_consumer_supply twl4030_vdac_supply = {
+	.supply	= "vdac",
+};
+
+/* VMMC1 */
+struct regulator_consumer_supply twl4030_vmmc1_supply = {
+	.supply	= "vmmc",
+};
+
+/* VMMC2 */
+struct regulator_consumer_supply twl4030_vmmc2_supply = {
+	.supply	= "vmmc",
+};
+
+/* VSIM */
+struct regulator_consumer_supply twl4030_vsim_supply = {
+	.supply	= "vmmc_aux",
+};
+
+/* VPLL2 for digital video outputs */
+struct regulator_consumer_supply twl4030_vpll2_supply = {
+	.supply	= "vdvi",
+};
+
+/* Regulator initialization data */
+/* VAUX1 */
+struct regulator_init_data twl4030_vaux1_data = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VAUX2 */
+struct regulator_init_data twl4030_vaux2_data = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VAUX3 */
+struct regulator_init_data twl4030_vaux3_data = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VAUX4 */
+struct regulator_init_data twl4030_vaux4_data = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VMMC1 */
+struct regulator_init_data twl4030_vmmc1_data = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &twl4030_vmmc1_supply,
+};
+
+/* VMMC2 */
+struct regulator_init_data twl4030_vmmc2_data = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 1850000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &twl4030_vmmc2_supply,
+};
+
+/* VSIM */
+struct regulator_init_data twl4030_vsim_data = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 3000000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &twl4030_vsim_supply,
+};
+
+/* VDAC */
+struct regulator_init_data twl4030_vdac_data = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &twl4030_vdac_supply,
+};
+
+/* VPLL2 */
+struct regulator_init_data twl4030_vpll2_data = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &twl4030_vpll2_supply,
+};
+
diff --git a/arch/arm/mach-omap2/twl4030-pmic.h b/arch/arm/mach-omap2/twl4030-pmic.h
new file mode 100644
index 0000000..7a863d6
--- /dev/null
+++ b/arch/arm/mach-omap2/twl4030-pmic.h
@@ -0,0 +1,34 @@
+/*
+ * twl4030-pmic.h
+ *
+ * Header for common regulator supplies and init data structs for
+ * TWL4030/TPS65950 PMIC for OMAP3 based EVMs.
+ *
+ * Copyright (C) 2010 Texas Instrument Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+extern struct regulator_consumer_supply twl4030_vdac_supply;
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vmmc2_supply;
+extern struct regulator_consumer_supply twl4030_vsim_supply;
+extern struct regulator_consumer_supply twl4030_vpll2_supply;
+
+extern struct regulator_init_data twl4030_vaux1_data;
+extern struct regulator_init_data twl4030_vaux2_data;
+extern struct regulator_init_data twl4030_vaux3_data;
+extern struct regulator_init_data twl4030_vaux4_data;
+extern struct regulator_init_data twl4030_vmmc1_data;
+extern struct regulator_init_data twl4030_vmmc2_data;
+extern struct regulator_init_data twl4030_vsim_data;
+extern struct regulator_init_data twl4030_vdac_data;
+extern struct regulator_init_data twl4030_vpll2_data;
+
-- 
1.6.2.4

