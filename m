From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v3 2/3] omap4: opp: add OPP table data
Date: Mon, 15 Nov 2010 13:27:40 -0600
Message-ID: <1289849261-29767-3-git-send-email-nm@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757357Ab0KOT1o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 14:27:44 -0500
In-Reply-To: <[PATCH 0/3 v2] omap: opp: Add opp data>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony <tony@atomide.com>

This patch adds OPP tables for OMAP4. New file has been added to keep
the OMAP4 opp tables and the registration of these tables with the
generic opp framework by OMAP SoC OPP interface.

Based on:
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=blob;f=arch/arm/mach-omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a;hb=refs/heads/omap4_next

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Warning: http://lkml.org/lkml/2010/11/9/389
Introduces ARCH_HAS_OPP which needs to be enabled as well
for OMAP4 in Kconfig
v3:
	* switched to using device_initcall to autoinitialize the
	  opp tables
v2: https://patchwork.kernel.org/patch/266921/

 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/opp.c          |   18 +++++++++++++++++
 arch/arm/mach-omap2/opp4xxx_data.h |   37 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h           |    5 ++++
 4 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp4xxx_data.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 93a91ff..0f1855a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -45,6 +45,7 @@ config ARCH_OMAP4
 	select ARM_GIC
 	select PL310_ERRATA_588369
 	select ARM_ERRATA_720789
+ 	select PM_OPP if PM
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 79c711c..d1012bd 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -152,3 +152,21 @@ int __init omap3_opp_init(void)
 }
 device_initcall(omap3_opp_init);
 
+/* omap4 opps */
+#include "opp4xxx_data.h"
+/**
+ * omap4_opp_init() - initialize omap4 opp table
+ */
+int __init omap4_opp_init(void)
+{
+	int r = -ENODEV;
+
+	if (!cpu_is_omap44xx())
+		return r;
+
+	r = omap_init_opp_table(omap44xx_opp_def_list,
+			ARRAY_SIZE(omap44xx_opp_def_list));
+
+	return r;
+}
+device_initcall(omap4_opp_init);
diff --git a/arch/arm/mach-omap2/opp4xxx_data.h b/arch/arm/mach-omap2/opp4xxx_data.h
new file mode 100644
index 0000000..2e5fe67
--- /dev/null
+++ b/arch/arm/mach-omap2/opp4xxx_data.h
@@ -0,0 +1,37 @@
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
+ */
+
+#ifndef __ASM_PLAT_OPP_OMAP4XXX_H__
+#define __ASM_PLAT_OPP_OMAP4XXX_H__
+
+static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
+	/* MPU OPP1 - OPP50 */
+	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
+	/* MPU OPP2 - OPP100 */
+	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
+	/* MPU OPP3 - OPP-Turbo */
+	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
+	/* MPU OPP4 - OPP-SB */
+	OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
+	/* L3 OPP1 - OPP50 */
+	OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
+	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
+	OPP_INITIALIZER("l3_main_1", true, 200000000, 1100000),
+	/* TODO: add IVA, DSP, aess, fdif, gpu */
+};
+
+#endif		/*  __ASM_PLAT_OPP_OMAP4XXX_H__ */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 2031f15..a43e069 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,11 +22,16 @@ extern int omap3_idle_init(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
+extern int omap4_opp_init(void);
 #else
 static inline int omap3_opp_init(void)
 {
 	return -EINVAL;
 }
+static inline int omap4_opp_init(void)
+{
+	return -EINVAL;
+}
 #endif
 
 struct cpuidle_params {
-- 
1.6.3.3

