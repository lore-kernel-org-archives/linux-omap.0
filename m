From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 11/11] OMAP4: Add opp tables.
Date: Sat, 25 Sep 2010 18:21:26 +0530
Message-ID: <1285419086-13047-12-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45515 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab0IYMvj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 08:51:39 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds OPP tables for OMAP4. A new file
opp44xx_data.c has been introduced to keep the OMAP4
opp tables and the registeration of these tables with
the generic opp framework.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile       |    3 +-
 arch/arm/mach-omap2/opp44xx_data.c |   99 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c           |    1 +
 arch/arm/mach-omap2/pm.h           |    1 +
 4 files changed, 103 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp44xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b18d171..dce7e3b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -52,7 +52,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
 					   cpuidle34xx.o pm_bus.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o \
+					   opp44xx_data.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
diff --git a/arch/arm/mach-omap2/opp44xx_data.c b/arch/arm/mach-omap2/opp44xx_data.c
new file mode 100644
index 0000000..90aa4c4
--- /dev/null
+++ b/arch/arm/mach-omap2/opp44xx_data.c
@@ -0,0 +1,99 @@
+/*
+ * OMAP4 OPP table definitions.
+ *
+ * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ * Copyright (C) 2009 - 2010 Deep Root Systems, LLC.
+ *	Kevin Hilman
+ * Copyright (C) 2010 Nokia Corporation.
+ *      Eduardo Valentin
+ * Copyright (C) 2010 Texas Instruments Incorporated.
+ *	Thara Gopinath
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ * History:
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+
+#include <plat/opp.h>
+#include <plat/cpu.h>
+#include <plat/omap_device.h>
+
+static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
+	/* MPU OPP1 - OPP50 */
+	OMAP_OPP_DEF("mpu", true, 300000000, 930000),
+	/* MPU OPP2 - OPP100 */
+	OMAP_OPP_DEF("mpu", true, 600000000, 1100000),
+	/* MPU OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF("mpu", true, 800000000, 1260000),
+	/* MPU OPP4 - OPP-SB */
+	OMAP_OPP_DEF("mpu", true, 1008000000, 1350000),
+	/* IVA OPP1 - OPP50 */
+	OMAP_OPP_DEF("iva", true,  133000000, 930000),
+	/* IVA OPP2 - OPP100 */
+	OMAP_OPP_DEF("iva", true,  266000000, 1100000),
+	/* IVA OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF("iva", false, 332000000, 1260000),
+	/* L3 OPP1 - OPP50 */
+	OMAP_OPP_DEF("l3_main_1", true, 100000000, 930000),
+	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
+	OMAP_OPP_DEF("l3_main_1", true, 200000000, 1100000),
+};
+
+static u32 omap44xx_opp_def_size = ARRAY_SIZE(omap44xx_opp_def_list);
+
+/* Temp variable to allow multiple calls */
+static u8 __initdata omap4_table_init;
+
+
+int __init omap4_pm_init_opp_table(void)
+{
+	struct omap_opp_def *opp_def;
+	int i, r;
+
+	/*
+	 * Allow multiple calls, but initialize only if not already initalized
+	 * even if the previous call failed, coz, no reason we'd succeed again
+	 */
+	if (omap4_table_init)
+		return 0;
+
+	omap4_table_init = 1;
+
+	opp_def = omap44xx_opp_def_list;
+
+	for (i = 0; i < omap44xx_opp_def_size; i++) {
+		struct omap_hwmod *oh;
+		struct device *dev;
+
+		if (!opp_def->hwmod_name) {
+			pr_err("%s: missing name of omap_hwmod in opp data\n",
+				__func__);
+			opp_def++;
+			continue;
+		}
+
+		oh = omap_hwmod_lookup(opp_def->hwmod_name);
+		if (!oh || !oh->od) {
+			pr_warn("%s: no hwmod or odev for %s.Cannot add OPP\n",
+				__func__, opp_def->hwmod_name);
+			opp_def++;
+			continue;
+		}
+
+		dev = &oh->od->pdev.dev;
+		r = opp_add(dev, opp_def++);
+		if (r)
+			pr_err("unable to add OPP %ld Hz for %s\n",
+				opp_def->freq, opp_def->hwmod_name);
+	}
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 0e03ea0..ba5d8b2 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -208,6 +208,7 @@ static int __init omap2_common_pm_init(void)
 		omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
 		omap2_set_init_voltage("core", "l3_ick", l3_dev);
 	} else if (cpu_is_omap44xx()) {
+		omap4_pm_init_opp_table();
 		omap2_set_init_voltage("mpu", "dpll_mpu_ck", mpu_dev);
 		omap2_set_init_voltage("core", "l3_div_ck", l3_dev);
 		omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c06cedd..54d18b5 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -23,6 +23,7 @@ extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 extern int omap3_pm_init_opp_table(void);
+extern int omap4_pm_init_opp_table(void);
 
 struct cpuidle_params {
 	u8  valid;
-- 
1.7.0.4

