From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3 v2] omap4: opp: add OPP table data
Date: Tue, 19 Oct 2010 20:02:22 -0500
Message-ID: <1287536543-9729-3-git-send-email-nm@ti.com>
References: <1287536543-9729-1-git-send-email-nm@ti.com>
 <1287536543-9729-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003Ab0JTBC0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 21:02:26 -0400
In-Reply-To: <1287536543-9729-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@deeprootsystems.com>, Tony <tony@atomide.com>, Nishanth Menon <nm@ti.com>

This patch adds OPP tables for OMAP4. New file has been added to keep
the OMAP4 opp tables and the registration of these tables with the
generic opp framework by OMAP SoC OPP interface.

Based on:
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=blob;f=arch/arm/mach-omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a;hb=refs/heads/omap4_next

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
[nm@ti.com: cleaned up, synced to latest code, removed iva,dsp,gpu,aess
as these hwmods are not added yet to l-o for-next. Retaining Thara's
attribution]

 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/opp.c          |    6 ++++-
 arch/arm/mach-omap2/opp4xxx_data.h |   37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp4xxx_data.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3eb367a..12fefdb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select PM_OPP if PM
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 9342986..2266c1f 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -61,6 +61,7 @@ struct omap_opp_def {
 }
 
 #include "opp3xxx_data.h"
+#include "opp4xxx_data.h"
 
 /* Temp variable to allow multiple calls */
 static u8 __initdata omap_table_init;
@@ -86,7 +87,10 @@ int __init omap_init_opp_table(void)
 	omap_table_init = 1;
 
 	/* Select the OPP table we'd like to enable based on cpu we are on */
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap44xx()) {
+		opp_def = omap44xx_opp_def_list;
+		opp_def_size = ARRAY_SIZE(omap44xx_opp_def_list);
+	} else if (cpu_is_omap34xx()) {
 		opp_def = cpu_is_omap3630() ? omap36xx_opp_def_list :
 			omap34xx_opp_def_list;
 		opp_def_size = cpu_is_omap3630() ?
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
-- 
1.6.3.3

