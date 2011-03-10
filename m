From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 04/19] OMAP4: PM: Add SAR RAM support
Date: Thu, 10 Mar 2011 19:38:00 +0530
Message-ID: <1299766095-23879-5-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50199 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab1CJOIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 09:08:41 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds SAR RAM support on OMAP4430. SAR RAM used to save
and restore the HW context in low power modes.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    1 +
 arch/arm/mach-omap2/omap4-common.c              |   31 ++++++++++++++++++++++-
 arch/arm/mach-omap2/omap4-sar-layout.h          |   22 ++++++++++++++++
 arch/arm/plat-omap/include/plat/omap44xx.h      |    1 +
 4 files changed, 54 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 106edef..284180c 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -39,6 +39,7 @@ static inline void __iomem *omap4_get_scu_base(void)
 
 extern void __iomem *omap4_get_gic_dist_base(void);
 extern void __iomem *omap4_get_gic_cpu_base(void);
+extern void __iomem *omap4_get_sar_ram_base(void);
 extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index fdacb9e..97d7d8a 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -23,13 +23,15 @@
 #include <mach/omap4-common.h>
 #include <mach/omap-wakeupgen.h>
 
+#include "omap4-sar-layout.h"
+
 #ifdef CONFIG_CACHE_L2X0
 static void __iomem *l2cache_base;
 #endif
 
 static void __iomem *gic_dist_base_addr;
 static void __iomem *gic_cpu_base;
-
+static void __iomem *sar_ram_base;
 
 void __iomem *omap4_get_gic_dist_base(void)
 {
@@ -125,3 +127,30 @@ static int __init omap_l2_cache_init(void)
 }
 early_initcall(omap_l2_cache_init);
 #endif
+
+void __iomem *omap4_get_sar_ram_base(void)
+{
+	return sar_ram_base;
+}
+
+/*
+ * SAR RAM used to save and restore the HW
+ * context in low power modes
+ */
+static int __init omap4_sar_ram_init(void)
+{
+	/*
+	 * To avoid code running on other OMAPs in
+	 * multi-omap builds
+	 */
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
+	/* Static mapping, never released */
+	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_8K);
+	if (WARN_ON(!sar_ram_base))
+		return -ENODEV;
+
+	return 0;
+}
+early_initcall(omap4_sar_ram_init);
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
new file mode 100644
index 0000000..1cfb4dd
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -0,0 +1,22 @@
+/*
+ * omap4-sar-layout.h: OMAP4 SAR RAM layout header file
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef OMAP_ARCH_OMAP4_SAR_LAYOUT_H
+#define OMAP_ARCH_OMAP4_SAR_LAYOUT_H
+
+/*
+ * SAR BANK offsets from base address OMAP44XX_SAR_RAM_BASE
+ */
+#define SAR_BANK1_OFFSET		0x0000
+#define SAR_BANK2_OFFSET		0x1000
+#define SAR_BANK3_OFFSET		0x2000
+#define SAR_BANK4_OFFSET		0x3000
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index ea2b8a6..c0d478e 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -45,6 +45,7 @@
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 #define OMAP44XX_MCPDM_BASE		0x40132000
 #define OMAP44XX_MCPDM_L3_BASE		0x49032000
+#define OMAP44XX_SAR_RAM_BASE		0x4a326000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
-- 
1.6.0.4

