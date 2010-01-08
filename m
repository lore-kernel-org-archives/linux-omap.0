From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/6] Regulator: Creating TWL4030 specific file having supplies & init data
Date: Fri,  8 Jan 2010 23:27:43 +0530
Message-ID: <1262973463-32492-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58362 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab0AHR5w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 12:57:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

A new file for TWL4030/TPS65950 is created which has common supplies
and regulator init data structures. They will be referenced from the
various board-evm files depending upon the EVM requirements.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c |  175 ++++++++++++++++++++++
 1 files changed, 175 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c

diff --git a/arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c b/arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c
new file mode 100644
index 0000000..0b7cd74
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c
@@ -0,0 +1,175 @@
+/*
+ * board-omap35x-twl4030-pmic.c
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
+struct regulator_init_data vaux1_data = {
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
+struct regulator_init_data vaux2_data = {
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
+struct regulator_init_data vaux3_data = {
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
+struct regulator_init_data vaux4_data = {
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
+struct regulator_init_data vmmc1_data = {
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
+struct regulator_init_data vmmc2_data = {
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
+struct regulator_init_data vsim_data = {
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
+struct regulator_init_data vdac_data = {
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
+struct regulator_init_data vpll2_data = {
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
-- 
1.6.2.4

