From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/4] OMAP3: OPP: add OPP table data and initialization
Date: Wed, 15 Sep 2010 14:56:39 -0700
Message-ID: <1284587799-9637-5-git-send-email-khilman@deeprootsystems.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40264 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0IOV4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 17:56:51 -0400
Received: by pwi3 with SMTP id 3so268828pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 14:56:50 -0700 (PDT)
In-Reply-To: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Add OPP data for OMAP34xx and OMAP36xx and initialization functions
to populate OPP tables based on current SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile       |    2 +
 arch/arm/mach-omap2/opp3xxx_data.c |  126 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c           |    6 ++
 arch/arm/mach-omap2/pm.h           |    1 +
 4 files changed, 135 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 88d3a1e..33acca9 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -57,6 +57,8 @@ obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
 
+obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
+
 endif
 
 # PRCM
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
new file mode 100644
index 0000000..df0bfa0
--- /dev/null
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -0,0 +1,126 @@
+/*
+ * OMAP3 resource init/change_level/validate_level functions
+ *
+ * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ * Copyright (C) 2009 - 2010 Deep Root Systems, LLC.
+ *	Kevin Hilman
+ * Copyright (C) 2010 Nokia Corporation.
+ *      Eduardo Valentin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ * History:
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+
+#include <plat/opp.h>
+#include <plat/cpu.h>
+
+static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
+	/* MPU OPP1 */
+	OMAP_OPP_DEF("mpu", true, 125000000, 975000),
+	/* MPU OPP2 */
+	OMAP_OPP_DEF("mpu", true, 250000000, 1075000),
+	/* MPU OPP3 */
+	OMAP_OPP_DEF("mpu", true, 500000000, 1200000),
+	/* MPU OPP4 */
+	OMAP_OPP_DEF("mpu", true, 550000000, 1270000),
+	/* MPU OPP5 */
+	OMAP_OPP_DEF("mpu", true, 600000000, 1350000),
+
+	/*
+	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
+	 * almost the same than the one at 83MHz thus providing very little
+	 * gain for the power point of view. In term of energy it will even
+	 * increase the consumption due to the very negative performance
+	 * impact that frequency will do to the MPU and the whole system in
+	 * general.
+	 */
+	OMAP_OPP_DEF("l3_main", false, 41500000, 975000),
+	/* L3 OPP2 */
+	OMAP_OPP_DEF("l3_main", true, 83000000, 1050000),
+	/* L3 OPP3 */
+	OMAP_OPP_DEF("l3_main", true, 166000000, 1150000),
+
+
+	/* DSP OPP1 */
+	OMAP_OPP_DEF("iva", true, 90000000, 975000),
+	/* DSP OPP2 */
+	OMAP_OPP_DEF("iva", true, 180000000, 1075000),
+	/* DSP OPP3 */
+	OMAP_OPP_DEF("iva", true, 360000000, 1200000),
+	/* DSP OPP4 */
+	OMAP_OPP_DEF("iva", true, 400000000, 1270000),
+	/* DSP OPP5 */
+	OMAP_OPP_DEF("iva", true, 430000000, 1350000),
+};
+static u32 omap34xx_opp_def_size = ARRAY_SIZE(omap34xx_opp_def_list);
+
+static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
+	/* MPU OPP1 - OPP50 */
+	OMAP_OPP_DEF("mpu", true,  300000000, 930000),
+	/* MPU OPP2 - OPP100 */
+	OMAP_OPP_DEF("mpu", true,  600000000, 1100000),
+	/* MPU OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF("mpu", false, 800000000, 1260000),
+	/* MPU OPP4 - OPP-SB */
+	OMAP_OPP_DEF("mpu", false, 1000000000, 1350000),
+
+	/* L3 OPP1 - OPP50 */
+	OMAP_OPP_DEF("l3_main", true, 100000000, 930000),
+	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
+	OMAP_OPP_DEF("l3_main", true, 200000000, 1137500),
+
+	/* DSP OPP1 - OPP50 */
+	OMAP_OPP_DEF("iva", true,  260000000, 930000),
+	/* DSP OPP2 - OPP100 */
+	OMAP_OPP_DEF("iva", true,  520000000, 1100000),
+	/* DSP OPP3 - OPP-Turbo */
+	OMAP_OPP_DEF("iva", false, 660000000, 1260000),
+	/* DSP OPP4 - OPP-SB */
+	OMAP_OPP_DEF("iva", false, 800000000, 1350000),
+};
+static u32 omap36xx_opp_def_size = ARRAY_SIZE(omap36xx_opp_def_list);
+
+/* Temp variable to allow multiple calls */
+static u8 __initdata omap3_table_init;
+
+int __init omap3_pm_init_opp_table(void)
+{
+	struct omap_opp_def *opp_def, *omap3_opp_def_list;
+	u32 omap3_opp_def_size;
+	int i, r;
+
+	/*
+	 * Allow multiple calls, but initialize only if not already initalized
+	 * even if the previous call failed, coz, no reason we'd succeed again
+	 */
+	if (omap3_table_init)
+		return 0;
+	omap3_table_init = 1;
+
+	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
+		omap34xx_opp_def_list;
+	omap3_opp_def_size = cpu_is_omap3630() ? omap36xx_opp_def_size :
+		omap34xx_opp_def_size;
+
+	opp_def = omap3_opp_def_list;
+	for (i = 0; i < omap3_opp_def_size; i++) {
+		r = opp_add(opp_def++);
+		if (r)
+			pr_err("unable to add OPP %ld Hz for %s\n",
+			       opp_def->freq, opp_def->hwmod_name);
+	}
+
+	return 0;
+}
+
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 68f9f2e..4ea59df 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,6 +18,8 @@
 #include <plat/omap_device.h>
 #include <plat/common.h>
 
+#include "pm.h"
+
 static struct omap_device_pm_latency *pm_lats;
 
 static struct device *mpu_dev;
@@ -76,6 +78,10 @@ static void omap2_init_processor_devices(void)
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
+
+	if (cpu_is_omap34xx())
+		omap3_pm_init_opp_table();
+
 	omap_pm_if_init();
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 3de6ece..9c9f943 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,6 +22,7 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+extern int omap3_pm_init_opp_table(void);
 
 struct cpuidle_params {
 	u8  valid;
-- 
1.7.2.1

