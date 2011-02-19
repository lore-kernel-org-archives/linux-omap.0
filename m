From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 02/17] omap4: pm: Add SAR RAM support
Date: Sat, 19 Feb 2011 16:12:23 +0530
Message-ID: <1298112158-28469-3-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48718 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab1BSKm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 05:42:56 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds SAR RAM support on OMAP4430. SAR RAM used to save
and restore the HW context in low power modes.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c         |   25 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap4-sar-layout.h     |   24 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 3 files changed, 49 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 559d227..48484a5 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -23,12 +23,14 @@
 #include <mach/omap4-common.h>
 #include <mach/omap-wakeupgen.h>
 
+#include "omap4-sar-layout.h"
+
 #ifdef CONFIG_CACHE_L2X0
 void __iomem *l2cache_base;
 #endif
 
 void __iomem *gic_dist_base_addr;
-
+void __iomem *sar_ram_base;
 
 void __init gic_init_irq(void)
 {
@@ -107,3 +109,24 @@ static int __init omap_l2_cache_init(void)
 }
 early_initcall(omap_l2_cache_init);
 #endif
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
+	BUG_ON(!sar_ram_base);
+
+	return 0;
+}
+early_initcall(omap4_sar_ram_init);
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
new file mode 100644
index 0000000..bb66816
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -0,0 +1,24 @@
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
+extern void __iomem *sar_ram_base;
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

