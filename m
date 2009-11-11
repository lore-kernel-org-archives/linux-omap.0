From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/4] Regulator: Adding header file for initializing OMAP35x PMICs
Date: Wed, 11 Nov 2009 20:14:38 +0530
Message-ID: <1257950678-32452-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57482 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbZKKOol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 09:44:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

This header file is created to provide user generic macros for
providing regulator supplies and regulator init data. Wrappers
are created using these macros which could be used in default
scenarios. In other cases, user can use the macros to provide
his own configuration information.

Wrappers are created only for TWL4030/TPS65950 right now. For
other PMICs, they will be added later on.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-omap35x-pmic.h |  191 ++++++++++++++++++++++++++++++
 1 files changed, 191 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap35x-pmic.h

diff --git a/arch/arm/mach-omap2/board-omap35x-pmic.h b/arch/arm/mach-omap2/board-omap35x-pmic.h
new file mode 100644
index 0000000..a370fdd
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap35x-pmic.h
@@ -0,0 +1,191 @@
+/*
+ * board-omap35x-pmic.h
+ *
+ * Macros to create regulator supplies and regulator init data, along with the
+ * default wrappers for various TI PMICs like TWL4030/TPS65950, TPS65023 etc.
+ *
+ * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
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
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/platform_device.h>
+#include <plat/common.h>
+
+/* Create supplies for a specific regulator */
+#define REGULATOR_COMSUMER_START(regulator) \
+	static struct regulator_consumer_supply regulator##_consumers[]
+/* Add/define supplies to the specific regulator */
+#define REGULATOR_COMSUMER_DEFINE(s, device) \
+		{ \
+			.supply = #s, \
+			.dev = device, \
+		}
+
+/* Define regulator with no supplies attached to it */
+#define REGULATOR_CONSUMER_NO_SUPPLY(regulator) \
+	REGULATOR_COMSUMER_START(regulator) = {}
+
+/* Define regulator with a single supply attached to it */
+#define REGULATOR_CONSUMER_SINGLE_SUPPLY(regulator, s, device) \
+	REGULATOR_COMSUMER_START(regulator) = { \
+	REGULATOR_COMSUMER_DEFINE(s, device), \
+	}
+
+/* Define regulator with multiple supplies attached to it like */
+	/*
+	REGULATOR_COMSUMER_START(name) = {
+	REGULATOR_COMSUMER_DEFINE(supply, device),
+	REGULATOR_COMSUMER_DEFINE(supply, device),
+	REGULATOR_COMSUMER_DEFINE(supply, device),
+	}
+	*/
+
+/* Define regulation constraints */
+#define REGULATOR_CONSTRAINTS(n, min, max, modes, ops, apply_uv_f) \
+		{ \
+			.name = #n, \
+			.min_uV	= min, \
+			.max_uV	= max, \
+			.valid_modes_mask = modes, \
+			.valid_ops_mask	= ops, \
+			.apply_uV = apply_uv_f, \
+		},
+
+/* Declare the regulator initialization data */
+#define REGULATOR_INIT_DATA_START(regulator) \
+	static struct regulator_init_data regulator##_data[]
+
+/* Populate various fields in the regulator initialization data */
+#define REGULATOR_INIT_DATA_DEFINE(regulator, n, min, max, modes, ops, \
+		apply_uv_f) \
+	{ \
+		.constraints = REGULATOR_CONSTRAINTS(n, min, max, modes, ops, \
+				apply_uv_f) \
+		.num_consumer_supplies = ARRAY_SIZE(regulator##_consumers), \
+		.consumer_supplies = regulator##_consumers, \
+	},
+
+/* Define regulator initialization data */
+#define REGULATOR_INIT_DATA(regulator, n, min, max, modes, ops, apply_uv_f) \
+	REGULATOR_INIT_DATA_START(regulator) = { \
+	REGULATOR_INIT_DATA_DEFINE(regulator, n, min, max, modes, ops, \
+			apply_uv_f) \
+	}
+
+/*
+ * Default wrappers specific to TWL4030/TPS65950 PMIC
+ */
+#if defined(CONFIG_PMIC_TWL4030) || defined(CONFIG_TWL4030_CORE)
+#define TWL_REGULATOR_MODES_DEFAULT	(REGULATOR_MODE_NORMAL | \
+					REGULATOR_MODE_STANDBY)
+#define TWL_REGULATOR_OPS_DEFAULT	(REGULATOR_CHANGE_MODE | \
+					REGULATOR_CHANGE_STATUS)
+
+/* Default supplies for TWL4030 regulators */
+#define TWL_VAUX1_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vaux1, \
+					vaux1, NULL)
+#define TWL_VAUX2_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vaux2, \
+					vaux2, NULL)
+#define TWL_VAUX3_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vaux3, \
+					vaux3, NULL)
+#define TWL_VAUX4_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vaux4, \
+					vaux4, NULL)
+
+#define TWL_VMMC1_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vmmc1, \
+					vmmc, NULL)
+#define TWL_VMMC2_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vmmc2, \
+					vmmc, NULL)
+
+#define TWL_VPLL1_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vpll1, \
+					vpll1, NULL)
+#define TWL_VPLL2_SUPPLY	REGULATOR_CONSUMER_SINGLE_SUPPLY(vpll2, \
+					vdvi, NULL)
+
+#define TWL_VSIM_SUPPLY		REGULATOR_CONSUMER_SINGLE_SUPPLY(vsim, \
+					vmmc_aux, NULL)
+#define TWL_VDAC_SUPPLY		REGULATOR_CONSUMER_SINGLE_SUPPLY(vdac, \
+					vdac, NULL)
+
+/* Default initialization data for TWL4030 regulators */
+/* VAUX1 */
+#define TWL_VAUX1_DATA	REGULATOR_INIT_DATA(vaux1, VAUX1, 2800000, 2800000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+
+/* VAUX2 */
+#define TWL_VAUX2_DATA	REGULATOR_INIT_DATA(vaux2, VAUX2, 2800000, 2800000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+
+/* VAUX3 */
+#define TWL_VAUX3_DATA	REGULATOR_INIT_DATA(vaux3, VAUX3, 2800000, 2800000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+
+/* VAUX4 */
+#define TWL_VAUX4_DATA	REGULATOR_INIT_DATA(vaux4, VAUX4, 1800000, 1800000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+
+/* VMMC1 */
+#define TWL_VMMC1_DATA	REGULATOR_INIT_DATA(vmmc1, VMMC1, 1850000, 3150000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+
+/* VMMC2 */
+#define TWL_VMMC2_DATA	REGULATOR_INIT_DATA(vmmc2, VMMC2, 1850000, 1850000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+
+/* VPLL1 */
+#define TWL_VPLL1_DATA	REGULATOR_INIT_DATA(vpll1, VPLL1, 1300000, 1300000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+
+/* VPLL2 */
+#define TWL_VPLL2_DATA	REGULATOR_INIT_DATA(vpll2, VDVI, 1800000, 1800000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						false)
+
+/* VSIM */
+#define TWL_VSIM_DATA	REGULATOR_INIT_DATA(vsim, VSIM, 1800000, 3000000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						false)
+
+/* VDAC */
+#define TWL_VDAC_DATA	REGULATOR_INIT_DATA(vdac, VDAC, 1800000, 1800000, \
+						TWL_REGULATOR_MODES_DEFAULT, \
+						TWL_REGULATOR_OPS_DEFAULT, \
+						true)
+#endif	/* CONFIG_PMIC_TWL4030 || CONFIG_TWL4030_CORE */
+
+/*
+ * Definitions specific to TPS65023
+ */
+#if defined(CONFIG_PMIC_TPS65023)
+#endif	/* CONFIG_PMIC_TPS65023 */
+
+/*
+ * Definitions specific to TPS65073
+ */
+#if defined(CONFIG_PMIC_TPS65073)
+#endif	/* CONFIG_PMIC_TPS65073 */
-- 
1.6.2.4

